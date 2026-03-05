import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../application/expenses_controller.dart';

class ExpensesScreen extends ConsumerWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expensesAsync = ref.watch(expensesListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expenses'),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseSheet(context, ref),
        label: const Text('Add Expense'),
        icon: const Icon(Icons.add_rounded),
        backgroundColor: AppColors.accent,
      ),
      body: expensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (expenses) {
          if (expenses.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.receipt_long_outlined, size: 72, color: AppColors.textMuted),
                  SizedBox(height: 12),
                  Text('No expenses recorded', style: TextStyle(color: AppColors.textMuted, fontSize: 16)),
                ],
              ),
            );
          }
          return _buildList(expenses);
        },
      ),
    );
  }

  Widget _buildList(List<Expense> expenses) {
    final total = expenses.fold(0, (s, e) => s + e.amount);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.accent, Color(0xFFFF9A8B)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              const Icon(Icons.receipt_long_rounded, color: Colors.white, size: 24),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Fmt.moneyInt(total ~/ 100),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Text(
                    'Total Expenses',
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                '${expenses.length} vouchers',
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: expenses.length,
            itemBuilder: (_, i) => _ExpenseTile(expense: expenses[i], index: i),
          ),
        ),
      ],
    );
  }

  void _showAddExpenseSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => const _AddExpenseSheet(),
    );
  }
}

class _AddExpenseSheet extends ConsumerStatefulWidget {
  const _AddExpenseSheet();

  @override
  ConsumerState<_AddExpenseSheet> createState() => _AddExpenseSheetState();
}

class _AddExpenseSheetState extends ConsumerState<_AddExpenseSheet> {
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  int? _selectedCategoryId;

  @override
  void dispose() {
    _amountCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(expenseCategoriesProvider);
    final state = ref.watch(expensesControllerProvider);

    return Padding(
      padding: EdgeInsets.only(
        left: 20, right: 20, top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          const Text('Add Expense',
              style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          const Text('Category', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          categoriesAsync.when(
            loading: () => const SizedBox(height: 40),
            error: (_, __) => const SizedBox(),
            data: (cats) => Wrap(
              spacing: 8,
              runSpacing: 8,
              children: cats.map((c) {
                final selected = c.id == _selectedCategoryId;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategoryId = c.id),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppColors.accent.withOpacity(0.2) : AppColors.card,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: selected ? AppColors.accent : AppColors.cardBorder,
                      ),
                    ),
                    child: Text(
                      c.name,
                      style: TextStyle(
                        color: selected ? AppColors.accent : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Amount (Rs)',
              prefixIcon: Icon(Icons.payments_rounded, color: AppColors.accent, size: 20),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _noteCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: 'Note (optional)',
              prefixIcon: Icon(Icons.notes_rounded, color: AppColors.primary, size: 20),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.accent),
              onPressed: state is AsyncLoading ? null : _submit,
              child: state is AsyncLoading
                  ? const SizedBox(width: 20, height: 20,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : const Text('Save Expense'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (_selectedCategoryId == null) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Please select a category')));
      return;
    }
    final amount = int.tryParse(_amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Enter a valid amount')));
      return;
    }
    await ref.read(expensesControllerProvider.notifier).addExpense(
          categoryId: _selectedCategoryId!,
          amount: amount * 100,
          note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
        );
    if (mounted) Navigator.pop(context);
  }
}

class _ExpenseTile extends StatelessWidget {
  final Expense expense;
  final int index;
  const _ExpenseTile({required this.expense, required this.index});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.accent.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.receipt_rounded, color: AppColors.accent, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  expense.voucherNo,
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 13),
                ),
                if (expense.note != null)
                  Text(expense.note!, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                Text(
                  Fmt.dateTime(expense.spentAt),
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            Fmt.moneyInt(expense.amount ~/ 100),
            style: const TextStyle(
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: index * 40))
        .fadeIn(duration: 250.ms);
  }
}
