# HubSchool Pro – Web Application

VIP-level web app for the same Supabase project. Loaded **only on web**; Android app is unchanged.

## Structure

- **`app.dart`** – Entry (MaterialApp + router)
- **`router/`** – Role-based routing, auth redirect
- **`layout/`** – Dashboard sidebar (collapsible)
- **`config/roles.dart`** – Admin, Teacher, Operator, Parent
- **`features/auth/`** – Supabase Auth login
- **`features/public/`** – School website: Home, About, Admissions, Contact, News, Blog
- **`features/admin/`** – Admin panel (full access)
- **`features/teacher/`** – Teacher panel (assigned classes)
- **`features/operator/`** – Computer operator (students, ID cards, fee slips)
- **`features/parent/`** – Parent panel (own child only)
- **`theme/`** – Light/dark theme

## Roles (Supabase)

Set `user_metadata.role` on signup or in Dashboard:

- `admin` → full dashboard
- `teacher` → teacher panel
- `operator` → operator panel  
- `parent` → parent panel (RLS: only their child)

## Build

```bash
flutter build web -t lib/main_web.dart
```

Output: `build/web/`. The `-t lib/main_web.dart` entry point is required so the web build does not include Drift/SQLite (not supported on web).

## Environment

Use same `lib/config/supabase_config.dart` or override with:

```bash
flutter build web --dart-define=SUPABASE_URL=xxx --dart-define=SUPABASE_ANON_KEY=xxx
```

See project root `DEPLOYMENT_WEB.md` for Vercel/Netlify.
