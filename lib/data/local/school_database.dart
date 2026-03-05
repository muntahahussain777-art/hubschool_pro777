import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

// Tables
part 'tables/roles_table.dart';
part 'tables/users_table.dart';
part 'tables/classrooms_table.dart';
part 'tables/students_table.dart';
part 'tables/enrollments_table.dart';
part 'tables/fee_heads_table.dart';
part 'tables/fee_structures_table.dart';
part 'tables/fee_invoices_table.dart';
part 'tables/fee_invoice_lines_table.dart';
part 'tables/fee_payments_table.dart';
part 'tables/fee_payment_allocations_table.dart';
part 'tables/staff_table.dart';
part 'tables/staff_attendance_table.dart';
part 'tables/salary_advances_table.dart';
part 'tables/payroll_runs_table.dart';
part 'tables/payroll_lines_table.dart';
part 'tables/exams_table.dart';
part 'tables/exam_components_table.dart';
part 'tables/exam_marks_table.dart';
part 'tables/grade_scales_table.dart';
part 'tables/expense_categories_table.dart';
part 'tables/expenses_table.dart';
part 'tables/sync_queue_table.dart';
part 'tables/subjects_table.dart';
part 'tables/teacher_assignments_table.dart';

// DAOs
part 'daos/students_dao.dart';
part 'daos/fees_dao.dart';
part 'daos/staff_dao.dart';
part 'daos/exams_dao.dart';
part 'daos/expenses_dao.dart';
part 'daos/sync_dao.dart';
part 'daos/dashboard_dao.dart';
part 'daos/settings_dao.dart';

part 'school_database.g.dart';

@DriftDatabase(
  tables: [
    Roles,
    Users,
    Classrooms,
    Students,
    Enrollments,
    FeeHeads,
    FeeStructures,
    FeeInvoices,
    FeeInvoiceLines,
    FeePayments,
    FeePaymentAllocations,
    Staff,
    StaffAttendance,
    SalaryAdvances,
    PayrollRuns,
    PayrollLines,
    Exams,
    ExamComponents,
    ExamMarks,
    GradeScales,
    ExpenseCategories,
    Expenses,
    SyncQueue,
    Subjects,
    TeacherAssignments,
  ],
  daos: [
    StudentsDao,
    FeesDao,
    StaffDao,
    ExamsDao,
    ExpensesDao,
    SyncDao,
    SettingsDao,
    DashboardDao,
  ],
)
class SchoolDatabase extends _$SchoolDatabase {
  SchoolDatabase() : super(_openConnection());

  SchoolDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await _seedDefaults();
        },
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(students, students.gender);
          }
        },
      );

  Future<void> _seedDefaults() async {
    // Seed roles
    await into(roles).insertOnConflictUpdate(RolesCompanion.insert(code: 'admin', name: 'Administrator'));
    await into(roles).insertOnConflictUpdate(RolesCompanion.insert(code: 'principal', name: 'Principal'));
    await into(roles).insertOnConflictUpdate(RolesCompanion.insert(code: 'teacher', name: 'Teacher'));

    // Seed fee heads
    final feeHeadList = [
      FeeHeadsCompanion.insert(code: 'tuition', name: 'Tuition Fee'),
      FeeHeadsCompanion.insert(code: 'library', name: 'Library Fee'),
      FeeHeadsCompanion.insert(code: 'sports', name: 'Sports Fee'),
      FeeHeadsCompanion.insert(code: 'fine', name: 'Fine'),
      FeeHeadsCompanion.insert(code: 'discount', name: 'Scholarship Discount', isDiscount: const Value(true)),
    ];
    for (final head in feeHeadList) {
      await into(feeHeads).insertOnConflictUpdate(head);
    }

    // Seed grade scale
    final grades = [
      GradeScalesCompanion.insert(minPercent: 90, maxPercent: 100, grade: 'A+', remark: const Value('Outstanding')),
      GradeScalesCompanion.insert(minPercent: 80, maxPercent: 89.99, grade: 'A', remark: const Value('Excellent')),
      GradeScalesCompanion.insert(minPercent: 70, maxPercent: 79.99, grade: 'B', remark: const Value('Very Good')),
      GradeScalesCompanion.insert(minPercent: 60, maxPercent: 69.99, grade: 'C', remark: const Value('Good')),
      GradeScalesCompanion.insert(minPercent: 50, maxPercent: 59.99, grade: 'D', remark: const Value('Satisfactory')),
      GradeScalesCompanion.insert(minPercent: 0, maxPercent: 49.99, grade: 'F', remark: const Value('Fail')),
    ];
    for (final g in grades) {
      await into(gradeScales).insertOnConflictUpdate(g);
    }

    // Seed expense categories
    final cats = ['Salaries', 'Utilities', 'Stationery', 'Maintenance', 'Events', 'Other'];
    for (final c in cats) {
      await into(expenseCategories).insertOnConflictUpdate(ExpenseCategoriesCompanion.insert(name: c));
    }

    // Seed default admin user (password: admin123 -> sha256 hash stored in prod)
    final roleId = await (select(roles)..where((r) => r.code.equals('admin'))).getSingleOrNull();
    if (roleId != null) {
      await into(users).insertOnConflictUpdate(
        UsersCompanion.insert(
          username: 'admin',
          passwordHash: 'admin123',
          roleId: roleId.id,
        ),
      );
    }
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'hubschool_pro.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
