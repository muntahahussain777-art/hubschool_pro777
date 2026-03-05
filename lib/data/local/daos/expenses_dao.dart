part of '../school_database.dart';

@DriftAccessor(tables: [Expenses, ExpenseCategories])
class ExpensesDao extends DatabaseAccessor<SchoolDatabase> with _$ExpensesDaoMixin {
  ExpensesDao(super.db);

  Stream<List<Expense>> watchAllExpenses() =>
      (select(expenses)..orderBy([(e) => OrderingTerm.desc(e.spentAt)])).watch();

  Future<int> addExpense(ExpensesCompanion entry) => into(expenses).insert(entry);

  Future<List<ExpenseCategory>> getCategories() => select(expenseCategories).get();

  Future<int> getMonthlyExpenseTotal(int year, int month) async {
    final start = DateTime(year, month, 1);
    final end = DateTime(year, month + 1, 1);
    final rows = await (select(expenses)
          ..where((e) =>
              e.spentAt.isBiggerOrEqualValue(start) & e.spentAt.isSmallerThanValue(end)))
        .get();
    return rows.fold<int>(0, (sum, e) => sum + e.amount);
  }
}
