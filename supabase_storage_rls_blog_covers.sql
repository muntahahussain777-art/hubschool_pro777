-- =============================================================
--  HubSchool Pro – Storage RLS for blog-covers bucket
--  Run in Supabase SQL Editor after creating bucket "blog-covers"
-- =============================================================

-- Ensure bucket exists (skip if already created via Dashboard)
INSERT INTO storage.buckets (id, name, public)
VALUES ('blog-covers', 'blog-covers', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- Drop existing so re-run is safe
DROP POLICY IF EXISTS "Public read blog-covers" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated upload blog-covers" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated update blog-covers" ON storage.objects;
DROP POLICY IF EXISTS "Authenticated delete blog-covers" ON storage.objects;

-- Policy: Allow public read (so images show on public site)
CREATE POLICY "Public read blog-covers"
ON storage.objects FOR SELECT
USING (bucket_id = 'blog-covers');

-- Policy: Authenticated users can upload (insert)
CREATE POLICY "Authenticated upload blog-covers"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'blog-covers');

-- Policy: Authenticated users can update their uploads
CREATE POLICY "Authenticated update blog-covers"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'blog-covers');

-- Policy: Authenticated users can delete
CREATE POLICY "Authenticated delete blog-covers"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'blog-covers');

-- =============================================================
--  If you use anon key for uploads (e.g. from Flutter with anon),
--  you may need an additional policy. By default Supabase Flutter
--  uses the anon key; if the user is logged in, JWT includes role.
--  So "authenticated" applies when user has signed in.
-- =============================================================
