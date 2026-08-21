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

async function solapiRequest(apiKey: string, apiSecret: string, path: string, method: string, requestBody?: unknown) {
  const stamp = new Date().toISOString()
  const salt = crypto.randomUUID()
  const signature = await hmac(apiSecret, stamp + salt)
  return fetch(`https://api.solapi.com${path}`, {
    method,
    headers: { 'Content-Type': 'application/json', Authorization: `HMAC-SHA256 apiKey=${apiKey}, date=${stamp}, salt=${salt}, signature=${signature}` },
    body: requestBody === undefined ? undefined : JSON.stringify(requestBody),
  })
}

function buildParentReportMessage(studentName: string, reportUrl: string): string {
  return [
    `${studentName} 학부모님, 안녕하세요.`,
    '이번 SAP 1기에 신청해 주셔서 감사합니다.',
    '',
    'SAP는 “Faith is Life”, 신앙이 교회 안에만 머무는 것이 아니라 학교와 가정 등 우리의 모든 삶 속에서 이어지도록 돕기 위한 프로그램입니다.',
    '',
    `아래 링크를 통해 ${studentName} 학생의 기도·말씀·예배·공부 실천 현황과 함께, 특히 요한복음 말씀묵상 내용을 확인하실 수 있습니다.`,
    '',
    `🔗 학생 개인 리포트: ${reportUrl}`,
    '',
    '**모임(시험) 시간',
    '- 8. 22.(토) 오전 10시 30분',
    '- 9. 5.(토) 오전 10시 30분',
    '',
    '**말씀묵상 항목에서 사진이 등록되어 있지 않은 경우 해당 날짜의 말씀묵상을 진행하지 않은 것으로 확인해 주시면 됩니다.',
    '',
    '**사이트에서 학생 이름 옆에 표시된 @로 시작하는 단어는 학생의 아이디입니다. 학생들에게 자신의 꿈과 관련된 단어로 아이디를 정하도록 안내하였으니 참고해 주시면 감사하겠습니다.',
    '',
    '**매주 학생들의 활동 내용을 확인하여 가정에서도 함께 격려해 주시면 감사하겠습니다.',
    '',
    '학생들이 끝까지 SAP를 완주하며 교회뿐만 아니라 학교와 가정에서도 신앙으로 살아가는 힘을 기를 수 있도록 함께 응원해 주세요.'
  ].join('\n')
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
  const { data: authData } = await viewer.auth.getUser()

  const body = await req.json().catch(() => ({}))
  const mode = body.mode === 'report' ? 'report' : body.mode === 'board' ? 'board' : body.mode === 'board_cancel' ? 'board_cancel' : body.mode === 'parent' ? 'parent' : 'missing'
  const userId = String(body.userId || '')
  const date = String(body.date || '')
  const missing = Array.isArray(body.missing) ? body.missing.map(String).filter(Boolean) : []
  const reportToken = String(body.reportToken || '')
  const siteUrl = String(body.siteUrl || '')
  const messageText = String(body.messageBody || '').trim()
  const senderId = String(body.senderId || '')
  const audienceType = body.audienceType === 'personal' ? 'personal' : 'global'
  const scheduledAt = String(body.scheduledAt || '')
  const groupIds = Array.isArray(body.groupIds) ? body.groupIds.map(String).filter((id: string) => /^G4V[A-Za-z0-9]+$/.test(id)) : []
  const admin = createClient(url, service)
  const apiKey = Deno.env.get('SOLAPI_API_KEY')
  const apiSecret = Deno.env.get('SOLAPI_API_SECRET')
  const sender = digits(Deno.env.get('SOLAPI_SENDER_NUMBER') || '')
  if (!apiKey || !apiSecret || !sender) return json({ ok: false, message: '솔라피 서버 설정이 필요합니다.' }, 500)

  if (mode === 'board_cancel') {
    if (!groupIds.length) return json({ ok: true, cancelled: 0 })
    let cancelled = 0
    for (const groupId of groupIds) {
      const unschedule = await solapiRequest(apiKey, apiSecret, `/messages/v4/groups/${encodeURIComponent(groupId)}/schedule`, 'DELETE')
      if (!unschedule.ok) continue
      const remove = await solapiRequest(apiKey, apiSecret, `/messages/v4/groups/${encodeURIComponent(groupId)}`, 'DELETE')
      if (remove.ok) cancelled += 1
    }
    return json({ ok: cancelled === groupIds.length, cancelled, requested: groupIds.length }, cancelled === groupIds.length ? 200 : 409)
  }

  const { data: member } = await admin.from('profiles').select('name,phone,parent_phone,grade_class').eq('id', userId).maybeSingle()
  const to = digits(mode === 'report' || mode === 'parent' ? member?.parent_phone || '' : member?.phone || '')
  const logItems = mode === 'report' ? ['개인 리포트'] : mode === 'board' ? [audienceType === 'personal' ? 'Board 개인 메시지' : 'Board 전체 공지'] : mode === 'parent' ? [audienceType === 'personal' ? '학부모 개인 메시지' : '학부모 전체 메시지'] : missing
  const writeLog = async (status: 'success' | 'failed', errorMessage: string | null = null) => {
    if (!member || !/^\d{4}-\d{2}-\d{2}$/.test(date) || !logItems.length) return
    const { error: logError } = await admin.from('admin_sms_logs').insert({
      target_user_id: userId, target_name: member.name, grade_class: member.grade_class,
      target_phone: to || null, target_date: date, missing_items: logItems,
      status, error_message: errorMessage, sent_by: authData?.user?.id || null,
    })
    if (logError) console.error('[admin-send-sms:log]', logError)
  }
  let parsedReportUrl: URL | null = null
  if (mode === 'report') {
    try {
      const base = new URL(siteUrl)
      if (!['https:', 'http:'].includes(base.protocol)) throw new Error('invalid protocol')
      if (!/^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(reportToken)) throw new Error('invalid token')
      parsedReportUrl = new URL('report.html', base)
      parsedReportUrl.searchParams.set('token', reportToken)
    } catch { parsedReportUrl = null }
  }
  if (!member) return json({ ok: false, message: '학생 정보를 찾을 수 없습니다.' })
  if (to.length < 10) {
    const message = mode === 'report' || mode === 'parent' ? 'Member에서 학부모 연락처를 확인해주세요.' : 'Member에서 학생 연락처를 확인해주세요.'
    await writeLog('failed', message)
    return json({ ok: false, message })
  }
  if (mode === 'missing' && !missing.length) {
    await writeLog('failed', '미인증 정보 누락')
    return json({ ok: false, message: '미인증 정보를 확인해주세요.' })
  }
  if (mode === 'report' && !parsedReportUrl) {
    await writeLog('failed', '리포트 링크 생성 오류')
    return json({ ok: false, message: '리포트 링크를 만들지 못했습니다. Admin 페이지를 새로고침한 후 다시 시도해주세요.' })
  }
  if ((mode === 'board' || mode === 'parent') && !messageText) {
    await writeLog('failed', '메시지 내용 누락')
    return json({ ok: false, message: '메시지 내용을 확인해주세요.' })
  }

  let boardSenderName = ''
  let scheduledIso: string | null = null
  if (mode === 'board' || mode === 'parent') {
    const parsedScheduledAt = new Date(scheduledAt)
    const maxScheduledAt = new Date(); maxScheduledAt.setMonth(maxScheduledAt.getMonth() + 6)
    if (Number.isNaN(parsedScheduledAt.getTime()) || parsedScheduledAt > maxScheduledAt) {
      await writeLog('failed', '예약 시각 오류')
      return json({ ok: false, message: '예약 시각은 현재부터 6개월 이내로 설정해주세요.' }, 400)
    }
    scheduledIso = parsedScheduledAt.toISOString()
  }
  if (mode === 'board') {
    const { data: selectedSender } = await admin.from('profiles').select('name,app_role,is_admin,is_active').eq('id', senderId).maybeSingle()
    const allowedSender = selectedSender && selectedSender.is_active !== false && (selectedSender.is_admin || ['admin', 'teacher', 'pastor', 'department_head', 'secretary'].includes(selectedSender.app_role))
    if (!allowedSender) {
      await writeLog('failed', '발신 관리자 확인 오류')
      return json({ ok: false, message: '발신 관리자를 확인해주세요.' }, 400)
    }
    boardSenderName = String(selectedSender.name || '').trim()
    if (!boardSenderName) {
      await writeLog('failed', '발신 관리자 회원가입 이름 누락')
      return json({ ok: false, message: '발신 관리자의 회원가입 이름을 확인해주세요.' }, 400)
    }
  }

  const message = { to, from: sender, text: mode === 'report'
      ? buildParentReportMessage(member.name, parsedReportUrl!.href)
      : mode === 'board'
      ? `[SAP ${audienceType === 'personal' ? '개인 메시지' : '전체 공지'}] ${messageText}\n\n-${boardSenderName} 선생님-`
      : mode === 'parent'
      ? `[SAP] ${member.name} 학생 학부모님, ${messageText}`
      : `[SAP] ${member.name} 학생, ${date} 현재 미인증 항목은 ${missing.join(', ')}입니다. 확인 후 인증을 완료해주세요.` }
  const requestPayload: Record<string, unknown> = { messages: [message], showMessageList: true }
  if ((mode === 'board' || mode === 'parent') && scheduledIso) requestPayload.scheduledDate = scheduledIso
  const response = await solapiRequest(apiKey, apiSecret, '/messages/v4/send-many/detail', 'POST', requestPayload)
  if (!response.ok) {
    const detail = await response.text()
    console.error('[admin-send-sms]', response.status, detail)
    await writeLog('failed', `솔라피 응답 오류 (${response.status})`)
    return json({ ok: false, message: '문자 발송에 실패했습니다.' }, 502)
  }
  const responseBody = await response.json().catch(() => ({}))
  await writeLog('success')
  return json({ ok: true, groupId: responseBody?.groupInfo?.groupId || null, scheduledAt: responseBody?.groupInfo?.scheduledDate || scheduledIso })
})
