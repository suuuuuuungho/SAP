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

// base64 문자열의 대략적인 디코딩 후 바이트 크기(패딩 미고려, 상한 체크용이라 근사치면 충분).
function base64ByteLength(value: string) {
  return Math.floor((value.length * 3) / 4)
}

const MAX_IMAGE_BYTES = 2 * 1024 * 1024 // 2MB — 헤더 크롭만 보내므로 이 정도면 충분히 여유 있음
const PROMPT_LINES = [
  '이 사진은 학생이 작성한 성경 공부 워크시트 상단 헤더 부분입니다.',
  '헤더에는 보통 "요한복음 N장 묵상 날짜: ..." 형태의 인쇄된 제목이 있습니다.',
  '거기서 "요한복음" 뒤에 오는 장(챕터) 숫자만 읽어주세요.',
  '반드시 다른 설명 없이 아래 JSON 형식으로만 답하세요:',
  '{"chapter": <숫자 또는 null>}',
  '숫자를 읽을 수 없거나 해당 문구가 보이지 않으면 null을 넣으세요.',
]

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  if (req.method !== 'POST') return json({ ok: false, message: 'method not allowed' }, 405)

  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const anonKey = Deno.env.get('SUPABASE_ANON_KEY')
  const apiKey = Deno.env.get('ANTHROPIC_API_KEY')
  if (!supabaseUrl || !anonKey) return json({ ok: false, message: 'Supabase environment is missing' }, 500)
  if (!apiKey) return json({ ok: false, message: 'ANTHROPIC_API_KEY is not configured' }, 500)

  const authHeader = req.headers.get('Authorization') || ''
  const viewer = createClient(supabaseUrl, anonKey, { global: { headers: { Authorization: authHeader } } })
  const { data: authData, error: authError } = await viewer.auth.getUser()
  if (authError || !authData?.user) return json({ ok: false, message: '로그인이 필요합니다.' }, 401)

  const body = await req.json().catch(() => ({}))
  const imageBase64 = String(body.imageBase64 || '')
  const mediaType = String(body.mediaType || 'image/jpeg')
  const chapters = Array.isArray(body.chapters)
    ? body.chapters.map((n: unknown) => Number(n)).filter((n: number) => Number.isInteger(n) && n >= 1 && n <= 21)
    : []

  if (!imageBase64 || !chapters.length) return json({ ok: false, message: 'invalid request' }, 400)
  if (!['image/jpeg', 'image/png', 'image/webp'].includes(mediaType)) return json({ ok: false, message: 'unsupported media type' }, 400)
  if (base64ByteLength(imageBase64) > MAX_IMAGE_BYTES) return json({ ok: false, message: 'image too large' }, 400)

  const response = await fetch('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: {
      'content-type': 'application/json',
      'x-api-key': apiKey,
      'anthropic-version': '2023-06-01',
    },
    body: JSON.stringify({
      model: 'claude-haiku-4-5-20251001',
      max_tokens: 50,
      messages: [
        {
          role: 'user',
          content: [
            { type: 'image', source: { type: 'base64', media_type: mediaType, data: imageBase64 } },
            { type: 'text', text: PROMPT_LINES.join('\n') },
          ],
        },
      ],
    }),
  })

  if (!response.ok) {
    const detail = await response.text()
    console.error('[verify-word-photo] anthropic error', response.status, detail)
    return json({ ok: false, message: 'AI 확인 요청이 실패했습니다.' }, 502)
  }

  const payload = await response.json().catch(() => null)
  const replyText = String(payload?.content?.[0]?.text || '')
  let detectedChapter: number | null = null
  try {
    const match = replyText.match(/\{[\s\S]*\}/)
    const parsed = match ? JSON.parse(match[0]) : null
    if (parsed && Number.isInteger(parsed.chapter)) detectedChapter = parsed.chapter
  } catch (err) {
    console.error('[verify-word-photo] parse error', err, replyText)
  }

  const matched = detectedChapter !== null && chapters.includes(detectedChapter)
  return json({ ok: true, matched, detectedChapter })
})
