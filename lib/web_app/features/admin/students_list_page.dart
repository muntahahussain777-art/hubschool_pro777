import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'student_form_page.dart';

class StudentsListPage extends StatefulWidget {
  const StudentsListPage({super.key});

  @override
  State<StudentsListPage> createState() => _StudentsListPageState();
}

class _StudentsListPageState extends State<StudentsListPage> {
  List<Map<String, dynamic>> _students = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _students;
    return _students.where((s) {
      final name = (s['full_name'] as String? ?? '').toLowerCase();
      final father = (s['father_name'] as String? ?? '').toLowerCase();
      final adm = (s['admission_no'] as String? ?? '').toLowerCase();
      final phone = (s['phone'] as String? ?? '').toLowerCase();
      return name.contains(q) || father.contains(q) || adm.contains(q) || phone.contains(q);
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final res = await Supabase.instance.client
          .from(SupabaseConfig.tStudents)
          .select()
          .order('full_name');
      if (mounted) setState(() => _students = List<Map<String, dynamic>>.from(res));
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete(int id, String name) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Student'),
        content: Text('Remove "$name"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tStudents).delete().eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student deleted')));
        _load();
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
                        const SizedBox(height: 16),
                        FilledButton(onPressed: _load, child: const Text('Retry')),
                      ],
                    ),
                  ),
                )
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Text(
                              'Admissions / Students',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const Spacer(),
                            FilledButton.icon(
                              onPressed: () async {
                                await context.push('/admin/students/add');
                                if (mounted) _load();
                              },
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Add Student'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: TextField(
                          controller: _searchCtrl,
                          onChanged: (_) => setState(() {}),
                          decoration: InputDecoration(
                            hintText: 'Search by name, father, admission no, phone...',
                            prefixIcon: const Icon(Icons.search_rounded),
                            border: const OutlineInputBorder(),
                            isDense: true,
                          ),
                        ),
                      ),
                    ),
                    if (_filtered.isEmpty)
                      SliverFillRemaining(
                        child: Center(child: Text(_students.isEmpty ? 'No students yet. Tap Add Student to add one.' : 'No match for "${_searchCtrl.text.trim()}".')),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.only(bottom: 24),
                        sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final s = _filtered[index];
                              final id = s['id'] as int?;
                              final name = s['full_name'] as String? ?? '—';
                              final admNo = s['admission_no'] as String? ?? '—';
                              final father = s['father_name'] as String? ?? '—';
                              final phone = s['phone'] as String?;
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text(name),
                                  subtitle: Text('$admNo • $father${phone != null && phone.isNotEmpty ? ' • $phone' : ''}'),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit_rounded),
                                        onPressed: id != null ? () async { await context.push('/admin/students/edit/$id'); if (mounted) _load(); } : null,
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error),
                                        onPressed: id != null ? () => _delete(id, name) : null,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            childCount: _filtered.length,
                          ),
                        ),
                      ),
                  ],
                ),
      floatingActionButton: !_loading && _error == null
          ? FloatingActionButton(
              onPressed: () async { await context.push('/admin/students/add'); if (mounted) _load(); },
              child: const Icon(Icons.add_rounded),
            )
          : null,
    );
  }
}
