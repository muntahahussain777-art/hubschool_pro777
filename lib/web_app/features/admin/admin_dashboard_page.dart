import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key});

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  bool _loading = true;
  String? _error;
  int _totalStudents = 0;
  int _totalStaff = 0;
  int _totalClasses = 0;
  int _monthlyRevenue = 0;
  int _pendingDues = 0;
  int _staffPresentToday = 0;
  int _monthlyExpenses = 0;
  int _blogPublished = 0;
  int _blogDraft = 0;
  int _announcementsActive = 0;
  int _announcementsUrgent = 0;

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final client = Supabase.instance.client;
      final now = DateTime.now();
      final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';
      final today = now.toIso8601String().substring(0, 10);

      final studentsRes = await client.from(SupabaseConfig.tStudents).select('id');
      final staffRes = await client.from(SupabaseConfig.tStaff).select('id');
      final classesRes = await client.from(SupabaseConfig.tClassrooms).select('id');

      _totalStudents = (studentsRes as List).length;
      _totalStaff = (staffRes as List).length;
      _totalClasses = (classesRes as List).length;

      final invoicesRes = await client.from(SupabaseConfig.tFeeInvoices).select('paid_amount, net_amount, due_amount');
      int revenue = 0, due = 0;
      for (final i in invoicesRes as List) {
        revenue += (i['paid_amount'] as num?)?.toInt() ?? 0;
        due += (i['due_amount'] as num?)?.toInt() ?? 0;
      }
      _monthlyRevenue = revenue;
      _pendingDues = due;

      final staffAttRes = await client.from(SupabaseConfig.tStaffAttendance).select('id').eq('date', today).eq('status', 'present');
      _staffPresentToday = (staffAttRes as List).length;

      final expensesRes = await client.from(SupabaseConfig.tExpenses).select('amount');
      int exp = 0;
      for (final e in expensesRes as List) { exp += (e['amount'] as num?)?.toInt() ?? 0; }
      _monthlyExpenses = exp;

      final blogRes = await client.from(SupabaseConfig.tBlogPosts).select('is_published');
      int pub = 0, draft = 0;
      for (final r in blogRes as List) { if (r['is_published'] == true) pub++; else draft++; }
      _blogPublished = pub;
      _blogDraft = draft;

      final annRes = await client.from(SupabaseConfig.tAnnouncements).select('is_published,end_date,priority');
      int active = 0, urgent = 0;
      for (final a in annRes as List) {
        if (a['is_published'] != true) continue;
        final end = a['end_date']?.toString();
        if (end != null && end.length >= 10 && end.substring(0, 10).compareTo(today) < 0) continue;
        active++;
        if (a['priority'] == 'urgent') urgent++;
      }
      _announcementsActive = active;
      _announcementsUrgent = urgent;

      if (mounted) setState(() { _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  @override
  void initState() {
    super.initState();
    _load();
  }

  static String _money(int paisa) => 'Rs ${paisa ~/ 100}';

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            const SizedBox(height: 16),
            FilledButton(onPressed: _load, child: const Text('Retry')),
          ],
        ),
      );
    }
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Admin Dashboard', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('Full control: Students, Teachers, Classes, Exams, Fees, Reports, Settings, News & Blog.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
          const SizedBox(height: 32),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _StatCard(title: 'Total Students', value: '$_totalStudents', icon: Icons.school_rounded),
              _StatCard(title: 'Total Staff', value: '$_totalStaff', icon: Icons.badge_rounded),
              _StatCard(title: 'Staff Present Today', value: '$_staffPresentToday', icon: Icons.how_to_reg_rounded),
              _StatCard(title: 'Classes', value: '$_totalClasses', icon: Icons.class_rounded),
              _StatCard(title: 'Fee Revenue (all time)', value: _money(_monthlyRevenue), icon: Icons.payments_rounded),
              _StatCard(title: 'Pending Dues', value: _money(_pendingDues), icon: Icons.pending_rounded, color: _pendingDues > 0 ? Colors.orange : null),
              _StatCard(title: 'Total Expenses', value: _money(_monthlyExpenses), icon: Icons.receipt_long_rounded),
              _StatCard(title: 'Blog (published)', value: '$_blogPublished', icon: Icons.article_rounded),
              _StatCard(title: 'Blog (drafts)', value: '$_blogDraft', icon: Icons.edit_note_rounded),
              _StatCard(title: 'Active announcements', value: '$_announcementsActive', icon: Icons.campaign_rounded),
              _StatCard(title: 'Urgent notices', value: '$_announcementsUrgent', icon: Icons.warning_rounded, color: _announcementsUrgent > 0 ? Colors.orange : null),
            ],
          ),
          const SizedBox(height: 32),
          Text('Quick actions', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton.icon(onPressed: () => context.go('/admin/students/add'), icon: const Icon(Icons.person_add_rounded), label: const Text('New Admission')),
              FilledButton.icon(onPressed: () => context.go('/admin/fees/add'), icon: const Icon(Icons.receipt_rounded), label: const Text('New Invoice')),
              FilledButton.icon(onPressed: () => context.go('/admin/staff-attendance'), icon: const Icon(Icons.how_to_reg_rounded), label: const Text('Staff Attendance')),
              FilledButton.icon(onPressed: () => context.go('/admin/student-attendance'), icon: const Icon(Icons.people_rounded), label: const Text('Student Attendance')),
              FilledButton.icon(onPressed: () => context.go('/admin/exams/add'), icon: const Icon(Icons.assignment_rounded), label: const Text('New Exam')),
              FilledButton.icon(onPressed: () => context.go('/admin/blog/new'), icon: const Icon(Icons.post_add_rounded), label: const Text('New Blog Post')),
              FilledButton.icon(onPressed: () => context.go('/admin/announcements/new'), icon: const Icon(Icons.campaign_rounded), label: const Text('New Announcement')),
              OutlinedButton.icon(onPressed: () => context.go('/admin/blog'), icon: const Icon(Icons.article_rounded), label: const Text('Blog & News')),
              OutlinedButton.icon(onPressed: () => context.go('/admin/announcements'), icon: const Icon(Icons.campaign_rounded), label: const Text('Announcements')),
              OutlinedButton.icon(onPressed: () => context.go('/admin/reports'), icon: const Icon(Icons.assessment_rounded), label: const Text('Reports')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;

  const _StatCard({required this.title, required this.value, required this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 32, color: color ?? Theme.of(context).colorScheme.primary),
              const SizedBox(height: 12),
              Text(value, style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
              Text(title, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ),
      ),
    );
  }
}
