# HubSchool Pro – Supabase Setup Guide

## Step 1: Supabase Project URL Lagayein

`lib/config/supabase_config.dart` mein:
```dart
static const String url = 'https://gsjxlpfjhsqnrcdrjudb.supabase.co';
                           //  ↑ Yahan apna actual URL daalen
```

Supabase URL milega:
Dashboard → Settings → API → "Project URL"

---

## Step 2: Supabase mein User Banana (Login ke liye)

Supabase Dashboard → Authentication → Users → "Invite User"

**Email:** admin@hubschool.com  (ya apna email)
**Password:** (jo aap chahein)

Yahi email/password Flutter app ke login mein use karein.

---

## Step 3: SQL Schema Run Karna (agar abhi tak nahi kiya)

Supabase Dashboard → SQL Editor → paste `supabase_schema.sql` → Run

---

## Step 4: Row Level Security (RLS) — Important!

Supabase Dashboard → Table Editor → har table ke liye:
1. "RLS" toggle ON karein
2. New Policy → "Allow all for authenticated users":
   - Policy Name: `allow_authenticated`
   - Target roles: `authenticated`
   - Using expression: `true`
   - With check: `true`

Ya ek baar main SQL Editor mein yeh run karein:

```sql
-- Enable RLS on all tables
ALTER TABLE roles               ENABLE ROW LEVEL SECURITY;
ALTER TABLE users               ENABLE ROW LEVEL SECURITY;
ALTER TABLE classrooms          ENABLE ROW LEVEL SECURITY;
ALTER TABLE students            ENABLE ROW LEVEL SECURITY;
ALTER TABLE enrollments         ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_heads           ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_structures      ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_invoices        ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_invoice_lines   ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_payments        ENABLE ROW LEVEL SECURITY;
ALTER TABLE fee_payment_allocations ENABLE ROW LEVEL SECURITY;
ALTER TABLE staff               ENABLE ROW LEVEL SECURITY;
ALTER TABLE staff_attendance    ENABLE ROW LEVEL SECURITY;
ALTER TABLE salary_advances     ENABLE ROW LEVEL SECURITY;
ALTER TABLE payroll_runs        ENABLE ROW LEVEL SECURITY;
ALTER TABLE payroll_lines       ENABLE ROW LEVEL SECURITY;
ALTER TABLE exams               ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_components     ENABLE ROW LEVEL SECURITY;
ALTER TABLE exam_marks          ENABLE ROW LEVEL SECURITY;
ALTER TABLE grade_scales        ENABLE ROW LEVEL SECURITY;
ALTER TABLE expense_categories  ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses            ENABLE ROW LEVEL SECURITY;
ALTER TABLE sync_queue          ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to do everything
DO $$
DECLARE
  tbl TEXT;
BEGIN
  FOREACH tbl IN ARRAY ARRAY[
    'roles','users','classrooms','students','enrollments',
    'fee_heads','fee_structures','fee_invoices','fee_invoice_lines',
    'fee_payments','fee_payment_allocations','staff','staff_attendance',
    'salary_advances','payroll_runs','payroll_lines','exams',
    'exam_components','exam_marks','grade_scales',
    'expense_categories','expenses','sync_queue'
  ] LOOP
    EXECUTE format(
      'CREATE POLICY allow_auth ON %I FOR ALL TO authenticated USING (true) WITH CHECK (true)',
      tbl
    );
  END LOOP;
END $$;
```

---

## Step 5: Realtime Enable Karna

Supabase Dashboard → Database → Replication → "supabase_realtime" publication:
- `fee_invoices` ✓
- `students` ✓
- `staff_attendance` ✓

---

## Keys Security Rules

| Key | Kahan use karein |
|-----|-----------------|
| `sb_publishable_*` (anon) | ✅ Flutter app (safe) |
| `sb_secret_*` (service role) | ❌ KABHI Flutter mein nahi — sirf server/functions mein |

---

## APK Install karne ke baad test karein:

1. Login → email/password (Supabase Auth)
2. Student add karein → offline store hoga
3. Internet lagayein → auto-sync Supabase mein jayega
4. Supabase Dashboard → Table Editor → students table check karein
