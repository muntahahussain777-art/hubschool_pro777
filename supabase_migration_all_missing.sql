-- =============================================================
--  HubSchool Pro – All missing schema updates
--  Run this in Supabase SQL Editor once to add missing columns
--  and tables. Safe to run multiple times (IF NOT EXISTS / ADD COLUMN IF NOT EXISTS).
-- =============================================================

-- ─────────────────────────────────────────────
--  1.  Students – missing columns (classroom_id, etc.)
--  Use this if you get "could not find classroom_id" or similar.
-- ─────────────────────────────────────────────

ALTER TABLE students ADD COLUMN IF NOT EXISTS classroom_id INTEGER REFERENCES classrooms(id);
ALTER TABLE students ADD COLUMN IF NOT EXISTS monthly_fee INTEGER NOT NULL DEFAULT 0;
ALTER TABLE students ADD COLUMN IF NOT EXISTS previous_school TEXT;
ALTER TABLE students ADD COLUMN IF NOT EXISTS gender TEXT;

-- Optional: if students table exists but is_empty and you want default structure
-- (only run if your students table was created without these from the start)
-- Already have id, admission_no, full_name, father_name, dob, phone, address, photo_path, qr_token, is_active, created_at? Then above ALTERs are enough.

-- ─────────────────────────────────────────────
--  2.  News & Blog – news_posts table
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS news_posts (
  id           SERIAL PRIMARY KEY,
  title        TEXT NOT NULL,
  body         TEXT,
  type         TEXT NOT NULL DEFAULT 'news',   -- 'news' | 'blog'
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- =============================================================
--  END – Run this entire file in Supabase → SQL Editor → Run
-- =============================================================
