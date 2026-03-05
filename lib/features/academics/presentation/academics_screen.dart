import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

class AcademicsScreen extends ConsumerStatefulWidget {
  const AcademicsScreen({super.key});

  @override
  ConsumerState<AcademicsScreen> createState() => _AcademicsScreenState();
}

class _AcademicsScreenState extends ConsumerState<AcademicsScreen> with SingleTickerProviderStateMixin {
  late final TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Classes & Subjects'),
        bottom: TabBar(controller: _tab, isScrollable: true, indicatorColor: AppColors.primary, labelColor: AppColors.primary, unselectedLabelColor: AppColors.textMuted, tabs: const [
          Tab(text: 'Classes'),
          Tab(text: 'Subjects'),
          Tab(text: 'Teachers'),
          Tab(text: 'Assign'),
        ]),
      ),
      body: TabBarView(controller: _tab, children: const [_ClassesTab(), _SubjectsTab(), _TeachersTab(), _AssignTab()]),
    );
  }
}

class _ClassesTab extends ConsumerWidget {
  const _ClassesTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dao = ref.watch(settingsDaoProvider);
    return StreamBuilder<List<Classroom>>(
      stream: dao.watchClassrooms(),
      builder: (ctx, snap) {
        final list = snap.data ?? [];
        return Scaffold(
          body: list.isEmpty
              ? const Center(child: Text('No classes added', style: TextStyle(color: AppColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: list.length,
                  itemBuilder: (_, i) {
                    final c = list[i];
                    return GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.class_rounded, color: AppColors.primary, size: 20)),
                        const SizedBox(width: 12),
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text('${c.name} - ${c.section}', style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                          Text('Year: ${c.academicYear}', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                        ])),
                        IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20), onPressed: () => dao.deleteClassroom(c.id)),
                      ]),
                    ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 250.ms);
                  },
                ),
          floatingActionButton: FloatingActionButton(onPressed: () => _addClassDialog(context, ref), child: const Icon(Icons.add)),
        );
      },
    );
  }

  void _addClassDialog(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final secCtrl = TextEditingController(text: 'A');
    showModalBottomSheet(
      context: context, backgroundColor: AppColors.surface, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Add Class', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          TextField(controller: nameCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Class Name (e.g. Grade 8)')),
          const SizedBox(height: 12),
          TextField(controller: secCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Section (e.g. A, B)')),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
            onPressed: () async {
              if (nameCtrl.text.trim().isEmpty) return;
              await ref.read(settingsDaoProvider).insertClassroom(ClassroomsCompanion.insert(
                name: nameCtrl.text.trim(), section: Value(secCtrl.text.trim()), academicYear: DateTime.now().year,
              ));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Add'),
          )),
        ]),
      ),
    );
  }
}

class _SubjectsTab extends ConsumerWidget {
  const _SubjectsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dao = ref.watch(settingsDaoProvider);
    return StreamBuilder<List<Subject>>(
      stream: dao.watchSubjects(),
      builder: (ctx, snap) {
        final list = snap.data ?? [];
        return Scaffold(
          body: list.isEmpty
              ? const Center(child: Text('No subjects added', style: TextStyle(color: AppColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16), itemCount: list.length,
                  itemBuilder: (_, i) {
                    final s = list[i];
                    return GlassCard(
                      padding: const EdgeInsets.all(14),
                      child: Row(children: [
                        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                          child: const Icon(Icons.book_rounded, color: AppColors.secondary, size: 20)),
                        const SizedBox(width: 12),
                        Expanded(child: Text(s.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600))),
                        IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20), onPressed: () => dao.deleteSubject(s.id)),
                      ]),
                    ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 250.ms);
                  },
                ),
          floatingActionButton: FloatingActionButton(onPressed: () => _addDialog(context, ref), child: const Icon(Icons.add)),
        );
      },
    );
  }

  void _addDialog(BuildContext context, WidgetRef ref) {
    final ctrl = TextEditingController();
    showModalBottomSheet(
      context: context, backgroundColor: AppColors.surface, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Add Subject', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          TextField(controller: ctrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Subject Name (e.g. Mathematics)')),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
            onPressed: () async {
              if (ctrl.text.trim().isEmpty) return;
              await ref.read(settingsDaoProvider).insertSubject(SubjectsCompanion.insert(name: ctrl.text.trim()));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Add'),
          )),
        ]),
      ),
    );
  }
}

class _TeachersTab extends ConsumerWidget {
  const _TeachersTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final staffAsync = ref.watch(staffListProvider);
    return staffAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (list) => Scaffold(
        body: list.isEmpty
            ? const Center(child: Text('No teachers added', style: TextStyle(color: AppColors.textMuted)))
            : ListView.builder(
                padding: const EdgeInsets.all(16), itemCount: list.length,
                itemBuilder: (_, i) {
                  final t = list[i];
                  return GlassCard(
                    padding: const EdgeInsets.all(14),
                    child: Row(children: [
                      Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Text(t.fullName.substring(0, 1).toUpperCase(), style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700, fontSize: 18)))),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(t.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                        Text('${t.designation} · ${t.employeeCode}', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
                      ])),
                      Text('Rs ${t.baseSalary ~/ 100}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
                    ]),
                  ).animate(delay: Duration(milliseconds: i * 40)).fadeIn(duration: 250.ms);
                },
              ),
        floatingActionButton: FloatingActionButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const _AddTeacherSheet())), child: const Icon(Icons.person_add_rounded)),
      ),
    );
  }
}

class _AddTeacherSheet extends ConsumerStatefulWidget {
  const _AddTeacherSheet();

  @override
  ConsumerState<_AddTeacherSheet> createState() => _AddTeacherSheetState();
}

class _AddTeacherSheetState extends ConsumerState<_AddTeacherSheet> {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  String _designation = 'Teacher';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Teacher')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Full Name')),
          const SizedBox(height: 12),
          TextField(controller: _codeCtrl, decoration: const InputDecoration(labelText: 'Employee Code')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _designation, decoration: const InputDecoration(labelText: 'Designation'), items: ['Teacher', 'Principal', 'Vice Principal', 'Lab Assistant', 'Clerk', 'Admin'].map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(), onChanged: (v) => setState(() => _designation = v ?? _designation)),
          const SizedBox(height: 12),
          TextField(controller: _salaryCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Base Salary (Rs)')),
          const SizedBox(height: 24),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
            onPressed: () async {
              await ref.read(staffDaoProvider).insertStaff(StaffCompanion(
                fullName: Value(_nameCtrl.text.trim()),
                employeeCode: Value(_codeCtrl.text.trim()),
                designation: Value(_designation),
                baseSalary: Value((int.tryParse(_salaryCtrl.text) ?? 0) * 100),
              ));
              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('Add Teacher'),
          )),
        ]),
      ),
    );
  }
}

class _AssignTab extends ConsumerStatefulWidget {
  const _AssignTab();

  @override
  ConsumerState<_AssignTab> createState() => _AssignTabState();
}

class _AssignTabState extends ConsumerState<_AssignTab> {
  List<Map<String, dynamic>> _assignments = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final dao = ref.read(settingsDaoProvider);
      final db = ref.read(schoolDatabaseProvider);
      final data = await dao.getAssignmentsWithDetails();
      final list = <Map<String, dynamic>>[];
      for (final r in data) {
        final staff = r.readTable(db.staff);
        final cls = r.readTable(db.classrooms);
        final sub = r.readTable(db.subjects);
        final a = r.readTable(db.teacherAssignments);
        list.add({'staff': staff, 'cls': cls, 'sub': sub, 'id': a.id});
      }
      if (mounted) setState(() { _assignments = list; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
    return Scaffold(
      body: _assignments.isEmpty
          ? Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.assignment_ind_rounded, size: 64, color: AppColors.textMuted),
              const SizedBox(height: 12),
              const Text('No assignments yet', style: TextStyle(color: AppColors.textMuted)),
              const SizedBox(height: 16),
              ElevatedButton.icon(onPressed: () => _addAssignment(context), icon: const Icon(Icons.add), label: const Text('Assign Teacher')),
            ]))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _assignments.length,
              itemBuilder: (_, i) {
                final m = _assignments[i];
                final staff = m['staff'] as StaffData;
                final cls = m['cls'] as Classroom;
                final sub = m['sub'] as Subject;
                return GlassCard(
                  padding: const EdgeInsets.all(14),
                  child: Row(children: [
                    Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                      child: const Icon(Icons.assignment_ind_rounded, color: AppColors.warning, size: 20)),
                    const SizedBox(width: 12),
                    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(staff.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                      Text('${cls.name} ${cls.section} · ${sub.name}', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                    ])),
                    IconButton(icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20), onPressed: () async {
                      await ref.read(settingsDaoProvider).deleteAssignment(m['id'] as int);
                      _load();
                    }),
                  ]),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(onPressed: () => _addAssignment(context), icon: const Icon(Icons.link_rounded), label: const Text('Assign')),
    );
  }

  void _addAssignment(BuildContext context) async {
    final dao = ref.read(settingsDaoProvider);
    final classes = await dao.getAllClassrooms();
    final subjects = await dao.getAllSubjects();
    final staffList = await ref.read(staffDaoProvider).watchActiveStaff().first;
    if (classes.isEmpty || subjects.isEmpty || staffList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pehle class, subject aur teacher add karein'), backgroundColor: AppColors.warning));
      return;
    }
    int? selStaff, selClass, selSub;
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => StatefulBuilder(builder: (ctx, setS) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Text('Assign Teacher', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          _dropdown<StaffData>('Select Teacher', staffList, selStaff, (v) => setS(() => selStaff = v), (s) => s.fullName, (s) => s.id),
          const SizedBox(height: 12),
          _dropdown<Classroom>('Select Class', classes, selClass, (v) => setS(() => selClass = v), (c) => '${c.name} ${c.section}', (c) => c.id),
          const SizedBox(height: 12),
          _dropdown<Subject>('Select Subject', subjects, selSub, (v) => setS(() => selSub = v), (s) => s.name, (s) => s.id),
          const SizedBox(height: 20),
          SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
            onPressed: () async {
              if (selStaff == null || selClass == null || selSub == null) return;
              await dao.insertAssignment(TeacherAssignmentsCompanion.insert(staffId: selStaff!, classroomId: selClass!, subjectId: selSub!));
              if (ctx.mounted) Navigator.pop(ctx);
              _load();
            },
            child: const Text('Assign'),
          )),
        ]),
      )),
    );
  }

  Widget _dropdown<T>(String hint, List<T> items, int? value, ValueChanged<int?> onChanged, String Function(T) label, int Function(T) getId) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
      child: DropdownButtonHideUnderline(child: DropdownButton<int>(
        value: value, isExpanded: true, dropdownColor: AppColors.card,
        hint: Text(hint, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
        style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
        items: items.map((i) => DropdownMenuItem(value: getId(i), child: Text(label(i)))).toList(),
        onChanged: onChanged,
      )),
    );
  }
}

final staffListProvider = StreamProvider<List<StaffData>>((ref) => ref.watch(staffDaoProvider).watchActiveStaff());
