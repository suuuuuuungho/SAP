import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}

function json(body: unknown, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json; charset=utf-8' },
  })
}

async function sha256(value: string) {
  const digest = await crypto.subtle.digest('SHA-256', new TextEncoder().encode(value))
  return Array.from(new Uint8Array(digest), (byte) => byte.toString(16).padStart(2, '0')).join('')
}

async function hmacSha256Hex(secret: string, value: string) {
  const key = await crypto.subtle.importKey(
    'raw',
    new TextEncoder().encode(secret),
    { name: 'HMAC', hash: 'SHA-256' },
    false,
    ['sign'],
  )
  const signature = await crypto.subtle.sign('HMAC', key, new TextEncoder().encode(value))
  return Array.from(new Uint8Array(signature), (byte) => byte.toString(16).padStart(2, '0')).join('')
}

function normalizePhone(value: string) {
  return value.replace(/\D/g, '')
}

function randomCode() {
  const values = new Uint32Array(1)
  crypto.getRandomValues(values)
  return String(100000 + (values[0] % 900000))
}

async function sendSolapiSms(to: string, code: string) {
  const apiKey = Deno.env.get('SOLAPI_API_KEY')
  const apiSecret = Deno.env.get('SOLAPI_API_SECRET')
  const sender = normalizePhone(Deno.env.get('SOLAPI_SENDER_NUMBER') || '')
  if (!apiKey || !apiSecret || !sender) throw new Error('SOLAPI secrets are missing')

  const date = new Date().toISOString()
  const salt = crypto.randomUUID()
  const signature = await hmacSha256Hex(apiSecret, date + salt)
  const response = await fetch('https://api.solapi.com/messages/v4/send', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `HMAC-SHA256 apiKey=${apiKey}, date=${date}, salt=${salt}, signature=${signature}`,
    },
    body: JSON.stringify({
      message: {
        to,
        from: sender,
        text: `[SAP] 비밀번호 변경 인증번호는 ${code}입니다. 3분 안에 입력해 주세요.`,
      },
    }),
  })

  if (!response.ok) {
    console.error('[reset-password-no-email] SOLAPI', response.status, await response.text())
    throw new Error('SOLAPI send failed')
  }
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  if (req.method !== 'POST') return json({ ok: false, message: '잘못된 요청입니다.' }, 405)

  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')
  if (!supabaseUrl || !serviceKey) return json({ ok: false, message: '서버 설정을 확인해주세요.' }, 500)

  const admin = createClient(supabaseUrl, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  })
  const body = await req.json().catch(() => ({}))
  const action = String(body.action || '')
  const ip = (req.headers.get('x-forwarded-for') || req.headers.get('cf-connecting-ip') || 'unknown').split(',')[0].trim()

  if (action === 'send') {
    const username = String(body.username || '').trim()
    const name = String(body.name || '').trim()
    const phone = normalizePhone(String(body.phone || ''))
    if (!username || !name || phone.length < 10) return json({ ok: false, message: '가입 정보를 정확히 입력해주세요.' })

    const [usernameHash, phoneHash, ipHash] = await Promise.all([
      sha256(username.toLowerCase()),
      sha256(phone),
      sha256(ip),
    ])
    const since = new Date(Date.now() - 15 * 60 * 1000).toISOString()
    const { count } = await admin
      .from('password_reset_attempts')
      .select('id', { count: 'exact', head: true })
      .or(`username_hash.eq.${usernameHash},ip_hash.eq.${ipHash}`)
      .gte('attempted_at', since)
    if ((count || 0) >= 5) return json({ ok: false, message: '요청이 너무 많습니다. 15분 후 다시 시도해주세요.' })
    await admin.from('password_reset_attempts').insert({ username_hash: usernameHash, ip_hash: ipHash })

    const { data: recent } = await admin
      .from('password_reset_challenges')
      .select('created_at')
      .eq('phone_hash', phoneHash)
      .gte('created_at', new Date(Date.now() - 60 * 1000).toISOString())
      .limit(1)
    if (recent?.length) return json({ ok: false, message: '인증번호는 1분 후 다시 받을 수 있습니다.' })

    const { data: profile } = await admin
      .from('profiles')
      .select('id, name, phone')
      .ilike('username', username)
      .maybeSingle()
    const matches = profile && profile.name.trim() === name && normalizePhone(profile.phone) === phone
    const challengeId = crypto.randomUUID()
    const code = randomCode()
    const codeHash = await sha256(`${challengeId}:${code}:${serviceKey}`)
    const expiresAt = new Date(Date.now() + 3 * 60 * 1000).toISOString()

    const { error: insertError } = await admin.from('password_reset_challenges').insert({
      id: challengeId,
      user_id: matches ? profile.id : null,
      phone_hash: phoneHash,
      code_hash: codeHash,
      expires_at: expiresAt,
    })
    if (insertError) {
      console.error('[reset-password-no-email] insert challenge', insertError)
      return json({ ok: false, message: '잠시 후 다시 시도해주세요.' })
    }

    if (matches) {
      try {
        await sendSolapiSms(phone, code)
      } catch (error) {
        console.error('[reset-password-no-email] send SMS', error)
        await admin.from('password_reset_challenges').delete().eq('id', challengeId)
        return json({ ok: false, message: '문자를 보내지 못했습니다. 관리자에게 문의해주세요.' })
      }
    } else {
      await new Promise((resolve) => setTimeout(resolve, 500))
    }

    return json({ ok: true, challengeId, expiresIn: 180, resendIn: 60 })
  }

  if (action === 'verify') {
    const challengeId = String(body.challengeId || '')
    const code = String(body.code || '').replace(/\D/g, '')
    if (!challengeId || code.length !== 6) return json({ ok: false, message: '6자리 인증번호를 입력해주세요.' })

    const { data: challenge } = await admin
      .from('password_reset_challenges')
      .select('*')
      .eq('id', challengeId)
      .maybeSingle()
    if (!challenge || !challenge.user_id || challenge.used_at || challenge.verified_at) {
      return json({ ok: false, message: '인증번호가 올바르지 않습니다.' })
    }
    if (new Date(challenge.expires_at).getTime() < Date.now()) {
      return json({ ok: false, message: '인증번호가 만료되었습니다. 다시 받아주세요.' })
    }
    if (challenge.verify_attempts >= 5) {
      return json({ ok: false, message: '인증 시도 횟수를 초과했습니다. 다시 받아주세요.' })
    }

    const codeHash = await sha256(`${challengeId}:${code}:${serviceKey}`)
    if (codeHash !== challenge.code_hash) {
      await admin.from('password_reset_challenges').update({ verify_attempts: challenge.verify_attempts + 1 }).eq('id', challengeId)
      return json({ ok: false, message: '인증번호가 올바르지 않습니다.' })
    }

    const resetToken = `${crypto.randomUUID()}${crypto.randomUUID()}`.replaceAll('-', '')
    const resetTokenHash = await sha256(`${challengeId}:${resetToken}:${serviceKey}`)
    const { error } = await admin.from('password_reset_challenges').update({
      verified_at: new Date().toISOString(),
      reset_token_hash: resetTokenHash,
    }).eq('id', challengeId)
    if (error) return json({ ok: false, message: '인증을 완료하지 못했습니다.' })
    return json({ ok: true, resetToken })
  }

  if (action === 'reset') {
    const challengeId = String(body.challengeId || '')
    const resetToken = String(body.resetToken || '')
    const password = String(body.password || '')
    if (!challengeId || !resetToken || !password) return json({ ok: false, message: '입력 정보를 확인해주세요.' })

    const { data: challenge } = await admin
      .from('password_reset_challenges')
      .select('*')
      .eq('id', challengeId)
      .maybeSingle()
    const tokenHash = await sha256(`${challengeId}:${resetToken}:${serviceKey}`)
    const verifiedWithinTenMinutes = challenge?.verified_at && new Date(challenge.verified_at).getTime() > Date.now() - 10 * 60 * 1000
    if (!challenge?.user_id || challenge.used_at || !verifiedWithinTenMinutes || tokenHash !== challenge.reset_token_hash) {
      return json({ ok: false, message: '인증 시간이 만료되었습니다. 처음부터 다시 진행해주세요.' })
    }

    const { error: updateError } = await admin.auth.admin.updateUserById(challenge.user_id, { password })
    if (updateError) {
      console.error('[reset-password-no-email] update password', updateError)
      return json({ ok: false, message: '비밀번호를 변경하지 못했습니다.' })
    }
    await admin.from('password_reset_challenges').update({ used_at: new Date().toISOString() }).eq('id', challengeId)
    return json({ ok: true })
  }

  return json({ ok: false, message: '잘못된 요청입니다.' })
})
