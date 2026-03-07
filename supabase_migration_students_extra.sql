-- Run this in Supabase SQL Editor if your students table doesn't have these columns yet.
-- This matches the Android app student form (classroom, monthly_fee, previous_school, gender).

ALTER TABLE students ADD COLUMN IF NOT EXISTS classroom_id INTEGER REFERENCES classrooms(id);
ALTER TABLE students ADD COLUMN IF NOT EXISTS monthly_fee INTEGER NOT NULL DEFAULT 0;
ALTER TABLE students ADD COLUMN IF NOT EXISTS previous_school TEXT;
ALTER TABLE students ADD COLUMN IF NOT EXISTS gender TEXT;
