-- Public schema triggers
-- Database triggers for automation and data consistency

-- Note: Add triggers for tables with updated_at columns:
-- create trigger handle_updated_at_trigger
--   before update on public.table_name
--   for each row execute function public.handle_updated_at();