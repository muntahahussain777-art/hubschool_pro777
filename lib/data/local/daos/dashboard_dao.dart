part of '../school_database.dart';

class DashboardStats {
  final int totalStudents;
  final int totalStaff;
  final int monthlyRevenue;
  final int monthlyExpenses;
  final int pendingDues;
  final int presentToday;
  DashboardStats({
    required this.totalStudents,
    required this.totalStaff,
    required this.monthlyRevenue,
    required this.monthlyExpenses,
    required this.pendingDues,
    required this.presentToday,
  });
}

@DriftAccessor(tables: [Students, Staff, FeeInvoices, FeePayments, Expenses, StaffAttendance])
class DashboardDao extends DatabaseAccessor<SchoolDatabase> with _$DashboardDaoMixin {
  DashboardDao(super.db);

  Future<DashboardStats> getStats() async {
    final now = DateTime.now();
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    final totalStudents = await _count(students, students.isActive.equals(true));
    final totalStaff = await _count(staff, staff.isActive.equals(true));

    final invoicesThisMonth = await (select(feeInvoices)
          ..where((i) => i.monthKey.equals(monthKey)))
        .get();
    final monthlyRevenue = invoicesThisMonth.fold<int>(0, (s, i) => s + i.paidAmount);

    final expensesThisMonth = await (select(expenses)
          ..where((e) =>
              e.spentAt.isBiggerOrEqualValue(DateTime(now.year, now.month, 1)) &
              e.spentAt.isSmallerThanValue(DateTime(now.year, now.month + 1, 1))))
        .get();
    final monthlyExpenses = expensesThisMonth.fold<int>(0, (s, e) => s + e.amount);

    final pendingRows = await (select(feeInvoices)..where((i) => i.status.isNotValue('paid'))).get();
    final pendingDues = pendingRows.fold<int>(0, (s, i) => s + i.dueAmount);

    final todayStart = DateTime(now.year, now.month, now.day);
    final todayEnd = todayStart.add(const Duration(days: 1));
    final todayAttendance = await (select(staffAttendance)
          ..where((a) =>
              a.date.isBiggerOrEqualValue(todayStart) &
              a.date.isSmallerThanValue(todayEnd) &
              a.status.equals('present')))
        .get();

    return DashboardStats(
      totalStudents: totalStudents,
      totalStaff: totalStaff,
      monthlyRevenue: monthlyRevenue,
      monthlyExpenses: monthlyExpenses,
      pendingDues: pendingDues,
      presentToday: todayAttendance.length,
    );
  }

  Future<int> _count<T extends Table, D>(TableInfo<T, D> table, Expression<bool> filter) async {
    final count = countAll(filter: filter);
    final q = selectOnly(table)..addColumns([count]);
    return (await q.getSingle()).read(count) ?? 0;
  }

  Stream<List<FeeInvoice>> watchRecentInvoices() =>
      (select(feeInvoices)
            ..orderBy([(i) => OrderingTerm.desc(i.createdAt)])
            ..limit(10))
          .watch();
}
