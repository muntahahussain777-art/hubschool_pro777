import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'exam_form_page.dart';

class ExamsListPage extends StatefulWidget {
  const ExamsListPage({super.key});

  @override
  State<ExamsListPage> createState() => _ExamsListPageState();
}

class _ExamsListPageState extends State<ExamsListPage> {
  List<Map<String, dynamic>> _list = [];
  List<Map<String, dynamic>> _classrooms = [];
  bool _loading = true;
  String? _error;

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tExams).select().order('created_at', ascending: false);
      final cls = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select('id, name, section');
      if (mounted) { setState(() { _list = List<Map<String, dynamic>>.from(res); _classrooms = List<Map<String, dynamic>>.from(cls); }); }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete(int id, String title) async {
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(title: const Text('Delete Exam'), content: Text('Remove "$title"?'), actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')), FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete'))]));
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tExams).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam deleted'))); _load(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String _classNames(int? id) {
    if (id == null) return '—';
    final c = _classrooms.where((x) => x['id'] == id).firstOrNull;
    if (c == null) return '—';
    return '${c['name']} ${c['section']}';
  }

  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _list;
    return _list.where((r) {
      final title = (r['title'] as String? ?? '').toLowerCase();
      final classStr = _classNames(r['classroom_id'] as int?).toLowerCase();
      final date = (r['exam_date']?.toString().substring(0, 10) ?? '').toLowerCase();
      return title.contains(q) || classStr.contains(q) || date.contains(q);
    }).toList();
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    return Scaffold(
      body: CustomScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [Text('Exams', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), FilledButton.icon(onPressed: () async { await context.push('/admin/exams/add'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('Add Exam'))]))),
        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search by exam title, class, or date...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)))),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, i) {
              final r = _filtered[i];
              final id = r['id'] as int?;
              final title = r['title'] as String? ?? '—';
              final classId = r['classroom_id'] as int?;
              final date = r['exam_date']?.toString().substring(0, 10);
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(title),
                  subtitle: Text('${_classNames(classId)} • $date'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(icon: const Icon(Icons.edit_rounded), onPressed: id != null ? () async { await context.push('/admin/exams/edit/$id'); if (mounted) _load(); } : null),
                      IconButton(icon: const Icon(Icons.library_books_rounded), onPressed: id != null ? () => context.push('/admin/exams/$id/components') : null, tooltip: 'Components'),
                      IconButton(icon: const Icon(Icons.assignment_rounded), onPressed: id != null ? () => context.push('/admin/exams/$id/marks') : null, tooltip: 'Marks'),
                      IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: id != null ? () => _delete(id, title) : null),
                    ],
                  ),
                ),
              );
            },
            childCount: _filtered.length,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(onPressed: () async { await context.push('/admin/exams/add'); if (mounted) _load(); }, child: const Icon(Icons.add_rounded)),
    );
  }
}
