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

function plainText(content: string) {
  return content
    .replace(/<[^>]*>/g, ' ')
    .replace(/&nbsp;/g, ' ')
    .replace(/&amp;/g, '&')
    .replace(/&lt;/g, '<')
    .replace(/&gt;/g, '>')
    .replace(/&quot;/g, '"')
    .replace(/&#39;/g, "'")
    .replace(/\s+/g, ' ')
    .trim()
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  if (req.method !== 'POST') return json({ error: 'method not allowed' }, 405)

  const authHeader = req.headers.get('Authorization')
  if (!authHeader) return json({ error: 'authentication required' }, 401)

  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const anonKey = Deno.env.get('SUPABASE_ANON_KEY')
  const apiKey = Deno.env.get('API_BIBLE_KEY')
  if (!supabaseUrl || !anonKey) return json({ error: 'Supabase environment is missing' }, 500)
  if (!apiKey) return json({ error: 'API_BIBLE_KEY is not configured' }, 500)

  const supabase = createClient(supabaseUrl, anonKey, {
    global: { headers: { Authorization: authHeader } },
  })
  const { data: isAdmin, error: adminError } = await supabase.rpc('is_app_admin')
  if (adminError || !isAdmin) return json({ error: 'admin access required' }, 403)

  const body = await req.json().catch(() => ({}))
  const headers = { 'api-key': apiKey, Accept: 'application/json' }

  if (body.action === 'bibles') {
    const response = await fetch('https://rest.api.bible/v1/bibles?language=kor&include-full-details=false', { headers })
    const payload = await response.json()
    if (!response.ok) return json({ error: payload?.message || '성경 번역본을 불러오지 못했습니다.' }, response.status)
    const bibles = (payload.data || []).map((bible: Record<string, any>) => ({
      id: bible.id,
      name: bible.nameLocal || bible.name,
      abbreviation: bible.abbreviationLocal || bible.abbreviation,
      copyright: bible.copyright || '',
    }))
    return json({ bibles })
  }

  if (body.action === 'verse') {
    const bibleId = String(body.bibleId || '')
    const bookId = String(body.bookId || '').toUpperCase()
    const chapter = Number(body.chapter)
    const verse = Number(body.verse)
    if (!bibleId || !/^[1-3A-Z]{3}$/.test(bookId) || !Number.isInteger(chapter) || chapter < 1 || !Number.isInteger(verse) || verse < 1) {
      return json({ error: '번역본과 구절을 올바르게 선택해주세요.' }, 400)
    }
    const verseId = `${bookId}.${chapter}.${verse}`
    const url = `https://rest.api.bible/v1/bibles/${encodeURIComponent(bibleId)}/verses/${encodeURIComponent(verseId)}?content-type=text&include-notes=false&include-titles=false&include-chapter-numbers=false&include-verse-numbers=false`
    const response = await fetch(url, { headers })
    const payload = await response.json()
    if (!response.ok) return json({ error: payload?.message || '구절을 찾지 못했습니다.' }, response.status)
    return json({
      reference: payload.data?.reference || verseId,
      text: plainText(payload.data?.content || ''),
      copyright: payload.data?.copyright || '',
    })
  }

  return json({ error: 'unknown action' }, 400)
})
