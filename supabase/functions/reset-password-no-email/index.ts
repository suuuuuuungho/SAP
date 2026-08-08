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

async function hash(value: string) {
  const bytes = new TextEncoder().encode(value)
  const digest = await crypto.subtle.digest('SHA-256', bytes)
  return Array.from(new Uint8Array(digest), (byte) => byte.toString(16).padStart(2, '0')).join('')
}

function normalizePhone(value: string) {
  return value.replace(/\D/g, '')
}

function normalizePassword(value: string) {
  return value.length >= 6 ? value : `${value}#SAP26`
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  if (req.method !== 'POST') return json({ error: 'method not allowed' }, 405)

  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')
  if (!supabaseUrl || !serviceKey) return json({ error: 'server configuration error' }, 500)

  const body = await req.json().catch(() => ({}))
  const username = String(body.username || '').trim()
  const name = String(body.name || '').trim()
  const phone = normalizePhone(String(body.phone || ''))
  const password = String(body.password || '')
  if (!username || !name || phone.length < 10 || !password) return json({ error: '입력 정보를 확인해주세요.' }, 400)

  const ip = (req.headers.get('x-forwarded-for') || req.headers.get('cf-connecting-ip') || 'unknown').split(',')[0].trim()
  const [usernameHash, ipHash] = await Promise.all([hash(username.toLowerCase()), hash(ip)])
  const admin = createClient(supabaseUrl, serviceKey, { auth: { persistSession: false, autoRefreshToken: false } })
  const since = new Date(Date.now() - 15 * 60 * 1000).toISOString()
  const { count } = await admin.from('password_reset_attempts').select('id', { count: 'exact', head: true })
    .or(`username_hash.eq.${usernameHash},ip_hash.eq.${ipHash}`).gte('attempted_at', since)
  if ((count || 0) >= 5) return json({ error: '잠시 후 다시 시도해주세요.' }, 429)
  await admin.from('password_reset_attempts').insert({ username_hash: usernameHash, ip_hash: ipHash })

  const { data: profile } = await admin.from('profiles').select('id, name, phone').ilike('username', username).maybeSingle()
  const matches = profile && profile.name.trim() === name && normalizePhone(profile.phone) === phone
  if (matches) {
    const { error: updateError } = await admin.auth.admin.updateUserById(profile.id, { password: normalizePassword(password) })
    if (updateError) {
      console.error('[reset-password-no-email] update user', updateError)
      return json({ error: '비밀번호를 변경하지 못했습니다.' }, 500)
    }
  } else {
    // 정보 일치 여부를 응답 시간으로 추측하기 어렵게 짧은 지연을 둡니다.
    await new Promise((resolve) => setTimeout(resolve, 350))
  }

  // 계정 존재 여부와 개인정보 일치 여부는 외부에 노출하지 않습니다.
  return json({ ok: true })
})

