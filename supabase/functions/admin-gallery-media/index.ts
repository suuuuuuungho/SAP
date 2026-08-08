import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
  'Access-Control-Allow-Methods': 'POST, OPTIONS',
}
const json = (body: unknown, status = 200) => new Response(JSON.stringify(body), { status, headers: { ...corsHeaders, 'Content-Type': 'application/json; charset=utf-8' } })

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  const url = Deno.env.get('SUPABASE_URL')!
  const anon = Deno.env.get('SUPABASE_ANON_KEY')!
  const service = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
  const authorization = req.headers.get('Authorization') || ''
  const viewer = createClient(url, anon, { global: { headers: { Authorization: authorization } } })
  const { data: allowed } = await viewer.rpc('is_app_admin')
  if (!allowed) return json({ ok: false, message: '관리자 권한이 필요합니다.' }, 403)

  const body = await req.json().catch(() => ({}))
  const ownerId = String(body.ownerId || '')
  const date = String(body.date || '')
  const type = String(body.type || '')
  const photoPath = String(body.photoPath || '')
  if (!ownerId || !date || !['pray', 'word'].includes(type) || !photoPath) return json({ ok: false, message: '요청 정보를 확인해주세요.' }, 400)

  const admin = createClient(url, service, { auth: { persistSession: false, autoRefreshToken: false } })
  if (type === 'pray') {
    const { data: row, error: readError } = await admin.from('pray_records').select('entries').eq('user_id', ownerId).eq('record_date', date).maybeSingle()
    if (readError || !row) return json({ ok: false, message: '기도 게시물을 찾지 못했습니다.' }, 404)
    const entries = (row.entries || []).map((entry: Record<string, unknown>) => entry.photoPath === photoPath ? { ...entry, photoPath: null, photoUnavailable: true } : entry)
    const { error } = await admin.from('pray_records').update({ entries, updated_at: new Date().toISOString() }).eq('user_id', ownerId).eq('record_date', date)
    if (error) return json({ ok: false, message: '게시물을 수정하지 못했습니다.' }, 500)
  } else {
    const { error } = await admin.from('word_records').update({ photo_path: null, photo_unavailable: true, updated_at: new Date().toISOString() }).eq('user_id', ownerId).eq('record_date', date).eq('photo_path', photoPath)
    if (error) return json({ ok: false, message: '게시물을 수정하지 못했습니다.' }, 500)
  }

  const { error: storageError } = await admin.storage.from('verification-photos-v2').remove([photoPath])
  if (storageError) console.error('[admin-gallery-media] storage remove', storageError)
  return json({ ok: true, storageRemoved: !storageError })
})
