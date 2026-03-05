part of '../school_database.dart';

@DriftAccessor(tables: [FeeHeads, FeeStructures, FeeInvoices, FeeInvoiceLines, FeePayments, FeePaymentAllocations, Students])
class FeesDao extends DatabaseAccessor<SchoolDatabase> with _$FeesDaoMixin {
  FeesDao(super.db);

  // Fee Heads
  Future<List<FeeHead>> getAllFeeHeads() => select(feeHeads).get();

  // Invoices
  Future<FeeInvoice?> getInvoice(int id) =>
      (select(feeInvoices)..where((i) => i.id.equals(id))).getSingleOrNull();

  Stream<List<FeeInvoice>> watchStudentInvoices(int studentId) =>
      (select(feeInvoices)
            ..where((i) => i.studentId.equals(studentId))
            ..orderBy([(i) => OrderingTerm.desc(i.createdAt)]))
          .watch();

  Future<List<FeeInvoice>> getPendingInvoices() =>
      (select(feeInvoices)
            ..where((i) => i.status.isNotValue('paid'))
            ..orderBy([(i) => OrderingTerm.asc(i.dueDate)]))
          .get();

  Future<int> createInvoice(FeeInvoicesCompanion entry) =>
      into(feeInvoices).insert(entry);

  Future<void> updateInvoicePayment({
    required int invoiceId,
    required int paid,
    required int due,
    required String status,
  }) =>
      (update(feeInvoices)..where((i) => i.id.equals(invoiceId))).write(
        FeeInvoicesCompanion(
          paidAmount: Value(paid),
          dueAmount: Value(due),
          status: Value(status),
        ),
      );

  // Payments
  Future<int> recordPayment(FeePaymentsCompanion entry) =>
      into(feePayments).insert(entry);

  Future<void> allocatePayment(FeePaymentAllocationsCompanion entry) =>
      into(feePaymentAllocations).insert(entry);

  Stream<List<FeePayment>> watchStudentPayments(int studentId) =>
      (select(feePayments)
            ..where((p) => p.studentId.equals(studentId))
            ..orderBy([(p) => OrderingTerm.desc(p.paidAt)]))
          .watch();

  // Revenue summary for current month
  Future<int> getMonthlyRevenue(String monthKey) async {
    final query = select(feeInvoices)..where((i) => i.monthKey.equals(monthKey));
    final rows = await query.get();
    return rows.fold<int>(0, (sum, row) => sum + row.paidAmount);
  }

  Future<int> getTotalDues() async {
    final rows = await (select(feeInvoices)..where((i) => i.status.isNotValue('paid'))).get();
    return rows.fold<int>(0, (sum, row) => sum + row.dueAmount);
  }

  /// Students with pending dues (unique students who have unpaid invoices)
  Future<List<(Student, int)>> getStudentsWithDues() async {
    final pending = await (select(feeInvoices)..where((i) => i.status.isNotValue('paid'))).get();
    final studentIds = pending.map((i) => i.studentId).toSet().toList();
    final result = <(Student, int)>[];
    for (final sid in studentIds) {
      final student = await (select(students)..where((s) => s.id.equals(sid))).getSingleOrNull();
      if (student == null) continue;
      final invoices = await (select(feeInvoices)..where((i) => i.studentId.equals(sid) & i.status.isNotValue('paid'))).get();
      final totalDue = invoices.fold<int>(0, (s, i) => s + i.dueAmount);
      result.add((student, totalDue));
    }
    return result;
  }
}
