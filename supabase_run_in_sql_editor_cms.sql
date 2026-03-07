-- =============================================================
--  HubSchool Pro – CMS Schema (Blog + Announcements)
--  Copy-paste this ENTIRE file into Supabase → SQL Editor → New query → Run
-- =============================================================

-- UUID extension
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ─────────────────────────────────────────────
--  TABLE: blog_posts
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS blog_posts (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title            TEXT NOT NULL,
  slug             TEXT UNIQUE NOT NULL,
  summary          TEXT,
  content          TEXT,
  cover_image_url  TEXT,
  category         TEXT NOT NULL DEFAULT 'Blog',
  author_name      TEXT,
  tags             TEXT,
  is_published     BOOLEAN NOT NULL DEFAULT FALSE,
  is_featured      BOOLEAN NOT NULL DEFAULT FALSE,
  is_pinned        BOOLEAN NOT NULL DEFAULT FALSE,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  published_at     TIMESTAMPTZ
);

CREATE INDEX IF NOT EXISTS idx_blog_posts_slug ON blog_posts(slug);
CREATE INDEX IF NOT EXISTS idx_blog_posts_published ON blog_posts(is_published) WHERE is_published = TRUE;
CREATE INDEX IF NOT EXISTS idx_blog_posts_category ON blog_posts(category);

-- ─────────────────────────────────────────────
--  TABLE: announcements
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS announcements (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title           TEXT NOT NULL,
  message         TEXT NOT NULL,
  type            TEXT NOT NULL DEFAULT 'announcement',
  priority        TEXT NOT NULL DEFAULT 'normal',
  is_published    BOOLEAN NOT NULL DEFAULT TRUE,
  is_pinned       BOOLEAN NOT NULL DEFAULT FALSE,
  start_date      TIMESTAMPTZ,
  end_date        TIMESTAMPTZ,
  attachment_url  TEXT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at      TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_announcements_dates ON announcements(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_announcements_published ON announcements(is_published) WHERE is_published = TRUE;

-- ─────────────────────────────────────────────
--  RLS (Row Level Security) – optional
--  Uncomment if you want only authenticated users to insert/update/delete
-- ─────────────────────────────────────────────

-- ALTER TABLE blog_posts ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE announcements ENABLE ROW LEVEL SECURITY;
-- CREATE POLICY "Public read blog_posts" ON blog_posts FOR SELECT USING (is_published = TRUE);
-- CREATE POLICY "Public read announcements" ON announcements FOR SELECT USING (is_published = TRUE);
-- CREATE POLICY "Admin all blog_posts" ON blog_posts FOR ALL USING (auth.role() = 'authenticated');
-- CREATE POLICY "Admin all announcements" ON announcements FOR ALL USING (auth.role() = 'authenticated');

-- =============================================================
--  STORAGE: blog-covers bucket (for cover images)
--  Run this ONLY if you want to create bucket via SQL.
--  Else create manually: Dashboard → Storage → New bucket → "blog-covers" → Public
-- =============================================================

INSERT INTO storage.buckets (id, name, public)
VALUES ('blog-covers', 'blog-covers', true)
ON CONFLICT (id) DO UPDATE SET public = true;

-- =============================================================
--  Done. Tables: blog_posts, announcements. Bucket: blog-covers
-- =============================================================
