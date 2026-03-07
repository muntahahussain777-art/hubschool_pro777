import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'announcement_form_page.dart';

/// Admin: Announcements list – create, edit, delete, publish, pin.
class AnnouncementsListPage extends StatefulWidget {
  const AnnouncementsListPage({super.key});

  @override
  State<AnnouncementsListPage> createState() => _AnnouncementsListPageState();
}

class _AnnouncementsListPageState extends State<AnnouncementsListPage> {
  List<Map<String, dynamic>> _list = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();
  String? _filterType;
  bool? _filterPublished;

  static const List<String> _types = ['announcement', 'holiday', 'exam', 'admission', 'urgent'];

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    var list = _list;
    if (q.isNotEmpty) list = list.where((r) => ((r['title'] as String?) ?? '').toLowerCase().contains(q) || ((r['message'] as String?) ?? '').toLowerCase().contains(q)).toList();
    if (_filterType != null) list = list.where((r) => r['type'] == _filterType).toList();
    if (_filterPublished != null) list = list.where((r) => r['is_published'] == _filterPublished).toList();
    list.sort((a, b) {
      final aPin = (a['is_pinned'] == true) ? 1 : 0;
      final bPin = (b['is_pinned'] == true) ? 1 : 0;
      if (bPin != aPin) return bPin - aPin;
      final aAt = a['created_at']?.toString() ?? '';
      final bAt = b['created_at']?.toString() ?? '';
      return bAt.compareTo(aAt);
    });
    return list;
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).select().order('created_at', ascending: false);
      if (mounted) setState(() => _list = List<Map<String, dynamic>>.from(res));
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _delete(String id, String title) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete announcement'),
        content: Text('Remove "$title"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Announcement deleted'))); _load(); }
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
    final filtered = _filtered;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 16), child: Row(children: [Text('Announcements', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)), const Spacer(), FilledButton.icon(onPressed: () async { await context.push('/admin/announcements/new'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('New'))]))),
          SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.only(bottom: 12), child: Column(children: [TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)), const SizedBox(height: 8), Row(children: [DropdownButtonFormField<String>(value: _filterType, decoration: const InputDecoration(labelText: 'Type', isDense: true, border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('All')), ..._types.map((t) => DropdownMenuItem(value: t, child: Text(t)))], onChanged: (v) => setState(() => _filterType = v)), const SizedBox(width: 12), DropdownButtonFormField<bool>(value: _filterPublished, decoration: const InputDecoration(labelText: 'Status', isDense: true, border: OutlineInputBorder()), items: const [DropdownMenuItem(value: null, child: Text('All')), DropdownMenuItem(value: true, child: Text('Published')), DropdownMenuItem(value: false, child: Text('Unpublished'))], onChanged: (v) => setState(() => _filterPublished = v))])]))),
          if (filtered.isEmpty)
            const SliverFillRemaining(child: Center(child: Text('No announcements.')))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final r = filtered[i];
                  final id = r['id']?.toString();
                  final title = r['title'] as String? ?? '-';
                  final type = r['type'] as String? ?? 'announcement';
                  final priority = r['priority'] as String? ?? 'normal';
                  final published = r['is_published'] == true;
                  final pinned = r['is_pinned'] == true;
                  final endStr = r['end_date']?.toString();
                  final endDate = endStr != null && endStr.length >= 10 ? endStr.substring(0, 10) : null;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: Icon(_iconForType(type), color: _colorForType(type)),
                      title: Row(
                        children: [
                          if (pinned) Padding(padding: const EdgeInsets.only(right: 4), child: Icon(Icons.push_pin_rounded, size: 16, color: Theme.of(context).colorScheme.primary)),
                          Expanded(child: Text(title)),
                        ],
                      ),
                      subtitle: Text('$type \u2022 $priority \u2022 ${published ? "Published" : "Unpublished"}${endDate != null ? " \u2022 End: $endDate" : ""}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.edit_rounded), onPressed: id != null ? () async { await context.push('/admin/announcements/edit/$id'); if (mounted) _load(); } : null),
                          IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: id != null ? () => _delete(id, title) : null),
                        ],
                      ),
                    ),
                  );
                },
                childCount: filtered.length,
              ),
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () async { await context.push('/admin/announcements/new'); if (mounted) _load(); }, child: const Icon(Icons.add_rounded)),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'holiday': return Icons.event_rounded;
      case 'exam': return Icons.assignment_rounded;
      case 'admission': return Icons.school_rounded;
      case 'urgent': return Icons.warning_rounded;
      default: return Icons.campaign_rounded;
    }
  }

  Color? _colorForType(String type) {
    switch (type) {
      case 'urgent': return Colors.red;
      case 'holiday': return Colors.orange;
      case 'exam': return Theme.of(context).colorScheme.primary;
      default: return null;
    }
  }
}
