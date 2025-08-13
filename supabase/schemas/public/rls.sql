-- Public schema Row Level Security policies
-- Enable RLS and create policies for data access control

-- Template for enabling RLS on tables:
-- alter table public.table_name enable row level security;

-- Template for creating policies:
-- create policy "policy_name" on public.table_name
--   for select using (auth.uid() = user_id);
--
-- create policy "policy_name" on public.table_name
--   for insert with check (auth.uid() = user_id);
--
-- create policy "policy_name" on public.table_name
--   for update using (auth.uid() = user_id);
--
-- create policy "policy_name" on public.table_name
--   for delete using (auth.uid() = user_id);