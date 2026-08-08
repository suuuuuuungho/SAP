import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}
const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), { status, headers: { ...corsHeaders, 'Content-Type': 'application/json; charset=utf-8' } })
const digits = (value: string) => value.replace(/\D/g, '')

async function hmac(secret: string, value: string) {
  const key = await crypto.subtle.importKey('raw', new TextEncoder().encode(secret), { name: 'HMAC', hash: 'SHA-256' }, false, ['sign'])
  const result = await crypto.subtle.sign('HMAC', key, new TextEncoder().encode(value))
  return Array.from(new Uint8Array(result), (byte) => byte.toString(16).padStart(2, '0')).join('')
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  const url = Deno.env.get('SUPABASE_URL')!
  const anon = Deno.env.get('SUPABASE_ANON_KEY')!
  const service = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  const token = req.headers.get('Authorization') || ''
  const viewer = createClient(url, anon, { global: { headers: { Authorization: token } } })
  const { data: allowed } = await viewer.rpc('is_app_admin')
  if (!allowed) return json({ ok: false, message: '관리자 권한이 필요합니다.' }, 403)

  const body = await req.json().catch(() => ({}))
  const userId = String(body.userId || '')
  const date = String(body.date || '')
  const missing = Array.isArray(body.missing) ? body.missing.map(String).filter(Boolean) : []
  const admin = createClient(url, service)
  const { data: member } = await admin.from('profiles').select('name,phone').eq('id', userId).maybeSingle()
  const to = digits(member?.phone || '')
  if (!member || to.length < 10 || !missing.length) return json({ ok: false, message: '학생 연락처 또는 미인증 정보를 확인해주세요.' })

  const apiKey = Deno.env.get('SOLAPI_API_KEY')
  const apiSecret = Deno.env.get('SOLAPI_API_SECRET')
  const sender = digits(Deno.env.get('SOLAPI_SENDER_NUMBER') || '')
  if (!apiKey || !apiSecret || !sender) return json({ ok: false, message: '솔라피 서버 설정이 필요합니다.' }, 500)
  const stamp = new Date().toISOString()
  const salt = crypto.randomUUID()
  const signature = await hmac(apiSecret, stamp + salt)
  const response = await fetch('https://api.solapi.com/messages/v4/send', {
    method: 'POST', headers: { 'Content-Type': 'application/json', Authorization: `HMAC-SHA256 apiKey=${apiKey}, date=${stamp}, salt=${salt}, signature=${signature}` },
    body: JSON.stringify({ message: { to, from: sender, text: `[SAP] ${member.name} 학생, ${date} 현재 미인증 항목은 ${missing.join(', ')}입니다. 확인 후 인증을 완료해주세요.` } }),
  })
  if (!response.ok) { console.error('[admin-send-sms]', response.status, await response.text()); return json({ ok: false, message: '문자 발송에 실패했습니다.' }, 502) }
  return json({ ok: true })
})
