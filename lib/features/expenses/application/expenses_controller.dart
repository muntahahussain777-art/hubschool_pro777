import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

final expensesListProvider = StreamProvider<List<Expense>>((ref) {
  return ref.watch(expensesDaoProvider).watchAllExpenses();
});

final expenseCategoriesProvider = FutureProvider<List<ExpenseCategory>>((ref) {
  return ref.watch(expensesDaoProvider).getCategories();
});

class ExpensesController extends StateNotifier<AsyncValue<void>> {
  ExpensesController(this._ref) : super(const AsyncValue.data(null));
  final Ref _ref;
  ExpensesDao get _dao => _ref.read(expensesDaoProvider);

  Future<void> addExpense({
    required int categoryId,
    required int amount,
    String? note,
  }) async {
    state = const AsyncValue.loading();
    try {
      final voucher = 'VCH-${const Uuid().v4().substring(0, 8).toUpperCase()}';
      await _dao.addExpense(
        ExpensesCompanion.insert(
          categoryId: categoryId,
          amount: amount,
          voucherNo: voucher,
          note: Value(note),
        ),
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final expensesControllerProvider =
    StateNotifierProvider<ExpensesController, AsyncValue<void>>((ref) {
  return ExpensesController(ref);
});
