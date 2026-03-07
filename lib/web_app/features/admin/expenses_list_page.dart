import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'expense_form_page.dart';

class ExpensesListPage extends StatefulWidget {
  const ExpensesListPage({super.key});

  @override
  State<ExpensesListPage> createState() => _ExpensesListPageState();
}

class _ExpensesListPageState extends State<ExpensesListPage> {
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _expenses = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _expenses;
    return _expenses.where((r) {
      final voucher = (r['voucher_no'] as String? ?? '').toLowerCase();
      final note = (r['note'] as String? ?? '').toLowerCase();
      final catName = _catName(r['category_id'] as int?).toLowerCase();
      return voucher.contains(q) || note.contains(q) || catName.contains(q);
    }).toList();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final cat = await Supabase.instance.client.from(SupabaseConfig.tExpenseCategories).select().order('name');
      final exp = await Supabase.instance.client.from(SupabaseConfig.tExpenses).select().order('spent_at', ascending: false);
      if (mounted) {
        setState(() {
          _categories = List<Map<String, dynamic>>.from(cat);
          _expenses = List<Map<String, dynamic>>.from(exp);
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _deleteExpense(int id) async {
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(title: const Text('Delete Expense'), content: const Text('Remove this expense?'), actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')), FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete'))]));
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tExpenses).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense deleted'))); _load(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _catName(int? id) => _categories.where((c) => c['id'] == id).map((c) => c['name'] as String?).firstOrNull ?? '—';

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  static String _money(int? paisa) => paisa != null ? 'Rs ${paisa ~/ 100}' : '—';

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [Text('Expenses', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), FilledButton.icon(onPressed: () async { await context.push('/admin/expenses/add'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('Add Expense'))]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search by voucher no, category, note...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)))),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final r = _filtered[i];
              final id = r['id'] as int?;
              final voucher = r['voucher_no'] as String? ?? '—';
              final amt = r['amount'] as int?;
              final note = r['note'] as String?;
              final catId = r['category_id'] as int?;
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(voucher),
                  subtitle: Text('${_catName(catId)} • ${_money(amt)}${note != null && note.isNotEmpty ? '\n$note' : ''}'),
                  trailing: Row(mainAxisSize: MainAxisSize.min, children: [IconButton(icon: const Icon(Icons.edit_rounded), onPressed: id != null ? () async { await context.push('/admin/expenses/edit/$id'); if (mounted) _load(); } : null), IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: id != null ? () => _deleteExpense(id) : null)]),
                ),
              );
            },
            childCount: _filtered.length,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () async { await context.push('/admin/expenses/add'); if (mounted) _load(); }, child: const Icon(Icons.add_rounded)),
    );
  }
}
