import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
          FilledButton(
            onPressed: () => context.go('/login'),
            child: const Text('Login'),
          ),
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
            Container(
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
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Excellence in Education',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton.tonal(
                    onPressed: () => context.go('/admissions'),
                    child: const Text('Admissions'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 48),
            Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width < 600 ? 16 : 24),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                alignment: WrapAlignment.center,
                children: [
                  _FeatureCard(
                    icon: Icons.school_rounded,
                    title: 'Students',
                    subtitle: 'Manage student records and progress',
                  ),
                  _FeatureCard(
                    icon: Icons.assignment_rounded,
                    title: 'Exams & Results',
                    subtitle: 'Exams, marks, and report cards',
                  ),
                  _FeatureCard(
                    icon: Icons.payments_rounded,
                    title: 'Fees',
                    subtitle: 'Fee management and slips',
                  ),
                  _FeatureCard(
                    icon: Icons.article_rounded,
                    title: 'News & Blog',
                    subtitle: 'Latest updates and articles',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

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
