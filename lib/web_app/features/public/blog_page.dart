import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import '../../utils/slug_utils.dart';

/// Public: Blog listing (all published posts).
class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.go('/')),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Supabase.instance.client
            .from(SupabaseConfig.tBlogPosts)
            .select()
            .eq('is_published', true)
            .order('published_at', ascending: false),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.article_outlined, size: 64, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  const SizedBox(height: 16),
                  Text('No posts yet.', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: () => context.go('/'), child: const Text('Home')),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
            itemCount: list.length,
            itemBuilder: (context, i) {
              final r = list[i];
              final slug = r['slug'] as String? ?? '';
              final title = r['title'] as String? ?? '—';
              final summary = r['summary'] as String? ?? '';
              final category = r['category'] as String? ?? 'Blog';
              final pub = r['published_at']?.toString();
              final dateStr = pub != null && pub.length >= 10 ? pub.substring(0, 10) : '';
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (summary.isNotEmpty) Text(summary, maxLines: 2, overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Row(children: [Chip(label: Text(category), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap), if (dateStr.isNotEmpty) Padding(padding: const EdgeInsets.only(left: 8), child: Text(dateStr, style: Theme.of(context).textTheme.labelSmall))]),
                    ],
                  ),
                  isThreeLine: true,
                  onTap: slug.isEmpty ? null : () => context.go('/blog/${safeSlugForRoute(slug)}'),
                  trailing: const Icon(Icons.arrow_forward_rounded),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
