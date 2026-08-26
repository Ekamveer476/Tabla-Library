-- Tabla Library shared database setup
-- Run this whole file once in Supabase -> SQL Editor -> New query -> Run.

create table if not exists public.tabla_items (
  id text primary key,
  data jsonb not null
);

create table if not exists public.tabla_settings (
  key text primary key,
  value jsonb
);

alter table public.tabla_items enable row level security;
alter table public.tabla_settings enable row level security;

-- Everyone with the website can view and edit for now.
drop policy if exists "tabla_items_public_select" on public.tabla_items;
drop policy if exists "tabla_items_public_insert" on public.tabla_items;
drop policy if exists "tabla_items_public_update" on public.tabla_items;
drop policy if exists "tabla_items_public_delete" on public.tabla_items;
create policy "tabla_items_public_select" on public.tabla_items for select to anon, authenticated using (true);
create policy "tabla_items_public_insert" on public.tabla_items for insert to anon, authenticated with check (true);
create policy "tabla_items_public_update" on public.tabla_items for update to anon, authenticated using (true) with check (true);
create policy "tabla_items_public_delete" on public.tabla_items for delete to anon, authenticated using (true);

drop policy if exists "tabla_settings_public_select" on public.tabla_settings;
drop policy if exists "tabla_settings_public_insert" on public.tabla_settings;
drop policy if exists "tabla_settings_public_update" on public.tabla_settings;
drop policy if exists "tabla_settings_public_delete" on public.tabla_settings;
create policy "tabla_settings_public_select" on public.tabla_settings for select to anon, authenticated using (true);
create policy "tabla_settings_public_insert" on public.tabla_settings for insert to anon, authenticated with check (true);
create policy "tabla_settings_public_update" on public.tabla_settings for update to anon, authenticated using (true) with check (true);
create policy "tabla_settings_public_delete" on public.tabla_settings for delete to anon, authenticated using (true);

insert into storage.buckets (id, name, public)
values ('tabla-papers', 'tabla-papers', true)
on conflict (id) do update set public = true;

drop policy if exists "tabla_papers_public_select" on storage.objects;
drop policy if exists "tabla_papers_public_insert" on storage.objects;
drop policy if exists "tabla_papers_public_update" on storage.objects;
drop policy if exists "tabla_papers_public_delete" on storage.objects;
create policy "tabla_papers_public_select" on storage.objects for select to anon, authenticated using (bucket_id = 'tabla-papers');
create policy "tabla_papers_public_insert" on storage.objects for insert to anon, authenticated with check (bucket_id = 'tabla-papers');
create policy "tabla_papers_public_update" on storage.objects for update to anon, authenticated using (bucket_id = 'tabla-papers') with check (bucket_id = 'tabla-papers');
create policy "tabla_papers_public_delete" on storage.objects for delete to anon, authenticated using (bucket_id = 'tabla-papers');
