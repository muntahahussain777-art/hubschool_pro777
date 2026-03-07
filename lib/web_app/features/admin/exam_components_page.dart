import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class ExamComponentsPage extends StatefulWidget {
  final int examId;

  const ExamComponentsPage({super.key, required this.examId});

  @override
  State<ExamComponentsPage> createState() => _ExamComponentsPageState();
}

class _ExamComponentsPageState extends State<ExamComponentsPage> {
  Map<String, dynamic>? _exam;
  List<Map<String, dynamic>> _list = [];
  bool _loading = true;
  String? _error;
  final _nameCtrl = TextEditingController();
  final _maxCtrl = TextEditingController(text: '100');
  final _weightCtrl = TextEditingController(text: '1.0');

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final exam = await Supabase.instance.client.from(SupabaseConfig.tExams).select().eq('id', widget.examId).maybeSingle();
      final comp = await Supabase.instance.client.from(SupabaseConfig.tExamComponents).select().eq('exam_id', widget.examId);
      if (mounted) setState(() { _exam = exam != null ? Map<String, dynamic>.from(exam) : null; _list = List<Map<String, dynamic>>.from(comp); _loading = false; });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted && _loading) setState(() => _loading = false);
    }
  }

  Future<void> _add() async {
    final name = _nameCtrl.text.trim();
    final max = int.tryParse(_maxCtrl.text.trim()) ?? 100;
    final weight = double.tryParse(_weightCtrl.text.trim()) ?? 1.0;
    if (name.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name required'))); return; }
    try {
      await Supabase.instance.client.from(SupabaseConfig.tExamComponents).insert({'exam_id': widget.examId, 'name': name, 'max_marks': max, 'weight': weight});
      _nameCtrl.clear(); _maxCtrl.text = '100'; _weightCtrl.text = '1.0';
      _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _delete(int id) async {
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(title: const Text('Delete Component'), content: const Text('Remove this component?'), actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')), FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete'))]));
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tExamComponents).delete().eq('id', id);
      _load();
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _nameCtrl.dispose(); _maxCtrl.dispose(); _weightCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    return Scaffold(
      appBar: AppBar(title: Text('${_exam?['title'] ?? 'Exam'} – Components'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/exams'); })),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('Add subject / component', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Subject name *', border: OutlineInputBorder())),
          const SizedBox(height: 8),
          Row(children: [Expanded(child: TextField(controller: _maxCtrl, decoration: const InputDecoration(labelText: 'Max Marks', border: OutlineInputBorder()), keyboardType: TextInputType.number)), const SizedBox(width: 16), Expanded(child: TextField(controller: _weightCtrl, decoration: const InputDecoration(labelText: 'Weight', border: OutlineInputBorder()), keyboardType: TextInputType.number))]),
          const SizedBox(height: 8),
          FilledButton(onPressed: _add, child: const Text('Add')),
        ]))),
        const SizedBox(height: 24),
        Text('Components', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        ..._list.map((c) => Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text(c['name'] as String? ?? '—'), subtitle: Text('Max: ${c['max_marks']} • Weight: ${c['weight']}'), trailing: IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: () => _delete(c['id'] as int))))),
      ]),
    );
  }
}
