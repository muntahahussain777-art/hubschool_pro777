-- =============================================================
--  HubSchool Pro – CMS: Blog/News + Announcements
--  Run in Supabase SQL Editor. Create Storage bucket "blog-covers" in Dashboard if using uploads.
-- =============================================================

-- Enable UUID extension if not already
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ─────────────────────────────────────────────
--  blog_posts (full CMS blog/news)
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS blog_posts (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title            TEXT NOT NULL,
  slug             TEXT UNIQUE NOT NULL,
  summary          TEXT,
  content          TEXT,
  cover_image_url  TEXT,
  category         TEXT NOT NULL DEFAULT 'Blog',  -- Blog, News, Event, Update
  author_name      TEXT,
  tags             TEXT,                         -- comma-separated or JSON
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
--  announcements
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS announcements (
  id           UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title        TEXT NOT NULL,
  message      TEXT NOT NULL,
  type         TEXT NOT NULL DEFAULT 'announcement',  -- announcement, holiday, exam, admission, urgent
  priority     TEXT NOT NULL DEFAULT 'normal',       -- normal, important, urgent
  is_published BOOLEAN NOT NULL DEFAULT TRUE,
  is_pinned    BOOLEAN NOT NULL DEFAULT FALSE,
  start_date   TIMESTAMPTZ,
  end_date     TIMESTAMPTZ,
  attachment_url TEXT,
  created_at   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at   TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_announcements_dates ON announcements(start_date, end_date);
CREATE INDEX IF NOT EXISTS idx_announcements_published ON announcements(is_published) WHERE is_published = TRUE;

-- =============================================================
--  Storage: Create bucket "blog-covers" in Supabase Dashboard
--  → Storage → New bucket → Name: blog-covers → Public
--  RLS: Allow public read; allow authenticated insert/update/delete
-- =============================================================
