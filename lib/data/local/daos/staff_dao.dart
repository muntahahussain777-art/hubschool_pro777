part of '../school_database.dart';

@DriftAccessor(tables: [Staff, StaffAttendance, SalaryAdvances, PayrollRuns, PayrollLines])
class StaffDao extends DatabaseAccessor<SchoolDatabase> with _$StaffDaoMixin {
  StaffDao(super.db);

  Stream<List<StaffData>> watchActiveStaff() =>
      (select(staff)..where((s) => s.isActive.equals(true))).watch();

  Future<StaffData?> getStaffById(int id) =>
      (select(staff)..where((s) => s.id.equals(id))).getSingleOrNull();

  Future<int> insertStaff(StaffCompanion entry) => into(staff).insert(entry);

  Future<bool> updateStaff(StaffCompanion entry) => update(staff).replace(entry);

  // Attendance
  Future<void> markAttendance(StaffAttendanceCompanion entry) =>
      into(staffAttendance).insertOnConflictUpdate(entry);

  Stream<List<StaffAttendanceData>> watchTodayAttendance(DateTime date) {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    return (select(staffAttendance)
          ..where((a) => a.date.isBiggerOrEqualValue(start) & a.date.isSmallerThanValue(end)))
        .watch();
  }

  Future<int> countPresentToday(DateTime date) async {
    final start = DateTime(date.year, date.month, date.day);
    final end = start.add(const Duration(days: 1));
    final rows = await (select(staffAttendance)
          ..where((a) =>
              a.date.isBiggerOrEqualValue(start) &
              a.date.isSmallerThanValue(end) &
              a.status.equals('present')))
        .get();
    return rows.length;
  }

  // Advances
  Future<int> addAdvance(SalaryAdvancesCompanion entry) =>
      into(salaryAdvances).insert(entry);

  Future<int> getPendingAdvanceTotal(int staffId) async {
    final rows = await (select(salaryAdvances)
          ..where((a) => a.staffId.equals(staffId) & a.deducted.equals(false)))
        .get();
    return rows.fold<int>(0, (sum, a) => sum + a.amount);
  }

  // Payroll
  Future<int> createPayrollRun(PayrollRunsCompanion entry) =>
      into(payrollRuns).insert(entry);

  Future<void> insertPayrollLine(PayrollLinesCompanion entry) =>
      into(payrollLines).insert(entry);

  Future<List<PayrollLine>> getPayrollLines(int runId) =>
      (select(payrollLines)..where((l) => l.payrollRunId.equals(runId))).get();
}
