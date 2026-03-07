import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// Public: Single blog post by slug (published only).
class BlogArticlePage extends StatelessWidget {
  final String slug;

  const BlogArticlePage({super.key, required this.slug});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: Supabase.instance.client
          .from(SupabaseConfig.tBlogPosts)
          .select()
          .eq('slug', slug)
          .eq('is_published', true)
          .maybeSingle(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.go('/'))),
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        final post = snapshot.data;
        if (post == null) {
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.go('/')),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.article_outlined, size: 48),
                  const SizedBox(height: 16),
                  const Text('Post not found'),
                  const SizedBox(height: 16),
                  FilledButton(onPressed: () => context.go('/'), child: const Text('Home')),
                ],
              ),
            ),
          );
        }
        final title = post['title'] as String? ?? '-';
        final summary = post['summary'] as String? ?? '';
        final content = post['content'] as String? ?? '';
        final coverUrl = post['cover_image_url'] as String?;
        final category = post['category'] as String? ?? 'Blog';
        final author = post['author_name'] as String? ?? '';
        final publishedAt = post['published_at']?.toString();
        String dateStr = '';
        if (publishedAt != null && publishedAt.length >= 10) dateStr = publishedAt.substring(0, 10);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Article'),
            leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.go('/')),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (coverUrl != null && coverUrl.isNotEmpty)
                  Image.network(coverUrl, height: 240, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder(context)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 48, vertical: 24),
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 800),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(label: Text(category)),
                        const SizedBox(height: 8),
                        Text(title, style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
                        if (author.isNotEmpty || dateStr.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              '$author${author.isNotEmpty && dateStr.isNotEmpty ? ' - ' : ''}$dateStr',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ),
                        if (summary.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 12), child: Text(summary, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant))),
                        const SizedBox(height: 24),
                        SelectableText(content, style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(height: 240, color: Theme.of(context).colorScheme.surfaceContainerHighest, child: Icon(Icons.image_not_supported_rounded, size: 48, color: Theme.of(context).colorScheme.onSurfaceVariant));
  }
}
