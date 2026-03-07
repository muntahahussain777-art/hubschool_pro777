import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import '../../utils/slug_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _announcements = [];
  List<Map<String, dynamic>> _posts = [];
  bool _loadingAnn = true;
  bool _loadingBlog = true;

  @override
  void initState() {
    super.initState();
    _loadAnnouncements();
    _loadPosts();
  }

  Future<void> _loadAnnouncements() async {
    try {
      final now = DateTime.now();
      final today = now.toIso8601String().substring(0, 10);
      final res = await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).select().eq('is_published', true);
      var list = List<Map<String, dynamic>>.from(res);
      list = list.where((a) {
        final start = a['start_date']?.toString();
        if (start != null && start.length >= 10 && start.substring(0, 10).compareTo(today) > 0) return false;
        final end = a['end_date']?.toString();
        if (end != null && end.length >= 10 && end.substring(0, 10).compareTo(today) < 0) return false;
        return true;
      }).toList();
      list.sort((a, b) {
        final aPin = (a['is_pinned'] == true) ? 1 : 0;
        final bPin = (b['is_pinned'] == true) ? 1 : 0;
        if (bPin != aPin) return bPin - aPin;
        final aUrgent = (a['priority'] == 'urgent') ? 1 : 0;
        final bUrgent = (b['priority'] == 'urgent') ? 1 : 0;
        if (bUrgent != aUrgent) return bUrgent - aUrgent;
        final aAt = a['created_at']?.toString() ?? '';
        final bAt = b['created_at']?.toString() ?? '';
        return bAt.compareTo(aAt);
      });
      if (mounted) setState(() { _announcements = list; _loadingAnn = false; });
    } catch (_) {
      if (mounted) setState(() => _loadingAnn = false);
    }
  }

  Future<void> _loadPosts() async {
    try {
      final res = await Supabase.instance.client
          .from(SupabaseConfig.tBlogPosts)
          .select()
          .eq('is_published', true)
          .order('published_at', ascending: false);
      var list = List<Map<String, dynamic>>.from(res);
      list.sort((a, b) {
        final aPin = (a['is_pinned'] == true) ? 1 : 0;
        final bPin = (b['is_pinned'] == true) ? 1 : 0;
        if (bPin != aPin) return bPin - aPin;
        final aFeat = (a['is_featured'] == true) ? 1 : 0;
        final bFeat = (b['is_featured'] == true) ? 1 : 0;
        if (bFeat != aFeat) return bFeat - aFeat;
        final aAt = a['published_at']?.toString() ?? a['created_at']?.toString() ?? '';
        final bAt = b['published_at']?.toString() ?? b['created_at']?.toString() ?? '';
        return bAt.compareTo(aAt);
      });
      if (mounted) setState(() { _posts = list; _loadingBlog = false; });
    } catch (_) {
      if (mounted) setState(() => _loadingBlog = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HubSchool'),
        actions: [
          if (MediaQuery.of(context).size.width >= 600) ...[
            TextButton(onPressed: () => context.go('/about'), child: const Text('About')),
            TextButton(onPressed: () => context.go('/admissions'), child: const Text('Admissions')),
            TextButton(onPressed: () => context.go('/contact'), child: const Text('Contact')),
            TextButton(onPressed: () => context.go('/news'), child: const Text('News')),
            TextButton(onPressed: () => context.go('/blog'), child: const Text('Blog')),
          ],
          const SizedBox(width: 8),
          FilledButton(onPressed: () => context.go('/login'), child: const Text('Login')),
          const SizedBox(width: 16),
        ],
      ),
      drawer: MediaQuery.of(context).size.width < 600
          ? Drawer(
              child: ListView(
                padding: const EdgeInsets.only(top: 48),
                children: [
                  ListTile(title: const Text('Home'), onTap: () => context.go('/')),
                  ListTile(title: const Text('About'), onTap: () => context.go('/about')),
                  ListTile(title: const Text('Admissions'), onTap: () => context.go('/admissions')),
                  ListTile(title: const Text('Contact'), onTap: () => context.go('/contact')),
                  ListTile(title: const Text('News'), onTap: () => context.go('/news')),
                  ListTile(title: const Text('Blog'), onTap: () => context.go('/blog')),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _hero(context),
            _announcementsSection(context),
            _latestNewsSection(context),
            _featureCards(context),
          ],
        ),
      ),
    );
  }

  Widget _hero(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.width < 600 ? 40 : 80,
        horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 24,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primaryContainer,
            Theme.of(context).colorScheme.secondaryContainer,
          ],
        ),
      ),
      child: Column(
        children: [
          Text(
            'Welcome to HubSchool',
            style: Theme.of(context).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            'Excellence in Education',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 32),
          FilledButton.tonal(onPressed: () => context.go('/admissions'), child: const Text('Admissions')),
        ],
      ),
    );
  }

  Widget _announcementsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.campaign_rounded, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text('Announcements', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          if (_loadingAnn)
            const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
          else if (_announcements.isEmpty)
            Card(child: Padding(padding: const EdgeInsets.all(24), child: Center(child: Text('No announcements at the moment.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)))))
          else
            ..._announcements.map((a) => _AnnouncementCard(key: ValueKey(a['id']), data: a)),
        ],
      ),
    );
  }

  Widget _latestNewsSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 32, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.newspaper_rounded, color: Theme.of(context).colorScheme.primary),
              const SizedBox(width: 8),
              Text('Latest News & Blog', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          if (_loadingBlog)
            const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
          else if (_posts.isEmpty)
            Card(child: Padding(padding: const EdgeInsets.all(24), child: Center(child: Text('No posts yet.', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)))))
          else
            LayoutBuilder(
              builder: (context, constraints) {
                final crossCount = constraints.maxWidth > 800 ? 3 : (constraints.maxWidth > 500 ? 2 : 1);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossCount,
                    childAspectRatio: 0.85,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _posts.length,
                  itemBuilder: (context, i) => _PostCard(data: _posts[i]),
                );
              },
            ),
          const SizedBox(height: 16),
          if (!_loadingBlog && _posts.isNotEmpty)
            Center(child: TextButton.icon(onPressed: () => context.go('/blog'), icon: const Icon(Icons.article_rounded), label: const Text('View all posts'))),
        ],
      ),
    );
  }

  Widget _featureCards(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
      child: Wrap(
        spacing: 24,
        runSpacing: 24,
        alignment: WrapAlignment.center,
        children: [
          _FeatureCard(icon: Icons.school_rounded, title: 'Students', subtitle: 'Manage student records and progress'),
          _FeatureCard(icon: Icons.assignment_rounded, title: 'Exams & Results', subtitle: 'Exams, marks, and report cards'),
          _FeatureCard(icon: Icons.payments_rounded, title: 'Fees', subtitle: 'Fee management and slips'),
          _FeatureCard(icon: Icons.article_rounded, title: 'News & Blog', subtitle: 'Latest updates and articles'),
        ],
      ),
    );
  }
}

class _AnnouncementCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _AnnouncementCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final type = data['type'] as String? ?? 'announcement';
    final priority = data['priority'] as String? ?? 'normal';
    final pinned = data['is_pinned'] == true;
    final title = data['title'] as String? ?? '—';
    final message = data['message'] as String? ?? '';
    final endDate = data['end_date']?.toString();
    String endStr = '';
    if (endDate != null && endDate.length >= 10) endStr = endDate.substring(0, 10);

    Color? badgeColor;
    if (type == 'urgent' || priority == 'urgent') badgeColor = Colors.red;
    else if (type == 'holiday') badgeColor = Colors.orange;
    else if (type == 'exam') badgeColor = Theme.of(context).colorScheme.primary;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [
                if (pinned) Chip(label: const Text('Pinned'), avatar: const Icon(Icons.push_pin_rounded, size: 16), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                Chip(label: Text(type), backgroundColor: badgeColor?.withOpacity(0.2), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                if (priority == 'urgent') Chip(label: const Text('Urgent'), backgroundColor: Colors.red.withOpacity(0.2), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                if (priority == 'important') Chip(label: const Text('Important'), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                if (endStr.isNotEmpty) Chip(label: Text('Until $endStr'), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
              ],
            ),
            const SizedBox(height: 8),
            Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            if (message.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(message, style: Theme.of(context).textTheme.bodyMedium)),
          ],
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final Map<String, dynamic> data;

  const _PostCard({required this.data});

  @override
  Widget build(BuildContext context) {
    final slug = data['slug'] as String? ?? '';
    final title = data['title'] as String? ?? '—';
    final summary = data['summary'] as String? ?? '';
    final coverUrl = data['cover_image_url'] as String?;
    final category = data['category'] as String? ?? 'Blog';
    final publishedAt = data['published_at']?.toString();
    String dateStr = '';
    if (publishedAt != null && publishedAt.length >= 10) dateStr = publishedAt.substring(0, 10);
    final featured = data['is_featured'] == true;
    final pinned = data['is_pinned'] == true;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: slug.isEmpty ? null : () => context.go('/blog/${safeSlugForRoute(slug)}'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: coverUrl != null && coverUrl.isNotEmpty
                  ? Image.network(coverUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => _placeholder(context))
                  : _placeholder(context),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Chip(label: Text(category), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap),
                      if (pinned) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.push_pin_rounded, size: 16)),
                      if (featured) const Padding(padding: EdgeInsets.only(left: 4), child: Icon(Icons.star_rounded, size: 16, color: Colors.amber)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                  if (summary.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 4), child: Text(summary, style: Theme.of(context).textTheme.bodySmall, maxLines: 2, overflow: TextOverflow.ellipsis)),
                  if (dateStr.isNotEmpty) Padding(padding: const EdgeInsets.only(top: 6), child: Text(dateStr, style: Theme.of(context).textTheme.labelSmall)),
                  const SizedBox(height: 8),
                  TextButton(onPressed: slug.isEmpty ? null : () => context.go('/blog/${safeSlugForRoute(slug)}'), child: const Text('Read more')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _placeholder(BuildContext context) {
    return Container(color: Theme.of(context).colorScheme.surfaceContainerHighest, child: Icon(Icons.image_not_supported_rounded, size: 40, color: Theme.of(context).colorScheme.onSurfaceVariant));
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({required this.icon, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SizedBox(
          width: 260,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 12),
              Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
