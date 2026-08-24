-- Board 탭에 "내 게시물에 달린 새 댓글" 뱃지/목록을 보여주기 위한 스키마.
-- profiles.board_comments_seen_at 이후에 생긴 post_comments(post_owner_id = 나)를 "안 읽음"으로 센다.

alter table public.profiles add column if not exists board_comments_seen_at timestamptz;

-- profiles에는 본인 UPDATE 정책이 없으므로(다른 민감 컬럼까지 열어주지 않기 위해),
-- board_comments_seen_at만 SECURITY DEFINER로 안전하게 갱신하는 전용 RPC를 둔다.
create or replace function public.mark_board_comments_seen()
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  update public.profiles set board_comments_seen_at = now() where id = auth.uid();
end;
$$;

grant execute on function public.mark_board_comments_seen() to authenticated;

-- 뱃지용: 가벼운 카운트만. profiles(작성자 이름)는 join 안 함.
create or replace function public.get_unread_board_comment_count()
returns integer
language plpgsql
security definer
set search_path = public
as $$
declare
  seen_at timestamptz;
  result integer;
begin
  select board_comments_seen_at into seen_at from public.profiles where id = auth.uid();
  select count(*) into result from public.post_comments
    where post_owner_id = auth.uid()
    and created_at > coalesce(seen_at, 'epoch'::timestamptz);
  return coalesce(result, 0);
end;
$$;

grant execute on function public.get_unread_board_comment_count() to authenticated;

-- Board 페이지 목록용: 내 게시물에 달린 최근 댓글 + 작성자 이름 + 안 읽음 여부.
-- profiles는 본인 행만 SELECT 가능(profiles_select_own)이라 댓글 작성자(관리자 등)
-- 이름은 클라이언트에서 직접 조회할 수 없어 SECURITY DEFINER로 join해서 내려준다.
create or replace function public.get_board_comments_for_me(limit_count integer default 15)
returns table (
  id uuid,
  post_date date,
  post_type text,
  body text,
  created_at timestamptz,
  author_name text,
  is_unread boolean
)
language plpgsql
security definer
set search_path = public
as $$
declare
  seen_at timestamptz;
begin
  select board_comments_seen_at into seen_at from public.profiles where id = auth.uid();
  return query
    select c.id, c.post_date, c.post_type, c.body, c.created_at,
      coalesce(p.name, '선생님') as author_name,
      c.created_at > coalesce(seen_at, 'epoch'::timestamptz) as is_unread
    from public.post_comments c
    left join public.profiles p on p.id = c.author_id
    where c.post_owner_id = auth.uid()
    order by c.created_at desc
    limit greatest(1, least(limit_count, 50));
end;
$$;

grant execute on function public.get_board_comments_for_me(integer) to authenticated;
