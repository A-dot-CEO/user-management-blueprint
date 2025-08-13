# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a React + TypeScript + Vite user management blueprint using Supabase as the backend. It's built with modern web technologies including:

- **Frontend**: React 19 with TypeScript and Vite
- **UI Components**: shadcn/ui components with Radix UI primitives
- **Styling**: Tailwind CSS v4 with CSS variables
- **Database**: Supabase (PostgreSQL) with local development setup
- **Authentication**: Supabase Auth with email/password and OAuth providers
- **Routing**: React Router DOM v7
- **Forms**: React Hook Form with Zod validation
- **Icons**: Lucide React

## Development Commands

### Core Development

- `npm run dev` - Start development server (Vite)
- `npm run build` - Build for production (TypeScript compilation + Vite build)
- `npm run preview` - Preview production build locally

### Code Quality

- `npm run lint` - Run ESLint
- `npm run type-check` - Run TypeScript compiler check
- `npm run format` - Format code with Prettier
- `npm run format:check` - Check code formatting
- `npm run check` - Run format, type-check, and lint in sequence

### Database Operations (Supabase)

- `npm run db:diff` - Generate migration from schema changes
- `npm run db:migrate` - Apply pending migrations
- `npm run db:test` - Run database tests
- `npm run db:reset` - Reset local database to clean state
- `npm run db:types` - Generate TypeScript types from database schema

## Architecture

### Frontend Structure

- `src/App.tsx` - Main app component with React Router outlet
- `src/main.tsx` - Application entry point
- `src/pages/` - Page components (currently just Index.tsx)
- `src/components/ui/` - Reusable UI components from shadcn/ui
- `src/lib/` - Utility functions and external service clients
- `src/hooks/` - Custom React hooks
- `src/types/` - TypeScript type definitions

### Database Structure

- Local Supabase setup with PostgreSQL
- Schema files in `supabase/schemas/` (tables, functions, triggers, RLS, indexes)
- Seed data in `supabase/seeds/`
- Configuration in `supabase/config.toml`

### Key Configuration Files

- `vite.config.ts` - Vite configuration with React and Tailwind plugins
- `components.json` - shadcn/ui configuration
- `eslint.config.js` - ESLint flat config with React and TypeScript rules
- `tsconfig.json` - TypeScript project references and path aliases

## Supabase Integration

### Environment Setup

- Copy `.env.example` to `.env.local` (file doesn't exist yet but referenced in README)
- Get values from Supabase local dashboard at http://127.0.0.1:54323/project/default
- Required variables: `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`

### Local Development

- Supabase runs on port 54321 (API), 54322 (DB), 54323 (Studio)
- Database schema is managed through migration files
- Types are auto-generated with `npm run db:types`

### Client Configuration

- Supabase client configured in `src/lib/supabase/client.ts`
- Validates required environment variables on startup

### Database Schema Management

**Multi-Schema Architecture**:
The project uses a folder-per-schema approach with deterministic ordering controlled by `supabase/config.toml`.

**Schema Organization**:

```
supabase/schemas/
  _globals/           # Environment-wide definitions
    extensions.sql    # PostgreSQL extensions
    roles.sql         # Custom roles
    publications.sql  # Realtime publications
  public/             # Main application schema
    tables.sql        # Table definitions
    constraints.sql   # Foreign keys, checks, unique constraints
    functions.sql     # Stored procedures
    triggers.sql      # Database triggers
    rls.sql          # Row Level Security policies
    privileges.sql   # Grants and permissions
  [other-schemas]/    # Additional domain schemas (billing, projects, etc.)
    tables.sql
    constraints.sql
    functions.sql
    triggers.sql
    rls.sql
    privileges.sql
```

**Execution Order** (defined in `config.toml`):

1. `_globals/**/*.sql` - Extensions, roles, publications
2. `*/tables.sql` - All table definitions across schemas
3. `*/constraints.sql` - Foreign keys and constraints
4. `*/functions.sql` and `*/triggers.sql` - Programmable objects
5. `*/rls.sql` and `*/privileges.sql` - Security policies

**Best Practices**:

- Use Declarative Database Schemas; never create or update migrations manually
- Always enable row-level security (RLS) on every table; use least privilege
- Access via PostgREST using `@supabase/supabase-js`
- Use UUID primary keys with `uuid_generate_v4()`
- Use TEXT instead of VARCHAR
- Include `created_at` and `updated_at` timestamps with triggers
- Follow PostgreSQL naming conventions (snake_case)
- Do not add comments, use descriptive names for functions, triggers and RLS policies
- Keep files idempotent using `if not exists` and `create or replace`

**Schema Changes Workflow** (follow this exact sequence):

1. **Update schema files** in appropriate `supabase/schemas/<schema>/` folder
2. **Generate migration**: `npm run db:diff -- -f <change_summary>` (use snake_case naming)
3. **Apply migration**: `npm run db:migrate`
4. **Update TypeScript types**: `npm run db:types`

**Adding New Schemas**:

1. Create folder: `supabase/schemas/<schema-name>/`
2. Add required files: `tables.sql`, `constraints.sql`, `functions.sql`, `triggers.sql`, `rls.sql`, `privileges.sql`
3. Expose in API: Add schema to `[api].schemas` in `config.toml`
4. Use in client: `supabase.schema('<schema-name>').from('table')`

**Seed Data**:

- Update seed files in `supabase/seeds/` when changing schema
- Use a separate seed file for each table
- Ask user if they want to reset database with new seed data, then run `npm run db:reset`

## Development Workflow

1. **Setup**: Ensure Supabase is running locally and environment variables are configured
2. **Database**: Use `npm run db:reset` for fresh setup or `npm run db:migrate` for updates
3. **Types**: Run `npm run db:types` after schema changes to update TypeScript types
4. **Code Quality**: Use `npm run check` before committing to ensure formatting, types, and linting pass
5. **Testing**: Database tests available via `npm run db:test`

## Path Aliases

The project uses `@/` as an alias for the `src/` directory:

- `@/components` → `src/components`
- `@/lib` → `src/lib`
- `@/hooks` → `src/hooks`
- `@/pages` → `src/pages`
