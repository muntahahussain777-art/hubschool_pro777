# HubSchool Pro – Step by Step Guide

Is guide mein: **Flutter (Android) app** aur **Web app** dono kaise chalayein, **GitHub** pe kaise upload karein, aur **Supabase** mein tables kaise add karein — sab step by step.

---

## Part 1: Dono Apps Kaise Access / Run Karein

### A) Flutter Android App (Mobile) chalana

1. **Android device / emulator** connect karein (USB debugging ON ya emulator open).
2. Terminal / CMD open karein, project folder mein jayein:
   ```bash
   cd F:\SchoolFlutterProject\hubschool_pro
   ```
3. **Run (default = Android):**
   ```bash
   flutter run
   ```
   - Agar multiple devices hon to:
     ```bash
     flutter devices
     flutter run -d <device_id>
     ```
4. **Release APK** banane ke liye:
   ```bash
   flutter build apk --release
   ```
   - APK path: `build\app\outputs\flutter-apk\app-release.apk`

**Note:** Ye app **main.dart** use karti hai (SQLite/Drift + Supabase sync). Isko modify mat karein.

---

### B) Web App chalana

> **Chrome launch fail ho to:** See **`WEB_RUN_AND_DEPLOY.md`** — web-server method se run karo aur browser khud kholo; live deploy + panel test bhi wahi guide mein hai.

1. **Chrome** (recommended) open rakhein.
2. Same project folder mein:
   ```bash
   cd F:\SchoolFlutterProject\hubschool_pro
   ```
3. **Web entry point** use karke run karein:
   ```bash
   flutter run -d chrome -t lib/main_web.dart
   ```
   - Browser khul jayega, web app load hogi (public home, login, dashboard).
4. **Web build** (deploy ke liye):
   ```bash
   flutter build web -t lib/main_web.dart
   ```
   - Output: `build\web\` folder (isiko Vercel/Netlify pe upload karenge).

**Summary:**

| App           | Run command                                      | Build command                          |
|---------------|---------------------------------------------------|----------------------------------------|
| Android/Mobile| `flutter run`                                     | `flutter build apk --release`          |
| Web           | `flutter run -d chrome -t lib/main_web.dart`     | `flutter build web -t lib/main_web.dart` |

---

## Part 2: Web App Responsive

Web app ab **responsive** hai:

- **Desktop (width ≥ 720px):** Left sidebar + content; sidebar collapse/expand.
- **Tablet / Mobile (width < 720px):** Hamburger menu → Drawer open hota hai; content padding chota.
- Public home page: Chote screen pe nav drawer, bade pe top links.

Browser window chota–bada karke check kar sakte hain.

---

## Part 3: GitHub Pe Upload (Step by Step)

### Step 1: Git install / check

- Git install ho to:
  ```bash
  git --version
  ```

### Step 2: Project mein Git init (agar pehle se nahi hai)

```bash
cd F:\SchoolFlutterProject\hubschool_pro
git init
```

### Step 3: .gitignore check karein

Project root mein `.gitignore` hona chahiye, jisme ho:

- `build/`
- `.dart_tool/`
- `*.iml`
- `android/.gradle/`
- `pubspec.lock` (optional, team prefer kare to rakhein)

Agar nahi hai to Flutter default .gitignore use karein.

### Step 4: GitHub pe naya repo banayein

1. https://github.com pe login karein.
2. **New repository** click karein.
3. Repository name: e.g. `hubschool_pro`.
4. **Public** select karein (ya Private).
5. **Create repository** — README / .gitignore add mat karein (project mein already ho).

### Step 5: Local repo ko GitHub se link karein

GitHub par jo URL dikhe (e.g. `https://github.com/YOUR_USERNAME/hubschool_pro.git`), usko use karein:

```bash
cd F:\SchoolFlutterProject\hubschool_pro
git remote add origin https://github.com/YOUR_USERNAME/hubschool_pro.git
```

(Replace `YOUR_USERNAME` apne username se.)

### Step 6: Saari files add karein aur commit

```bash
git add .
git status
git commit -m "Initial commit: Flutter app + Web app"
```

### Step 7: GitHub pe push

```bash
git branch -M main
git push -u origin main
```

Ab repo GitHub pe dikh jana chahiye. Baad mein changes ke liye:

```bash
git add .
git commit -m "Your message"
git push
```

---

## Part 4: Supabase Mein Tables Add Karna (SQLite jaisa schema)

Android app **SQLite (Drift)** use karti hai; Web app **Supabase (PostgreSQL)**. Dono ko same data structure chahiye.

### Step 1: Supabase Dashboard kholna

1. https://supabase.com → Login.
2. Apna project select karein (jo URL `lib/config/supabase_config.dart` mein hai).
3. Left side **SQL Editor** pe click karein.
4. **New query** kholen.

### Step 2: Project ka complete SQL chalana

Project root mein **`supabase_schema.sql`** file hai — ye **complete schema** hai (saari tables, indexes, seed data, views).

1. `F:\SchoolFlutterProject\hubschool_pro\supabase_schema.sql` kholen.
2. **Saara content** copy karein (Ctrl+A, Ctrl+C).
3. Supabase **SQL Editor** mein paste karein.
4. **Run** dabayein.

Isse ye sab create ho jayega:

- **Tables:** roles, users, classrooms, students, enrollments, fee_heads, fee_structures, fee_invoices, fee_invoice_lines, fee_payments, fee_payment_allocations, staff, staff_attendance, salary_advances, payroll_runs, payroll_lines, exams, exam_components, exam_marks, grade_scales, expense_categories, expenses, sync_queue  
- **Extra tables** (agar aapne `supabase_schema.sql` update kiya hai): subjects, teacher_assignments, student_attendance  
- **Indexes** (fast queries)  
- **Seed data** (default roles, admin user, fee heads, grade scale, expense categories)  
- **Views** (monthly revenue, student fee summary, payroll summary, exam results)

**Note:**  
- Android app abhi bhi **local SQLite** use karti hai; sync service inhi Supabase tables se sync karega.  
- Web app inhi tables se Supabase client se read/write karegi.

### Step 3: Extra tables (agar purana schema chala rakha ho)

**Updated** `supabase_schema.sql` mein **subjects**, **teacher_assignments**, **student_attendance** pehle se add hain. Agar aapne purana (in tables ke bina) schema pehle chala rakha hai to **SQL Editor** mein ye alag se chalaen:

```sql
-- Subjects
CREATE TABLE IF NOT EXISTS subjects (
  id          SERIAL PRIMARY KEY,
  name        TEXT NOT NULL UNIQUE,
  code        TEXT,
  is_active   BOOLEAN NOT NULL DEFAULT TRUE
);

-- Teacher assignments (staff → classroom + subject)
CREATE TABLE IF NOT EXISTS teacher_assignments (
  id            SERIAL PRIMARY KEY,
  staff_id      INTEGER NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
  classroom_id  INTEGER NOT NULL REFERENCES classrooms(id) ON DELETE CASCADE,
  subject_id    INTEGER NOT NULL REFERENCES subjects(id) ON DELETE RESTRICT,
  is_active     BOOLEAN NOT NULL DEFAULT TRUE,
  created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (staff_id, classroom_id, subject_id)
);

-- Student attendance
CREATE TABLE IF NOT EXISTS student_attendance (
  id                 SERIAL PRIMARY KEY,
  student_id         INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
  date               DATE NOT NULL,
  status             TEXT NOT NULL DEFAULT 'present',
  biometric_verified BOOLEAN NOT NULL DEFAULT FALSE,
  time_in            TIMESTAMPTZ,
  time_out           TIMESTAMPTZ,
  note               TEXT,
  UNIQUE (student_id, date)
);

CREATE INDEX IF NOT EXISTS idx_student_attendance_date ON student_attendance(date);
```

### Step 4: RLS policies (optional, security ke liye)

Pehle sab ko allow karke test karein. Baad mein:

- **Admin:** sab tables pe full access.
- **Teacher:** sirf assigned classes / exams.
- **Parent:** sirf apne bacche ki rows (e.g. students join with parent user).
- **Operator:** students, fee_invoices, etc. (no delete/system).

Ye policies alag se bana sakte hain; guide sirf tables create karne tak hai.

---

## Part 5: Auth / Role (Web app ke liye)

Web app login **Supabase Auth** use karti hai. Role **user_metadata** se aata hai:

1. Supabase Dashboard → **Authentication** → **Users**.
2. User pe click karein → **Edit**.
3. **User Metadata** mein add karein:
   ```json
   { "role": "admin" }
   ```
   Values: `admin` | `teacher` | `operator` | `parent`

Isse web app ko pata chalega kis panel pe redirect karna hai.

---

## Short checklist

- [ ] Android: `flutter run` se app chalayi.
- [ ] Web: `flutter run -d chrome -t lib/main_web.dart` se browser mein chalayi.
- [ ] Web responsive: window resize karke drawer/sidebar check kiya.
- [ ] GitHub: repo bana, `git add` / `commit` / `push` kiya.
- [ ] Supabase: SQL Editor mein upar wala SQL chala kar saari tables create ki.
- [ ] Auth: test user ke liye `user_metadata.role` set kiya.

Agar kisi step pe error aaye to error message bhej dena, us hisaab se exact command ya SQL bata sakta hoon.
