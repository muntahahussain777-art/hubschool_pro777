import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../application/students_controller.dart';

class StudentsScreen extends ConsumerWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final studentsAsync = ref.watch(filteredStudentsProvider);
    final query = ref.watch(studentSearchProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Students'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list_rounded, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/students/add'),
        label: const Text('Add Student'),
        icon: const Icon(Icons.person_add_rounded),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search by name or admission no...',
                prefixIcon: Icon(Icons.search_rounded, color: AppColors.primary, size: 20),
              ),
              onChanged: (v) => ref.read(studentSearchProvider.notifier).state = v,
            ),
          ),
          Expanded(
            child: studentsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
              error: (e, _) => Center(child: Text('Error: $e', style: const TextStyle(color: AppColors.error))),
              data: (students) {
                if (students.isEmpty) {
                  return _buildEmpty(query);
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: students.length,
                  itemBuilder: (ctx, i) => _StudentCard(
                    student: students[i],
                    index: i,
                  ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 300.ms).slideX(begin: -0.05),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmpty(String query) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.school_outlined, size: 72, color: AppColors.textMuted.withOpacity(0.5)),
          const SizedBox(height: 16),
          Text(
            query.isEmpty ? 'No students added yet' : 'No results for "$query"',
            style: const TextStyle(color: AppColors.textMuted, fontSize: 16),
          ),
          if (query.isEmpty) ...[
            const SizedBox(height: 8),
            const Text(
              'Tap + to add your first student',
              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }
}

class _StudentCard extends ConsumerWidget {
  final Student student;
  final int index;

  const _StudentCard({required this.student, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: () => _showStudentDetails(context, student),
      child: Row(
        children: [
          _buildAvatar(),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  student.fullName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Adm: ${student.admissionNo} · ${student.fatherName}${student.gender != null ? ' · ${student.gender == 'male' ? 'M' : 'F'}' : ''}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                ),
                if (student.phone != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    student.phone!,
                    style: const TextStyle(color: AppColors.textMuted, fontSize: 11),
                  ),
                ],
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: student.isActive
                      ? AppColors.success.withOpacity(0.15)
                      : AppColors.error.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  student.isActive ? 'Active' : 'Inactive',
                  style: TextStyle(
                    color: student.isActive ? AppColors.success : AppColors.error,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final initials = student.fullName.trim().split(' ').take(2).map((w) => w.isNotEmpty ? w[0] : '').join();
    final colors = [
      AppColors.primary, AppColors.secondary, AppColors.success,
      AppColors.warning, AppColors.accent, const Color(0xFFFF63B8),
    ];
    final color = colors[student.id % colors.length];

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color, color.withOpacity(0.6)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          initials.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  void _showStudentDetails(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) => _StudentDetailSheet(student: student),
    );
  }
}

class _StudentDetailSheet extends StatelessWidget {
  final Student student;
  const _StudentDetailSheet({required this.student});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.7,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      builder: (_, ctrl) => ListView(
        controller: ctrl,
        padding: const EdgeInsets.all(20),
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.cardBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                  ),
                  child: QrImageView(
                    data: student.qrToken,
                    version: QrVersions.auto,
                    size: 160,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  student.fullName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Admission: ${student.admissionNo}',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _infoRow('Father Name', student.fatherName),
          _infoRow('Phone', student.phone ?? '-'),
          _infoRow('Date of Birth', Fmt.date(student.dob)),
          _infoRow('Address', student.address ?? '-'),
          _infoRow('Enrolled On', Fmt.date(student.createdAt)),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/fees?studentId=${student.id}');
                  },
                  icon: const Icon(Icons.payments_rounded, size: 18),
                  label: const Text('View Fees'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    context.push('/students/add', extra: student);
                  },
                  icon: const Icon(Icons.edit_rounded, size: 18, color: AppColors.primary),
                  label: const Text('Edit', style: TextStyle(color: AppColors.primary)),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppColors.primary),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
