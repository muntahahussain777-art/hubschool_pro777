import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'classroom_form_page.dart';

class ClassroomsListPage extends StatefulWidget {
  const ClassroomsListPage({super.key});

  @override
  State<ClassroomsListPage> createState() => _ClassroomsListPageState();
}

class _ClassroomsListPageState extends State<ClassroomsListPage> {
  List<Map<String, dynamic>> _list = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _list;
    return _list.where((r) {
      final name = (r['name'] as String? ?? '').toLowerCase();
      final section = (r['section'] as String? ?? '').toLowerCase();
      final year = (r['academic_year']?.toString() ?? '').toLowerCase();
      return name.contains(q) || section.contains(q) || year.contains(q);
    }).toList();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select().order('name');
      if (mounted) setState(() => _list = List<Map<String, dynamic>>.from(res));
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete(int id, String name) async {
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Delete Class'),
      content: Text('Remove "$name"?'),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
        FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
      ],
    ));
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tClassrooms).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Class deleted'))); _load(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [Text('Classes', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), FilledButton.icon(onPressed: () async { await context.push('/admin/classes/add'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('Add Class'))]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 12), child: TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search by class name, section, year...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)))),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, i) {
                final r = _filtered[i];
                final id = r['id'] as int?;
                final name = r['name'] as String? ?? '—';
                final section = r['section'] as String? ?? 'A';
                final year = r['academic_year'];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    title: Text('$name - $section'),
                    subtitle: Text('Year: $year'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(icon: const Icon(Icons.edit_rounded), onPressed: id != null ? () async { await context.push('/admin/classes/edit/$id'); if (mounted) _load(); } : null),
                        IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: id != null ? () => _delete(id, name) : null),
                      ],
                    ),
                  ),
                );
              },
              childCount: _filtered.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async { await context.push('/admin/classes/add'); if (mounted) _load(); }, child: const Icon(Icons.add_rounded)),
    );
  }
}
