import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class ExpenseFormPage extends StatefulWidget {
  final int? id;

  const ExpenseFormPage({super.key, this.id});

  @override
  State<ExpenseFormPage> createState() => _ExpenseFormPageState();
}

class _ExpenseFormPageState extends State<ExpenseFormPage> {
  List<Map<String, dynamic>> _categories = [];
  final _voucherCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  int? _categoryId;
  bool _loading = false;
  bool _fetching = false;

  @override
  void initState() { super.initState(); _loadCat(); if (widget.id != null) _loadOne(); }

  Future<void> _loadCat() async {
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tExpenseCategories).select().order('name');
      if (mounted) setState(() => _categories = List<Map<String, dynamic>>.from(res));
    } catch (_) {}
  }

  Future<void> _loadOne() async {
    if (widget.id == null) return;
    setState(() => _fetching = true);
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tExpenses).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        _voucherCtrl.text = r['voucher_no'] as String? ?? '';
        _amountCtrl.text = r['amount'] != null ? '${(r['amount'] as int) ~/ 100}' : '';
        _noteCtrl.text = r['note'] as String? ?? '';
        setState(() => _categoryId = r['category_id'] as int?);
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _voucherCtrl.dispose(); _amountCtrl.dispose(); _noteCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_voucherCtrl.text.trim().isEmpty || _categoryId == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Voucher no and Category required'))); return; }
    final amt = (int.tryParse(_amountCtrl.text.trim()) ?? 0) * 100;
    if (amt <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Amount required'))); return; }
    setState(() => _loading = true);
    try {
      final map = {'category_id': _categoryId, 'amount': amt, 'voucher_no': _voucherCtrl.text.trim(), 'note': _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim()};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tExpenses).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense updated'))); context.pop(true); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tExpenses).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Expense added'))); context.pop(true); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Expense' : 'Add Expense'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _voucherCtrl, decoration: const InputDecoration(labelText: 'Voucher No *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(value: _categoryId, decoration: const InputDecoration(labelText: 'Category *', border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('Select')), ..._categories.map((c) => DropdownMenuItem(value: c['id'] as int?, child: Text(c['name'] as String? ?? '')))], onChanged: (v) => setState(() => _categoryId = v)),
        const SizedBox(height: 16),
        TextField(controller: _amountCtrl, decoration: const InputDecoration(labelText: 'Amount (Rs) *', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        const SizedBox(height: 16),
        TextField(controller: _noteCtrl, decoration: const InputDecoration(labelText: 'Note', border: OutlineInputBorder()), maxLines: 2),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
