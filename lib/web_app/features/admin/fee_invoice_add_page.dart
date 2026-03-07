import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class FeeInvoiceAddPage extends StatefulWidget {
  const FeeInvoiceAddPage({super.key});

  @override
  State<FeeInvoiceAddPage> createState() => _FeeInvoiceAddPageState();
}

class _FeeInvoiceAddPageState extends State<FeeInvoiceAddPage> {
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _feeHeads = [];
  int? _studentId;
  final _monthCtrl = TextEditingController();
  final _discountCtrl = TextEditingController(text: '0');
  final Map<int, TextEditingController> _amountCtrls = {};
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _monthCtrl.text = '${now.year}-${now.month.toString().padLeft(2, '0')}';
    _load();
  }

  Future<void> _load() async {
    try {
      final stu = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').order('full_name');
      final heads = await Supabase.instance.client.from(SupabaseConfig.tFeeHeads).select('id, name, code').order('name');
      if (mounted) {
        setState(() {
          _students = List<Map<String, dynamic>>.from(stu);
          _feeHeads = List<Map<String, dynamic>>.from(heads);
          for (final h in _feeHeads) {
            final id = h['id'] as int?;
            if (id != null && !_amountCtrls.containsKey(id)) _amountCtrls[id] = TextEditingController(text: '0');
          }
        });
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _monthCtrl.dispose();
    _discountCtrl.dispose();
    for (final c in _amountCtrls.values) c.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_studentId == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select student')));
      return;
    }
    final monthKey = _monthCtrl.text.trim();
    if (monthKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter month (e.g. 2026-03)')));
      return;
    }
    int total = 0;
    final lines = <Map<String, dynamic>>[];
    for (final h in _feeHeads) {
      final id = h['id'] as int?;
      if (id == null) continue;
      final amt = (int.tryParse(_amountCtrls[id]?.text.trim() ?? '') ?? 0) * 100;
      if (amt > 0) {
        total += amt;
        lines.add({'fee_head_id': id, 'amount': amt});
      }
    }
    if (total == 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Add at least one fee amount')));
      return;
    }
    final discount = (int.tryParse(_discountCtrl.text.trim()) ?? 0) * 100;
    final net = total - discount;
    setState(() => _loading = true);
    try {
      final inv = await Supabase.instance.client.from(SupabaseConfig.tFeeInvoices).insert({
        'student_id': _studentId,
        'month_key': monthKey,
        'total_amount': total,
        'discount_amount': discount,
        'net_amount': net,
        'paid_amount': 0,
        'due_amount': net,
        'status': 'unpaid',
      }).select('id').single();
      final invId = inv['id'] as int?;
      if (invId != null) {
        for (final line in lines) {
          await Supabase.instance.client.from(SupabaseConfig.tFeeInvoiceLines).insert({'invoice_id': invId, 'fee_head_id': line['fee_head_id'], 'amount': line['amount']});
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fee invoice created')));
        context.pop(true);
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Fee Invoice'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/fees'); })),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        DropdownButtonFormField<int>(
          value: _studentId,
          decoration: const InputDecoration(labelText: 'Student *', border: OutlineInputBorder()),
          items: [const DropdownMenuItem(value: null, child: Text('Select student')), ..._students.map((s) => DropdownMenuItem(value: s['id'] as int?, child: Text('${s['full_name']} (${s['admission_no']})')))],
          onChanged: (v) => setState(() => _studentId = v),
        ),
        const SizedBox(height: 16),
        TextField(controller: _monthCtrl, decoration: const InputDecoration(labelText: 'Month (e.g. 2026-03)', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _discountCtrl, decoration: const InputDecoration(labelText: 'Discount (Rs)', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        const SizedBox(height: 24),
        Text('Fee lines', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ..._feeHeads.map((h) {
          final id = h['id'] as int?;
          if (id == null) return const SizedBox.shrink();
          _amountCtrls[id] ??= TextEditingController(text: '0');
          return Padding(padding: const EdgeInsets.only(bottom: 8), child: Row(children: [Expanded(child: Text(h['name'] as String? ?? '')), SizedBox(width: 120, child: TextField(controller: _amountCtrls[id], decoration: const InputDecoration(labelText: 'Rs', isDense: true), keyboardType: TextInputType.number))]));
        }),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Create Invoice')),
      ]),
    );
  }
}
