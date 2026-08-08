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

async function collectStoragePaths(admin: ReturnType<typeof createClient>, bucket: string, folder: string) {
  const paths: string[] = []
  let offset = 0
  while (true) {
    const { data, error } = await admin.storage.from(bucket).list(folder, { limit: 100, offset })
    if (error) {
      console.warn('[delete-account] list storage', bucket, folder, error.message)
      return paths
    }
    const items = data || []
    for (const item of items) {
      const path = folder ? `${folder}/${item.name}` : item.name
      if (item.id) paths.push(path)
      else paths.push(...await collectStoragePaths(admin, bucket, path))
    }
    if (items.length < 100) break
    offset += items.length
  }
  return paths
}

async function removeFolder(admin: ReturnType<typeof createClient>, bucket: string, folder: string) {
  const paths = await collectStoragePaths(admin, bucket, folder)
  for (let index = 0; index < paths.length; index += 100) {
    const { error } = await admin.storage.from(bucket).remove(paths.slice(index, index + 100))
    if (error) throw error
  }
}

Deno.serve(async (req) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders })
  if (req.method !== 'POST') return json({ ok: false, message: '잘못된 요청입니다.' }, 405)

  const supabaseUrl = Deno.env.get('SUPABASE_URL')
  const anonKey = Deno.env.get('SUPABASE_ANON_KEY')
  const serviceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')
  const authorization = req.headers.get('Authorization') || ''
  if (!supabaseUrl || !anonKey || !serviceKey || !authorization.startsWith('Bearer ')) {
    return json({ ok: false, message: '로그인이 필요합니다.' }, 401)
  }

  const userClient = createClient(supabaseUrl, anonKey, {
    global: { headers: { Authorization: authorization } },
    auth: { persistSession: false, autoRefreshToken: false },
  })
  const accessToken = authorization.slice('Bearer '.length)
  const { data: { user }, error: userError } = await userClient.auth.getUser(accessToken)
  if (userError || !user) return json({ ok: false, message: '로그인 정보를 확인하지 못했습니다.' }, 401)

  const admin = createClient(supabaseUrl, serviceKey, {
    auth: { persistSession: false, autoRefreshToken: false },
  })

  try {
    await Promise.all([
      removeFolder(admin, 'verification-photos-v2', `pray/${user.id}`),
      removeFolder(admin, 'verification-photos-v2', `word/${user.id}`),
      removeFolder(admin, 'profile-avatars', user.id),
    ])

    // created_by가 restrict인 관리자 전광판 데이터는 계정 삭제 전에 직접 제거합니다.
    await admin.from('home_messages').delete().eq('created_by', user.id)
    await admin.from('home_bible_verses').delete().eq('created_by', user.id)

    const { error: deleteError } = await admin.auth.admin.deleteUser(user.id)
    if (deleteError) throw deleteError
    return json({ ok: true })
  } catch (error) {
    console.error('[delete-account]', error)
    return json({ ok: false, message: '회원탈퇴를 완료하지 못했습니다.' }, 500)
  }
})
