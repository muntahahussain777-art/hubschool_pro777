import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class FeeInvoicesListPage extends StatefulWidget {
  const FeeInvoicesListPage({super.key});

  @override
  State<FeeInvoicesListPage> createState() => _FeeInvoicesListPageState();
}

class _FeeInvoicesListPageState extends State<FeeInvoicesListPage> {
  List<Map<String, dynamic>> _list = [];
  List<Map<String, dynamic>> _students = [];
  bool _loading = true;
  String? _error;

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final inv = await Supabase.instance.client.from(SupabaseConfig.tFeeInvoices).select().order('created_at', ascending: false);
      final stu = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no');
      if (mounted) { setState(() { _list = List<Map<String, dynamic>>.from(inv); _students = List<Map<String, dynamic>>.from(stu); }); }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _studentName(int? id) => _students.where((s) => s['id'] == id).map((s) => s['full_name'] as String?).firstOrNull ?? '—';

  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _list;
    return _list.where((r) {
      final studentName = _studentName(r['student_id'] as int?).toLowerCase();
      final month = (r['month_key'] as String? ?? '').toLowerCase();
      return studentName.contains(q) || month.contains(q);
    }).toList();
  }

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
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [Text('Fee Invoices', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), FilledButton.icon(onPressed: () async { await context.push('/admin/fees/add'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('Add Invoice'))]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search by student name or month (e.g. 2026-03)...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)))),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final r = _filtered[i];
              final id = r['id'] as int?;
              final month = r['month_key'] as String? ?? '-';
              final studentId = r['student_id'] as int?;
              final net = r['net_amount'] as int?;
              final paid = r['paid_amount'] as int?;
              final due = r['due_amount'] as int?;
              final status = r['status'] as String? ?? '-';
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(_studentName(studentId)),
                  subtitle: Text('$month \u2022 Net: ${_money(net)} \u2022 Paid: ${_money(paid)} \u2022 Due: ${_money(due)} \u2022 $status'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: id != null ? () => context.push('/admin/fees/invoice/$id') : null,
                ),
              );
            },
            childCount: _filtered.length,
          ),
        ),
      ]),
    );
  }
}
