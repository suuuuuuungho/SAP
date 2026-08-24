-- SAP 1기 회원가입 서약 기록 스키마.
-- 기존 schema.sql 및 가입자 생성 이후 Supabase SQL Editor에서 실행하세요.

create table if not exists public.pledge_agreements (
  user_id uuid primary key references auth.users(id) on delete cascade,
  pledge_version text not null,
  signer_name text not null check (char_length(signer_name) between 1 and 100),
  agreed_items jsonb not null check (jsonb_typeof(agreed_items) = 'array'),
  signature_data jsonb not null check (jsonb_typeof(signature_data) = 'array'),
  signed_at timestamptz not null,
  created_at timestamptz not null default now()
);

alter table public.pledge_agreements enable row level security;

drop policy if exists "pledge_agreements_select_own" on public.pledge_agreements;
create policy "pledge_agreements_select_own"
  on public.pledge_agreements for select to authenticated
  using (user_id = auth.uid());

create or replace function public.handle_new_user_pledge()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  meta jsonb := coalesce(new.raw_user_meta_data, '{}'::jsonb);
begin
  if coalesce(meta ->> 'pledge_version', '') <> 'sap-pledge-v1'
     or btrim(coalesce(meta ->> 'pledge_signer_name', '')) = ''
     or meta -> 'pledge_agreed_items' <> '[1,2,3,4,5,6,7]'::jsonb
     or jsonb_typeof(meta -> 'pledge_signature') <> 'array'
     or jsonb_array_length(meta -> 'pledge_signature') = 0 then
    raise exception 'SAP pledge agreement and signature are required';
  end if;

  insert into public.pledge_agreements (
    user_id, pledge_version, signer_name, agreed_items, signature_data, signed_at
  ) values (
    new.id,
    meta ->> 'pledge_version',
    meta ->> 'pledge_signer_name',
    meta -> 'pledge_agreed_items',
    meta -> 'pledge_signature',
    coalesce((meta ->> 'pledge_signed_at')::timestamptz, now())
  );
  return new;
end;
$$;

drop trigger if exists on_auth_user_created_pledge on auth.users;
create trigger on_auth_user_created_pledge
  after insert on auth.users
  for each row execute function public.handle_new_user_pledge();
