import 'dart:convert';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

class FeePaymentState {
  final bool loading;
  final String? error;
  final String? successMessage;
  final int? lastPaymentId;

  const FeePaymentState({
    this.loading = false,
    this.error,
    this.successMessage,
    this.lastPaymentId,
  });

  FeePaymentState copyWith({
    bool? loading,
    String? error,
    String? successMessage,
    int? lastPaymentId,
  }) =>
      FeePaymentState(
        loading: loading ?? this.loading,
        error: error,
        successMessage: successMessage,
        lastPaymentId: lastPaymentId ?? this.lastPaymentId,
      );
}

class FeePaymentController extends StateNotifier<FeePaymentState> {
  FeePaymentController(this._ref) : super(const FeePaymentState());
  final Ref _ref;

  FeesDao get _fees => _ref.read(feesDaoProvider);
  SyncDao get _sync => _ref.read(syncDaoProvider);
  SchoolDatabase get _db => _ref.read(schoolDatabaseProvider);

  Future<void> collectPayment({
    required int studentId,
    required int invoiceId,
    required int amount,
    required int userId,
    String method = 'cash',
    String? referenceNo,
  }) async {
    state = state.copyWith(loading: true, error: null, successMessage: null);
    try {
      await _db.transaction(() async {
        final invoice = await _fees.getInvoice(invoiceId);
        if (invoice == null) throw Exception('Invoice not found');
        if (amount <= 0) throw Exception('Amount must be greater than 0');
        if (amount > invoice.dueAmount) throw Exception('Amount Rs ${amount ~/ 100} exceeds due Rs ${invoice.dueAmount ~/ 100}');

        final paymentId = await _fees.recordPayment(
          FeePaymentsCompanion.insert(
            studentId: studentId,
            amount: amount,
            method: Value(method),
            referenceNo: Value(referenceNo),
            receivedBy: userId,
          ),
        );

        await _fees.allocatePayment(
          FeePaymentAllocationsCompanion.insert(
            paymentId: paymentId,
            invoiceId: invoiceId,
            amount: amount,
          ),
        );

        final newPaid = invoice.paidAmount + amount;
        final newDue = invoice.netAmount - newPaid;
        final status = newDue == 0 ? 'paid' : 'partial';

        await _fees.updateInvoicePayment(
          invoiceId: invoiceId,
          paid: newPaid,
          due: newDue,
          status: status,
        );

        await _sync.enqueue(
          entity: 'fee_payment',
          operation: 'insert',
          payloadJson: jsonEncode({
            'payment_id': paymentId,
            'invoice_id': invoiceId,
            'student_id': studentId,
            'amount': amount,
            'method': method,
            'new_status': status,
          }),
        );

        state = state.copyWith(
          loading: false,
          successMessage: 'Payment of Rs ${amount ~/ 100} collected!',
          lastPaymentId: paymentId,
        );
      });
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }

  Future<void> generateMonthlyInvoices({
    required int studentId,
    required int classroomId,
    required String monthKey,
  }) async {
    state = state.copyWith(loading: true);
    try {
      final heads = await _fees.getAllFeeHeads();
      final db = _ref.read(schoolDatabaseProvider);
      final structures = await (db.select(db.feeStructures)
            ..where((s) => s.classroomId.equals(classroomId)))
          .get();

      int total = 0;
      int discount = 0;
      final lines = <Map<String, int>>[];

      for (final structure in structures) {
        final head = heads.firstWhere((h) => h.id == structure.feeHeadId);
        if (head.isDiscount) {
          discount += structure.amount;
        } else {
          total += structure.amount;
        }
        lines.add({'feeHeadId': structure.feeHeadId, 'amount': structure.amount});
      }

      final net = total - discount;
      final invoiceId = await _fees.createInvoice(
        FeeInvoicesCompanion.insert(
          studentId: studentId,
          monthKey: monthKey,
          totalAmount: total,
          discountAmount: Value(discount),
          netAmount: net,
          dueAmount: net,
          dueDate: Value(DateTime.now().add(const Duration(days: 10))),
        ),
      );

      for (final line in lines) {
        await db.into(db.feeInvoiceLines).insert(
          FeeInvoiceLinesCompanion.insert(
            invoiceId: invoiceId,
            feeHeadId: line['feeHeadId']!,
            amount: line['amount']!,
          ),
        );
      }

      state = state.copyWith(loading: false, successMessage: 'Invoice generated for $monthKey');
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}

final feePaymentControllerProvider =
    StateNotifierProvider<FeePaymentController, FeePaymentState>((ref) {
  return FeePaymentController(ref);
});

final studentInvoicesProvider = StreamProvider.family<List<FeeInvoice>, int>((ref, studentId) {
  return ref.watch(feesDaoProvider).watchStudentInvoices(studentId);
});

final studentPaymentsProvider = StreamProvider.family<List<FeePayment>, int>((ref, studentId) {
  return ref.watch(feesDaoProvider).watchStudentPayments(studentId);
});
