/// ─────────────────────────────────────────────────────────
///  HubSchool Pro  –  Supabase Configuration
///
///  FILL IN your Supabase Project URL below.
///  You will find it in:
///    Supabase Dashboard → Settings → API → Project URL
///
///  Format:  https://XXXXXXXXXXXX.supabase.co
///
///  ⚠️  NEVER put the SECRET key here.
///      Only the ANON / PUBLISHABLE key belongs in Flutter.
/// ─────────────────────────────────────────────────────────
class SupabaseConfig {
  /// Your Supabase project URL
  /// Example: https://abcdefghij.supabase.co
  static const String url = 'https://gsjxlpfjhsqnrcdrjudb.supabase.co';

  /// Anon / Publishable key  (safe for Flutter)
  static const String anonKey =
      'sb_publishable_lkFS1SyM2h_zjA272vOfTg_Pgf6noWc';

  // Table names (keep in sync with schema)
  static const String tRoles               = 'roles';
  static const String tUsers               = 'users';
  static const String tClassrooms          = 'classrooms';
  static const String tStudents            = 'students';
  static const String tEnrollments         = 'enrollments';
  static const String tFeeHeads            = 'fee_heads';
  static const String tFeeStructures       = 'fee_structures';
  static const String tFeeInvoices         = 'fee_invoices';
  static const String tFeeInvoiceLines     = 'fee_invoice_lines';
  static const String tFeePayments         = 'fee_payments';
  static const String tFeePaymentAllocs    = 'fee_payment_allocations';
  static const String tStaff               = 'staff';
  static const String tStaffAttendance     = 'staff_attendance';
  static const String tSalaryAdvances      = 'salary_advances';
  static const String tPayrollRuns         = 'payroll_runs';
  static const String tPayrollLines        = 'payroll_lines';
  static const String tExams               = 'exams';
  static const String tExamComponents      = 'exam_components';
  static const String tExamMarks           = 'exam_marks';
  static const String tGradeScales         = 'grade_scales';
  static const String tExpenseCategories   = 'expense_categories';
  static const String tExpenses            = 'expenses';
  static const String tSyncQueue           = 'sync_queue';
}
