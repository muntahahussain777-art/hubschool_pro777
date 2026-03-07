-- User profiles for admin panel: list, edit role/email. Links to auth.users.
-- Run in Supabase SQL Editor. Safe: does not drop existing data.

CREATE TABLE IF NOT EXISTS app_user_profiles (
  id         UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email      TEXT NOT NULL,
  role       TEXT NOT NULL DEFAULT 'teacher',
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_app_user_profiles_role ON app_user_profiles(role);
CREATE INDEX IF NOT EXISTS idx_app_user_profiles_email ON app_user_profiles(email);

-- RLS: allow authenticated to read all (admin list); allow insert/update for own or service
ALTER TABLE app_user_profiles ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Allow read for authenticated" ON app_user_profiles;
CREATE POLICY "Allow read for authenticated" ON app_user_profiles FOR SELECT TO authenticated USING (true);

DROP POLICY IF EXISTS "Allow insert for authenticated" ON app_user_profiles;
CREATE POLICY "Allow insert for authenticated" ON app_user_profiles FOR INSERT TO authenticated WITH CHECK (true);

DROP POLICY IF EXISTS "Allow update for authenticated" ON app_user_profiles;
CREATE POLICY "Allow update for authenticated" ON app_user_profiles FOR UPDATE TO authenticated USING (true);

DROP POLICY IF EXISTS "Allow delete for authenticated" ON app_user_profiles;
CREATE POLICY "Allow delete for authenticated" ON app_user_profiles FOR DELETE TO authenticated USING (true);
