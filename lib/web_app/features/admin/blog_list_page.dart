import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import 'blog_form_page.dart';

/// Admin: Blog & News list – create, edit, delete, publish, pin, featured.
class BlogListPage extends StatefulWidget {
  const BlogListPage({super.key});

  @override
  State<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  List<Map<String, dynamic>> _list = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();
  String? _filterCategory;
  bool? _filterPublished;

  static const List<String> _categories = ['Blog', 'News', 'Event', 'Update'];

  List<Map<String, dynamic>> get _filtered {
    final q = _searchCtrl.text.trim().toLowerCase();
    var list = _list;
    if (q.isNotEmpty) {
      list = list.where((r) {
        final title = (r['title'] as String? ?? '').toLowerCase();
        final summary = (r['summary'] as String? ?? '').toLowerCase();
        return title.contains(q) || summary.contains(q);
      }).toList();
    }
    if (_filterCategory != null) list = list.where((r) => r['category'] == _filterCategory).toList();
    if (_filterPublished != null) list = list.where((r) => r['is_published'] == _filterPublished).toList();
    list.sort((a, b) {
      final aAt = a['updated_at']?.toString() ?? '';
      final bAt = b['updated_at']?.toString() ?? '';
      return bAt.compareTo(aAt);
    });
    return list;
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tBlogPosts).select().order('created_at', ascending: false);
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
        title: const Text('Delete post'),
        content: Text('Remove "$title"? This cannot be undone.'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          FilledButton(style: FilledButton.styleFrom(backgroundColor: Theme.of(ctx).colorScheme.error), onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete')),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tBlogPosts).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post deleted'))); _load(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    final filtered = _filtered;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                children: [
                  Text('Blog & News', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  FilledButton.icon(onPressed: () async { await context.push('/admin/blog/new'); if (mounted) _load(); }, icon: const Icon(Icons.add_rounded), label: const Text('New post')),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _searchCtrl,
                    onChanged: (_) => setState(() {}),
                    decoration: const InputDecoration(hintText: 'Search by title or summary...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      DropdownButtonFormField<String>(
                        value: _filterCategory,
                        decoration: const InputDecoration(labelText: 'Category', isDense: true, border: OutlineInputBorder()),
                        items: [const DropdownMenuItem(value: null, child: Text('All')), ..._categories.map((c) => DropdownMenuItem(value: c, child: Text(c)))],
                        onChanged: (v) => setState(() => _filterCategory = v),
                      ),
                      const SizedBox(width: 12),
                      DropdownButtonFormField<bool>(
                        value: _filterPublished,
                        decoration: const InputDecoration(labelText: 'Status', isDense: true, border: OutlineInputBorder()),
                        items: const [DropdownMenuItem(value: null, child: Text('All')), DropdownMenuItem(value: true, child: Text('Published')), DropdownMenuItem(value: false, child: Text('Draft'))],
                        onChanged: (v) => setState(() => _filterPublished = v),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (filtered.isEmpty)
            const SliverFillRemaining(child: Center(child: Text('No posts. Tap "New post" to add one.')))
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, i) {
                  final r = filtered[i];
                  final id = r['id']?.toString();
                  final title = r['title'] as String? ?? '—';
                  final category = r['category'] as String? ?? 'Blog';
                  final published = r['is_published'] == true;
                  final featured = r['is_featured'] == true;
                  final pinned = r['is_pinned'] == true;
                  final updated = r['updated_at']?.toString().substring(0, 10);
                  return Card(
                    margin: const EdgeInsets.only(bottom: 8),
                    child: ListTile(
                      leading: _buildCoverThumb(r['cover_image_url']),
                      title: Row(
                        children: [
                          if (pinned) Padding(padding: const EdgeInsets.only(right: 4), child: Icon(Icons.push_pin_rounded, size: 16, color: Theme.of(context).colorScheme.primary)),
                          if (featured) Padding(padding: const EdgeInsets.only(right: 4), child: Icon(Icons.star_rounded, size: 16, color: Colors.amber[700])),
                          Expanded(child: Text(title)),
                        ],
                      ),
                      subtitle: Text('$category • ${published ? "Published" : "Draft"} • $updated'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(icon: const Icon(Icons.edit_rounded), onPressed: id != null ? () async { await context.push('/admin/blog/edit/$id'); if (mounted) _load(); } : null),
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
      floatingActionButton: FloatingActionButton(onPressed: () async { await context.push('/admin/blog/new'); if (mounted) _load(); }, child: const Icon(Icons.add_rounded)),
    );
  }

  Widget _buildCoverThumb(dynamic url) {
    if (url == null || url.toString().isEmpty) {
      return const SizedBox(width: 56, height: 56, child: ColoredBox(color: Colors.grey, child: Icon(Icons.image_not_supported_rounded, color: Colors.white)));
    }
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        url.toString(),
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => const SizedBox(width: 56, height: 56, child: ColoredBox(color: Colors.grey, child: Icon(Icons.broken_image_rounded, color: Colors.white))),
      ),
    );
  }
}
