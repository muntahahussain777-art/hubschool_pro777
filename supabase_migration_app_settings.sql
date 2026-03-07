-- Pass/fail and other app settings (persisted).
CREATE TABLE IF NOT EXISTS app_settings (
  key   TEXT PRIMARY KEY,
  value TEXT NOT NULL
);
INSERT INTO app_settings (key, value) VALUES ('pass_percentage', '40')
ON CONFLICT (key) DO NOTHING;
