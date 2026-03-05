import 'package:flutter/material.dart';

class OperatorDashboardPage extends StatelessWidget {
  const OperatorDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Computer Operator Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Add/Edit students, print ID cards, print fee slips. No system settings or teacher management.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            children: [
              Card(child: ListTile(leading: const Icon(Icons.school_rounded), title: const Text('Students'))),
              Card(child: ListTile(leading: const Icon(Icons.badge_rounded), title: const Text('ID Cards'))),
              Card(child: ListTile(leading: const Icon(Icons.receipt_rounded), title: const Text('Fee Slips'))),
            ],
          ),
        ],
      ),
    );
  }
}
