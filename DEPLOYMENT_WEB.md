# HubSchool Pro – Web Deployment

Same Flutter project: **Android** = existing app; **Web** = VIP web app (dashboard + school website).

## Build

**Use the web-only entry point** (avoids Drift/SQLite which uses dart:ffi and is not available on web):

```bash
flutter build web -t lib/main_web.dart
```

Output: `build/web/` (static assets: `index.html`, main_web.dart.js, etc.)

Do **not** use `flutter build web` without `-t lib/main_web.dart` or the build will fail (mobile app uses SQLite).

## Environment variables

- **Development:** Edit `lib/config/supabase_config.dart` (url + anonKey).
- **Production:** Prefer build-time injection so keys are not in repo:

```bash
flutter build web \
  --dart-define=SUPABASE_URL=https://xxxx.supabase.co \
  --dart-define=SUPABASE_ANON_KEY=your_anon_key
```

In `main.dart` or a small `env_loader.dart` you can read them with:

```dart
const String.fromEnvironment('SUPABASE_URL', defaultValue: '')
```

(If you keep using `SupabaseConfig` in code, you’d need to switch that to `String.fromEnvironment` when building for production.)

## GitHub

1. Create repo, push code.
2. Do **not** commit real keys. Use GitHub Secrets for CI (e.g. `SUPABASE_URL`, `SUPABASE_ANON_KEY`).
3. In Actions or your host, run `flutter build web` with `--dart-define` from secrets.

## Vercel

1. **Connect** the GitHub repo to Vercel.
2. **Framework preset:** Other (or static).
3. **Build command:**
   ```bash
   flutter pub get && flutter build web -t lib/main_web.dart --dart-define=SUPABASE_URL=$SUPABASE_URL --dart-define=SUPABASE_ANON_KEY=$SUPABASE_ANON_KEY
   ```
4. **Output directory:** `build/web`
5. **Install command:** (optional) `flutter pub get`
6. Add env vars in Vercel: `SUPABASE_URL`, `SUPABASE_ANON_KEY`.

## Netlify

1. **New site from Git** → choose repo.
2. **Build command:**
   ```bash
   flutter pub get && flutter build web -t lib/main_web.dart
   ```
   (Or with env: use Netlify env vars and `--dart-define=SUPABASE_URL=$SUPABASE_URL` etc.)
3. **Publish directory:** `build/web`
4. **Environment variables** in Netlify UI: `SUPABASE_URL`, `SUPABASE_ANON_KEY` (if using dart-define from env).

## Supabase (same project)

- Use **same** Supabase project and database.
- **RLS:** Parents see only their child; teachers only assigned classes; admin full access.
- Optional tables: `news`, `blog_posts`, `categories`, `tags` for News & Blog (create in SQL and add RLS).

## Post-deploy

- Point your domain to Vercel/Netlify.
- In Supabase Dashboard → Authentication → URL configuration, add your production site URL to **Redirect URLs**.
