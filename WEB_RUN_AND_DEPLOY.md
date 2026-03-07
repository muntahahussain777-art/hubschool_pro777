# HubSchool Pro – Web App: Run, Test & Live Deploy

Is guide mein: **Chrome launch fail** hone par kaise run karein, **development** mein test, aur **live deploy** (Vercel/Netlify) + Admin/Teacher/Parent panel test. Android app aur Supabase sync safe rehenge.

---

## Part 1: Web App Development Mein Run Karna (Chrome Fail Fix)

### Option A: Web server use karke browser khud kholna (recommended)

Chrome auto-launch fail ho to Flutter ko sirf **server** start karo, phir aap **khud** browser mein URL kholo.

**Step 1:** Terminal mein project folder:

```bash
cd F:\SchoolFlutterProject\hubschool_pro
```

**Step 2:** Web **server** pe run karo (browser auto-open nahi hoga):

```bash
flutter run -d web-server -t lib/main_web.dart
```

**Step 3:** Jab output mein aisa kuch dikhe:

```
The web server is running at http://localhost:XXXXX
```

**Step 4:** Khud **Chrome** ya **Edge** kholo aur address bar mein ye daalo (port number apna dekho):

```
http://localhost:XXXXX
```

Example: `http://localhost:12345`

- **Hot reload:** Terminal mein `r` dabao.
- **Stop:** Terminal mein `q` dabao.

---

### Option B: Edge se direct run (Chrome ki jagah)

Agar Edge install hai to device name `edge` use karo:

```bash
flutter run -d edge -t lib/main_web.dart
```

Agar ye bhi fail ho to **Option A** (web-server) use karo.

---

### Option C: Chrome path / permissions (advanced)

- **Chrome** default path: `C:\Program Files\Google\Chrome\Application\chrome.exe`
- Kabhi antivirus ya policy is path ko block karti hai.
- **Solution:** Option A use karo; browser manually open karna reliable hai.

---

## Part 2: Local Test Checklist (Development)

Jab `http://localhost:XXXXX` pe app chal rahi ho:

1. **Public pages:** Home, About, Admissions, Contact – sab load hon.
2. **Login:** Supabase Auth (email/password) – test user se login.
3. **Role redirect:** Login ke baad role ke hisaab se:
   - `admin` → `/admin`
   - `teacher` → `/teacher`
   - `operator` → `/operator`
   - `parent` → `/parent`
4. **Responsive:** Window chota karo – menu icon + Drawer aana chahiye.
5. **Supabase:** `lib/config/supabase_config.dart` mein jo URL/anonKey hai wahi use ho raha hai; same project pe Android bhi sync karega.

**Android app safe:** `lib/main.dart` change mat karo; web hamesha `-t lib/main_web.dart` se chalegi.

---

## Part 3: Live Deploy (Vercel ya Netlify)

### 3.1 Pehle local build check

```bash
cd F:\SchoolFlutterProject\hubschool_pro
flutter pub get
flutter build web -t lib/main_web.dart
```

`build/web/` folder banna chahiye (index.html, JS, assets). Agar build fail ho to pehle isko fix karo.

---

### 3.2 Vercel pe deploy (step-by-step)

1. **Vercel:** https://vercel.com → Login (GitHub se).
2. **Add New Project** → **Import** → repo select karo: `muntahahussain777-art/hubschool_pro`.
3. **Configure:**
   - **Framework Preset:** Other
   - **Root Directory:** (blank / `./`)
   - **Build Command:**
     ```bash
     flutter pub get && flutter build web -t lib/main_web.dart
     ```
   - **Output Directory:** `build/web`
   - **Install Command:** (optional) `flutter pub get` ya blank (build command mein hai).
4. **Environment Variables** (agar aap baad mein build-time pe keys inject karna chahte ho):
   - `SUPABASE_URL` = your Supabase project URL
   - `SUPABASE_ANON_KEY` = your anon key  
   (Abhi aap `supabase_config.dart` use kar rahe ho to skip bhi kar sakte ho; production mein secrets use karna behtar hai.)
5. **Deploy** dabao. Build complete hone ke baad aapko URL milega: `https://hubschool-pro-xxx.vercel.app`.

---

### 3.3 Netlify pe deploy (alternative)

1. **Netlify:** https://app.netlify.com → **Add new site** → **Import an existing project** → GitHub → `hubschool_pro` select.
2. **Build settings:**
   - **Build command:**
     ```bash
     flutter pub get && flutter build web -t lib/main_web.dart
     ```
   - **Publish directory:** `build/web`
3. **Deploy.** Site URL milega: `https://something.netlify.app`.

---

### 3.4 Supabase: Redirect URLs add karna (important)

Login / logout ke baad redirect sahi ho, iske liye Supabase ko production URL batana zaroori hai.

1. **Supabase Dashboard** → apna project → **Authentication** → **URL Configuration**.
2. **Redirect URLs** mein add karo (apna URL daalo):
   - Vercel: `https://hubschool-pro-xxx.vercel.app/**`
   - Netlify: `https://your-site.netlify.app/**`
3. **Site URL** (optional): production URL daal sakte ho taaki emails mein sahi link aaye.

Save karo. Ab web app se login/logout production pe theek kaam karega.

---

## Part 4: Live Deploy Ke Baad – Admin / Teacher / Parent Panel Test

1. **Production URL** kholo (Vercel/Netlify).
2. **Public pages** check karo: Home, About, Admissions, Contact.
3. **Login:** Supabase Auth wale test user se (email/password).
4. **Role test:**
   - **Admin user:** Supabase → Authentication → Users → user select → **Edit** → User Metadata: `{"role":"admin"}` → Save. Phir login karke `/admin` pe redirect hona chahiye.
   - **Teacher:** metadata `{"role":"teacher"}` → `/teacher`.
   - **Operator:** `{"role":"operator"}` → `/operator`.
   - **Parent:** `{"role":"parent"}` → `/parent`.
5. **Panels:** Har role ke dashboard / placeholder pages load hon, sidebar/drawer kaam kare.

---

## Part 5: Admin / Username Login (admin / admin123@)

Website pe **username “admin”** aur **password “admin123@”** se login karne ke liye Supabase me ek user banana zaroori hai:

1. **Supabase Dashboard** → **Authentication** → **Users** → **Add user** → **Create new user**.
2. **Email:** `admin@hubschool.local`
3. **Password:** `admin123@`
4. **User Metadata** (optional but recommended): `{ "role": "admin" }`
5. Create karo. Ab website pe **Email or Username** field me `admin` aur Password me `admin123@` daal kar Sign in karo.

Agar pehle se **students** table bina `classroom_id`, `monthly_fee`, `previous_school`, `gender` ke banaya tha, to **SQL Editor** me `supabase_migration_students_extra.sql` chala lo (ya naye install me `supabase_schema.sql` me ye columns already hain).

---

## Part 6: Android App Safe + Supabase Sync

- **Android:** Bilkul change nahi. `flutter run` / `flutter build apk` same rehta hai; `lib/main.dart` use hota hai (SQLite/Drift + sync).
- **Supabase:** Dono (Android + Web) **same project** use karte hain:
  - Android: sync service same tables pe push/pull karega.
  - Web: direct Supabase client se same tables use karegi.
- **Keys:** `lib/config/supabase_config.dart` dono apps ke liye; production web ke liye optional: build-time `--dart-define=SUPABASE_URL=...` use karo aur code mein `String.fromEnvironment` read karo (optional step).

---

## Part 7: Website Features (Admission CRUD + Reports)

- **Students (Admission):** Admin → **Students** → list dikhegi; **Add Student** se naya admission, row pe **Edit** / **Delete**.
- **Reports:** Admin → **Reports** → Total Students, Fee Revenue, Expenses, Net; Recent Fee Invoices aur Recent Expenses tables.

---

## Short reference

| Task              | Command / Action |
|-------------------|------------------|
| Web run (no Chrome launch) | `flutter run -d web-server -t lib/main_web.dart` → browser mein `http://localhost:PORT` |
| Web run (Edge)    | `flutter run -d edge -t lib/main_web.dart` |
| Web build         | `flutter build web -t lib/main_web.dart` |
| Android run       | `flutter run` (unchanged) |
| Deploy (Vercel)   | Connect repo → Build: `flutter pub get && flutter build web -t lib/main_web.dart` → Output: `build/web` |
| Deploy (Netlify)  | Same build command, Publish: `build/web` |
| Supabase redirect | Auth → URL Configuration → Redirect URLs mein production URL add karo |

Agar kisi step pe error aaye to error message bhejo, uske hisaab se exact fix bata sakta hoon.
