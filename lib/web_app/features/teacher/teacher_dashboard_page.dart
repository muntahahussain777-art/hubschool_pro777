import 'package:flutter/material.dart';

class TeacherDashboardPage extends StatelessWidget {
  const TeacherDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Teacher Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Assigned classes only. Mark attendance, enter exam marks, view students. No delete or financial access.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 32),
          Card(
            child: ListTile(
              leading: const Icon(Icons.class_rounded),
              title: const Text('My Classes'),
              subtitle: const Text('View and manage assigned classes'),
            ),
          ),
        ],
      ),
    );
  }
}
