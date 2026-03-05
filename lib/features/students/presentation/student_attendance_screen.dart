import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../../../services/student_attendance_service.dart';

class StudentAttendanceScreen extends ConsumerStatefulWidget {
  const StudentAttendanceScreen({super.key});

  @override
  ConsumerState<StudentAttendanceScreen> createState() => _StudentAttendanceScreenState();
}

class _StudentAttendanceScreenState extends ConsumerState<StudentAttendanceScreen> {
  List<Student> _students = [];
  Map<int, String> _attendance = {};
  DateTime _selectedDate = DateTime.now();
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() => _loading = true);
    try {
      final dao = ref.read(studentsDaoProvider);
      final list = await dao.watchActiveStudents().first;
      final records = await StudentAttendanceService.getForDate(_selectedDate);
      final map = {for (var r in records) r.studentId: r.status};
      if (mounted) setState(() { _students = list; _attendance = map; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickDate() async {
    final p = await showDatePicker(context: context, initialDate: _selectedDate, firstDate: DateTime(2020), lastDate: DateTime.now().add(const Duration(days: 365)), builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!));
    if (p != null) setState(() { _selectedDate = p; _load(); });
  }

  Future<void> _mark(int studentId, String name, String status) async {
    await StudentAttendanceService.markAttendance(studentId, name, status);
    setState(() => _attendance[studentId] = status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
        actions: [
          TextButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.calendar_today_rounded, size: 18, color: AppColors.primary),
            label: Text('${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}', style: const TextStyle(color: AppColors.primary)),
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _students.isEmpty
              ? const Center(child: Text('No students', style: TextStyle(color: AppColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _students.length,
                  itemBuilder: (_, i) {
                    final s = _students[i];
                    final status = _attendance[s.id] ?? 'not_marked';
                    return GlassCard(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          Container(
                            width: 44, height: 44,
                            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                            child: Center(child: Text(s.fullName.substring(0, 1).toUpperCase(), style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.w700, fontSize: 18))),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text(s.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 14)),
                              Text(s.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                            ]),
                          ),
                          _AttBtn(label: 'P', color: AppColors.success, active: status == 'present', onTap: () => _mark(s.id, s.fullName, 'present')),
                          const SizedBox(width: 6),
                          _AttBtn(label: 'A', color: AppColors.error, active: status == 'absent', onTap: () => _mark(s.id, s.fullName, 'absent')),
                        ],
                      ),
                    ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 250.ms).slideX(begin: -0.04);
                  },
                ),
    );
  }
}

class _AttBtn extends StatelessWidget {
  final String label;
  final Color color;
  final bool active;
  final VoidCallback onTap;

  const _AttBtn({required this.label, required this.color, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 34, height: 34,
        decoration: BoxDecoration(color: active ? color : color.withOpacity(0.1), borderRadius: BorderRadius.circular(10), border: Border.all(color: color.withOpacity(active ? 1 : 0.3))),
        child: Center(child: Text(label, style: TextStyle(color: active ? Colors.white : color, fontWeight: FontWeight.w700, fontSize: 13))),
      ),
    );
  }
}
