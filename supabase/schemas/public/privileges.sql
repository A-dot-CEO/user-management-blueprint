-- Public schema privileges and grants
-- STRICT SECURITY: Only authenticated users can access data
-- RLS policies will provide row-level security on top of these grants

-- Schema usage permissions
grant usage on schema public to anon, authenticated, service_role;

-- Table permissions - ONLY for authenticated users
grant select, insert, update, delete on all tables in schema public to authenticated;

-- Function permissions - restricted access
grant execute on all functions in schema public to authenticated, service_role;

-- Sequence permissions - ONLY for authenticated users
grant usage, select on all sequences in schema public to authenticated;

-- Default privileges for future objects - ONLY authenticated users
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;

alter default privileges in schema public
  grant execute on functions to authenticated, service_role;

alter default privileges in schema public
  grant usage, select on sequences to authenticated;

-- Note: anon role has NO table/function/sequence access
-- This enforces authentication requirement at the PostgreSQL level
-- RLS policies will provide fine-grained access control for authenticated users