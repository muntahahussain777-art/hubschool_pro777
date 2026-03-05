-- =============================================================
--  HubSchool Pro  –  Complete Supabase / PostgreSQL Schema
--  Paste this entire file in Supabase SQL Editor and click RUN
--  All amounts stored in PAISA (integer).  Divide by 100 for Rs.
-- =============================================================

-- Enable UUID extension (needed for qr_token generation)
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ─────────────────────────────────────────────
--  1.  RBAC  (Roles & Users)
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS roles (
    id          SERIAL PRIMARY KEY,
    code        TEXT NOT NULL UNIQUE,          -- admin | principal | teacher
    name        TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS users (
    id            SERIAL PRIMARY KEY,
    username      TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    role_id       INTEGER NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- ─────────────────────────────────────────────
--  2.  Academic  (Classrooms, Students, Enrollments)
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS classrooms (
    id             SERIAL PRIMARY KEY,
    name           TEXT NOT NULL,              -- e.g. "Grade 8"
    section        TEXT NOT NULL DEFAULT 'A',
    academic_year  INTEGER NOT NULL            -- e.g. 2026
);

CREATE TABLE IF NOT EXISTS students (
    id            SERIAL PRIMARY KEY,
    admission_no  TEXT NOT NULL UNIQUE,
    full_name     TEXT NOT NULL,
    father_name   TEXT NOT NULL,
    dob           DATE,
    phone         TEXT,
    address       TEXT,
    photo_path    TEXT,
    qr_token      TEXT NOT NULL UNIQUE DEFAULT gen_random_uuid()::TEXT,
    is_active     BOOLEAN NOT NULL DEFAULT TRUE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS enrollments (
    id            SERIAL PRIMARY KEY,
    student_id    INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    classroom_id  INTEGER NOT NULL REFERENCES classrooms(id) ON DELETE RESTRICT,
    enrolled_on   TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    current       BOOLEAN NOT NULL DEFAULT TRUE
);

-- ─────────────────────────────────────────────
--  3.  Fee Management
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS fee_heads (
    id          SERIAL PRIMARY KEY,
    code        TEXT NOT NULL UNIQUE,          -- tuition | library | fine | discount
    name        TEXT NOT NULL,
    is_discount BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS fee_structures (
    id              SERIAL PRIMARY KEY,
    classroom_id    INTEGER NOT NULL REFERENCES classrooms(id) ON DELETE CASCADE,
    fee_head_id     INTEGER NOT NULL REFERENCES fee_heads(id) ON DELETE RESTRICT,
    amount          INTEGER NOT NULL,          -- in paisa
    frequency       TEXT NOT NULL DEFAULT 'monthly',  -- monthly | one_time | annual
    effective_from  DATE NOT NULL,
    effective_to    DATE
);

CREATE TABLE IF NOT EXISTS fee_invoices (
    id               SERIAL PRIMARY KEY,
    student_id       INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    month_key        TEXT NOT NULL,            -- "2026-03"
    total_amount     INTEGER NOT NULL,         -- in paisa
    discount_amount  INTEGER NOT NULL DEFAULT 0,
    net_amount       INTEGER NOT NULL,
    paid_amount      INTEGER NOT NULL DEFAULT 0,
    due_amount       INTEGER NOT NULL,
    status           TEXT NOT NULL DEFAULT 'unpaid',  -- unpaid | partial | paid
    due_date         DATE,
    created_at       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS fee_invoice_lines (
    id           SERIAL PRIMARY KEY,
    invoice_id   INTEGER NOT NULL REFERENCES fee_invoices(id) ON DELETE CASCADE,
    fee_head_id  INTEGER NOT NULL REFERENCES fee_heads(id) ON DELETE RESTRICT,
    amount       INTEGER NOT NULL               -- in paisa
);

CREATE TABLE IF NOT EXISTS fee_payments (
    id            SERIAL PRIMARY KEY,
    student_id    INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    amount        INTEGER NOT NULL,             -- in paisa
    method        TEXT NOT NULL DEFAULT 'cash', -- cash | bank | jazzcash | easypaisa
    reference_no  TEXT,
    paid_at       TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    received_by   INTEGER NOT NULL REFERENCES users(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS fee_payment_allocations (
    id          SERIAL PRIMARY KEY,
    payment_id  INTEGER NOT NULL REFERENCES fee_payments(id) ON DELETE CASCADE,
    invoice_id  INTEGER NOT NULL REFERENCES fee_invoices(id) ON DELETE CASCADE,
    amount      INTEGER NOT NULL                -- in paisa
);

-- ─────────────────────────────────────────────
--  4.  Staff & Payroll
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS staff (
    id                 SERIAL PRIMARY KEY,
    employee_code      TEXT NOT NULL UNIQUE,
    full_name          TEXT NOT NULL,
    designation        TEXT NOT NULL DEFAULT 'Teacher',
    phone              TEXT,
    base_salary        INTEGER NOT NULL,        -- in paisa
    biometric_enabled  BOOLEAN NOT NULL DEFAULT FALSE,
    is_active          BOOLEAN NOT NULL DEFAULT TRUE,
    joining_date       TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS staff_attendance (
    id                  SERIAL PRIMARY KEY,
    staff_id            INTEGER NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    date                DATE NOT NULL,
    status              TEXT NOT NULL DEFAULT 'present',  -- present | absent | leave
    biometric_verified  BOOLEAN NOT NULL DEFAULT FALSE,
    note                TEXT,
    UNIQUE (staff_id, date)
);

-- Subjects (for teacher assignments & curriculum)
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

CREATE TABLE IF NOT EXISTS salary_advances (
    id           SERIAL PRIMARY KEY,
    staff_id     INTEGER NOT NULL REFERENCES staff(id) ON DELETE CASCADE,
    amount       INTEGER NOT NULL,              -- in paisa
    deducted     BOOLEAN NOT NULL DEFAULT FALSE,
    advanced_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    note         TEXT
);

CREATE TABLE IF NOT EXISTS payroll_runs (
    id            SERIAL PRIMARY KEY,
    month_key     TEXT NOT NULL UNIQUE,         -- "2026-03"
    generated_at  TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    generated_by  INTEGER NOT NULL REFERENCES users(id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS payroll_lines (
    id                SERIAL PRIMARY KEY,
    payroll_run_id    INTEGER NOT NULL REFERENCES payroll_runs(id) ON DELETE CASCADE,
    staff_id          INTEGER NOT NULL REFERENCES staff(id) ON DELETE RESTRICT,
    gross_pay         INTEGER NOT NULL,         -- in paisa
    advance_deduction INTEGER NOT NULL DEFAULT 0,
    absent_deduction  INTEGER NOT NULL DEFAULT 0,
    net_pay           INTEGER NOT NULL,         -- in paisa
    status            TEXT NOT NULL DEFAULT 'pending' -- pending | paid
);

-- ─────────────────────────────────────────────
--  5.  Exam Engine
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS exams (
    id            SERIAL PRIMARY KEY,
    title         TEXT NOT NULL,               -- "Mid Term", "Final"
    classroom_id  INTEGER NOT NULL REFERENCES classrooms(id) ON DELETE CASCADE,
    exam_date     DATE,
    is_published  BOOLEAN NOT NULL DEFAULT FALSE,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS exam_components (
    id       SERIAL PRIMARY KEY,
    exam_id  INTEGER NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
    name     TEXT NOT NULL,                    -- theory | viva | practical
    weight   NUMERIC(4,3) NOT NULL DEFAULT 1.0,
    max_marks INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS exam_marks (
    id               SERIAL PRIMARY KEY,
    exam_id          INTEGER NOT NULL REFERENCES exams(id) ON DELETE CASCADE,
    student_id       INTEGER NOT NULL REFERENCES students(id) ON DELETE CASCADE,
    component_id     INTEGER NOT NULL REFERENCES exam_components(id) ON DELETE CASCADE,
    marks_obtained   NUMERIC(6,2) NOT NULL DEFAULT 0,
    UNIQUE (exam_id, student_id, component_id)
);

CREATE TABLE IF NOT EXISTS grade_scales (
    id           SERIAL PRIMARY KEY,
    min_percent  NUMERIC(5,2) NOT NULL,
    max_percent  NUMERIC(5,2) NOT NULL,
    grade        TEXT NOT NULL,               -- A+, A, B, C, D, F
    remark       TEXT
);

-- ─────────────────────────────────────────────
--  6.  Expenses (Vouchers)
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS expense_categories (
    id    SERIAL PRIMARY KEY,
    name  TEXT NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS expenses (
    id           SERIAL PRIMARY KEY,
    category_id  INTEGER NOT NULL REFERENCES expense_categories(id) ON DELETE RESTRICT,
    amount       INTEGER NOT NULL,             -- in paisa
    voucher_no   TEXT NOT NULL UNIQUE,
    note         TEXT,
    spent_at     TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    approved_by  INTEGER REFERENCES users(id) ON DELETE SET NULL
);

-- ─────────────────────────────────────────────
--  7.  Offline Sync Queue  (Flutter → Supabase bridge)
-- ─────────────────────────────────────────────

CREATE TABLE IF NOT EXISTS sync_queue (
    id            SERIAL PRIMARY KEY,
    entity        TEXT NOT NULL,               -- fee_payment | student | attendance …
    operation     TEXT NOT NULL,               -- insert | update | delete
    payload_json  JSONB NOT NULL,
    status        TEXT NOT NULL DEFAULT 'pending', -- pending | synced | failed
    retry_count   INTEGER NOT NULL DEFAULT 0,
    created_at    TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    last_tried_at TIMESTAMPTZ
);

-- =============================================================
--  INDEXES  (performance for common queries)
-- =============================================================

CREATE INDEX IF NOT EXISTS idx_students_active        ON students(is_active);
CREATE INDEX IF NOT EXISTS idx_students_admission_no  ON students(admission_no);
CREATE INDEX IF NOT EXISTS idx_enrollments_student    ON enrollments(student_id, current);
CREATE INDEX IF NOT EXISTS idx_fee_invoices_student   ON fee_invoices(student_id);
CREATE INDEX IF NOT EXISTS idx_fee_invoices_month     ON fee_invoices(month_key);
CREATE INDEX IF NOT EXISTS idx_fee_invoices_status    ON fee_invoices(status);
CREATE INDEX IF NOT EXISTS idx_fee_payments_student   ON fee_payments(student_id);
CREATE INDEX IF NOT EXISTS idx_staff_active           ON staff(is_active);
CREATE INDEX IF NOT EXISTS idx_staff_attendance_date  ON staff_attendance(date);
CREATE INDEX IF NOT EXISTS idx_student_attendance_date ON student_attendance(date);
CREATE INDEX IF NOT EXISTS idx_exam_marks_exam        ON exam_marks(exam_id);
CREATE INDEX IF NOT EXISTS idx_exam_marks_student     ON exam_marks(student_id);
CREATE INDEX IF NOT EXISTS idx_expenses_spent_at      ON expenses(spent_at);
CREATE INDEX IF NOT EXISTS idx_sync_queue_status      ON sync_queue(status, created_at);

-- =============================================================
--  DEFAULT SEED DATA
-- =============================================================

-- Roles
INSERT INTO roles (code, name) VALUES
  ('admin',     'Administrator'),
  ('principal', 'Principal'),
  ('teacher',   'Teacher')
ON CONFLICT (code) DO NOTHING;

-- Default Admin User  (password: admin123 — CHANGE IN PRODUCTION!)
INSERT INTO users (username, password_hash, role_id)
SELECT 'admin', 'admin123', id FROM roles WHERE code = 'admin'
ON CONFLICT (username) DO NOTHING;

-- Fee Heads
INSERT INTO fee_heads (code, name, is_discount) VALUES
  ('tuition',   'Tuition Fee',           FALSE),
  ('library',   'Library Fee',           FALSE),
  ('sports',    'Sports Fee',            FALSE),
  ('fine',      'Fine',                  FALSE),
  ('discount',  'Scholarship Discount',  TRUE)
ON CONFLICT (code) DO NOTHING;

-- Grade Scale
INSERT INTO grade_scales (min_percent, max_percent, grade, remark) VALUES
  (90,    100,   'A+', 'Outstanding'),
  (80,    89.99, 'A',  'Excellent'),
  (70,    79.99, 'B',  'Very Good'),
  (60,    69.99, 'C',  'Good'),
  (50,    59.99, 'D',  'Satisfactory'),
  ( 0,    49.99, 'F',  'Fail');

-- Expense Categories
INSERT INTO expense_categories (name) VALUES
  ('Salaries'),
  ('Utilities'),
  ('Stationery'),
  ('Maintenance'),
  ('Events'),
  ('Other')
ON CONFLICT (name) DO NOTHING;

-- =============================================================
--  ROW LEVEL SECURITY (RLS) — Optional but recommended
--  Enable per table in Supabase Dashboard → Table Editor → RLS
-- =============================================================

-- Example: Only authenticated users can read/write
-- ALTER TABLE students     ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE fee_invoices ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE staff        ENABLE ROW LEVEL SECURITY;
-- ALTER TABLE expenses     ENABLE ROW LEVEL SECURITY;

-- CREATE POLICY "authenticated_all" ON students
--   FOR ALL TO authenticated USING (true) WITH CHECK (true);

-- =============================================================
--  USEFUL VIEWS  (ready-to-use for reports)
-- =============================================================

-- Monthly revenue summary
CREATE OR REPLACE VIEW v_monthly_revenue AS
SELECT
    month_key,
    COUNT(*)                      AS total_invoices,
    SUM(net_amount)               AS total_billed,      -- paisa
    SUM(paid_amount)              AS total_collected,   -- paisa
    SUM(due_amount)               AS total_pending,     -- paisa
    COUNT(*) FILTER (WHERE status = 'paid')     AS paid_count,
    COUNT(*) FILTER (WHERE status = 'partial')  AS partial_count,
    COUNT(*) FILTER (WHERE status = 'unpaid')   AS unpaid_count
FROM fee_invoices
GROUP BY month_key
ORDER BY month_key DESC;

-- Student fee status with name
CREATE OR REPLACE VIEW v_student_fee_summary AS
SELECT
    s.id              AS student_id,
    s.full_name,
    s.admission_no,
    COUNT(fi.id)                         AS total_invoices,
    COALESCE(SUM(fi.net_amount),   0)    AS total_billed,
    COALESCE(SUM(fi.paid_amount),  0)    AS total_paid,
    COALESCE(SUM(fi.due_amount),   0)    AS total_due
FROM students s
LEFT JOIN fee_invoices fi ON fi.student_id = s.id
WHERE s.is_active = TRUE
GROUP BY s.id, s.full_name, s.admission_no
ORDER BY total_due DESC;

-- Staff payroll summary
CREATE OR REPLACE VIEW v_payroll_summary AS
SELECT
    pl.payroll_run_id,
    pr.month_key,
    st.full_name,
    st.designation,
    pl.gross_pay,
    pl.advance_deduction,
    pl.absent_deduction,
    pl.net_pay,
    pl.status
FROM payroll_lines pl
JOIN payroll_runs pr ON pr.id = pl.payroll_run_id
JOIN staff st         ON st.id = pl.staff_id
ORDER BY pr.month_key DESC, st.full_name;

-- Exam result with grade
CREATE OR REPLACE VIEW v_exam_results AS
SELECT
    em.exam_id,
    e.title      AS exam_title,
    em.student_id,
    s.full_name  AS student_name,
    s.admission_no,
    ec.name      AS component,
    ec.max_marks,
    ec.weight,
    em.marks_obtained,
    ROUND(em.marks_obtained * ec.weight, 2) AS weighted_score
FROM exam_marks em
JOIN exams           e  ON e.id  = em.exam_id
JOIN students        s  ON s.id  = em.student_id
JOIN exam_components ec ON ec.id = em.component_id
ORDER BY em.exam_id, s.full_name, ec.name;

-- =============================================================
--  END OF SCHEMA
-- =============================================================
