import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../../../services/exams/exam_policy_service.dart';
import '../application/exams_controller.dart';

final _selectedClassProvider = StateProvider<int?>((ref) => null);

class ExamsScreen extends ConsumerStatefulWidget {
  const ExamsScreen({super.key});

  @override
  ConsumerState<ExamsScreen> createState() => _ExamsScreenState();
}

class _ExamsScreenState extends ConsumerState<ExamsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Engine'),
        bottom: TabBar(
          controller: _tabCtrl,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textMuted,
          tabs: const [
            Tab(text: 'New Exam'),
            Tab(text: 'Marksheet'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded, color: AppColors.primary),
            onPressed: () => _openCreateExam(context, ref),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: [
          const _NewExamTab(),
          _MarksheetTab(ref: ref),
        ],
      ),
    );
  }

  void _openCreateExam(BuildContext context, WidgetRef ref) {
    final selectedClass = ref.read(_selectedClassProvider);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => _CreateExamScreen(initialClassroomId: selectedClass),
      ),
    );
  }
}

/// Form 1: Exam basic info (per class)
class _CreateExamScreen extends ConsumerStatefulWidget {
  final int? initialClassroomId;
  const _CreateExamScreen({this.initialClassroomId});

  @override
  ConsumerState<_CreateExamScreen> createState() => _CreateExamScreenState();
}

class _CreateExamScreenState extends ConsumerState<_CreateExamScreen> {
  final _nameCtrl = TextEditingController();
  final List<String> _examNameOptions = const [
    'Monthly Test',
    'Mid Term',
    'Final Exam',
    'Annual Exam',
    'Custom...',
  ];
  String? _selectedExamName = 'Monthly Test';
  int? _classId;
  DateTime _examMonth = DateTime.now();

  @override
  void initState() {
    super.initState();
    _classId = widget.initialClassroomId;
    _nameCtrl.text = _selectedExamName!;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_nameCtrl.text.trim().isEmpty || _classId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exam name aur class required')),
      );
      return;
    }
    final dao = ref.read(examsDaoProvider);
    final db = ref.read(schoolDatabaseProvider);
    final examId = await dao.createExam(
      ExamsCompanion.insert(
        title: _nameCtrl.text.trim(),
        classroomId: _classId!,
        examDate: Value(DateTime(_examMonth.year, _examMonth.month, 15)),
      ),
    );
    final exam = await dao.getExamById(examId);
    if (!mounted) return;
    if (exam == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exam create nahi ho saka'), backgroundColor: AppColors.error),
      );
      return;
    }
    // refresh exam list for that class
    ref.invalidate(examsForClassProvider(_classId!));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => _ExamDetailScreen(exam: exam)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(schoolDatabaseProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form 1: Exam Info'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Exam ka name', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            value: _selectedExamName,
            decoration: const InputDecoration(border: OutlineInputBorder()),
            dropdownColor: AppColors.card,
            items: _examNameOptions
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (v) {
              setState(() {
                _selectedExamName = v;
                if (v != null && v != 'Custom...') {
                  _nameCtrl.text = v;
                } else {
                  _nameCtrl.clear();
                }
              });
            },
          ),
          const SizedBox(height: 8),
          if (_selectedExamName == 'Custom...' || (_nameCtrl.text.isEmpty && _selectedExamName == null))
            TextField(
              controller: _nameCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(hintText: 'Custom exam name'),
            ),
          const SizedBox(height: 24),
          const Text('Class', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          FutureBuilder<List<Classroom>>(
            future: db.select(db.classrooms).get(),
            builder: (_, snap) {
              if (!snap.hasData) return const SizedBox();
              return DropdownButtonFormField<int>(
                value: _classId,
                decoration: const InputDecoration(border: OutlineInputBorder()),
                dropdownColor: AppColors.card,
                hint: const Text('Select Class'),
                items: snap.data!
                    .map((c) => DropdownMenuItem(
                          value: c.id,
                          child: Text('${c.name} ${c.section}'),
                        ))
                    .toList(),
                onChanged: (v) => setState(() => _classId = v),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('Month', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () async {
              final p = await showDatePicker(
                context: context,
                initialDate: _examMonth,
                firstDate: DateTime(2020),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                builder: (c, child) => Theme(
                  data: Theme.of(c).copyWith(
                    colorScheme: const ColorScheme.dark(primary: AppColors.primary),
                  ),
                  child: child!,
                ),
              );
              if (p != null) setState(() => _examMonth = DateTime(p.year, p.month));
            },
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(
                  Fmt.monthLabel('${_examMonth.year}-${_examMonth.month.toString().padLeft(2, '0')}'),
                  style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _save,
              child: const Text('Save & Go to Subjects'),
            ),
          ),
        ],
      ),
    );
  }
}

class _NewExamTab extends ConsumerWidget {
  const _NewExamTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClass = ref.watch(_selectedClassProvider);
    return Column(
      children: [
        _ClassSelector(
          selectedId: selectedClass,
          onSelect: (id) => ref.read(_selectedClassProvider.notifier).state = id,
        ),
        Expanded(
          child: selectedClass == null
              ? const Center(
                  child: Text(
                    'Class select karein, phir + dabaye exam banane ke liye',
                    style: TextStyle(color: AppColors.textMuted),
                    textAlign: TextAlign.center,
                  ),
                )
              : _ExamsList(classroomId: selectedClass),
        ),
      ],
    );
  }
}

class _MarksheetTab extends ConsumerStatefulWidget {
  final WidgetRef ref;

  const _MarksheetTab({required this.ref});

  @override
  ConsumerState<_MarksheetTab> createState() => _MarksheetTabState();
}

class _MarksheetTabState extends ConsumerState<_MarksheetTab> {
  DateTime _selectedMonth = DateTime.now();
  List<Exam> _exams = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _loadExams();
  }

  Future<void> _loadExams() async {
    setState(() => _loading = true);
    final list = await ref.read(examsDaoProvider).getExamsByMonth(
          _selectedMonth.year,
          _selectedMonth.month,
        );
    if (mounted) setState(() {
      _exams = list;
      _loading = false;
    });
  }

  Future<void> _pickMonth() async {
    final p = await showDatePicker(
      context: context,
      initialDate: _selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (c, child) => Theme(
        data: Theme.of(c).copyWith(
          colorScheme: const ColorScheme.dark(primary: AppColors.primary),
        ),
        child: child!,
      ),
    );
    if (p != null) {
      setState(() => _selectedMonth = DateTime(p.year, p.month));
      _loadExams();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Month select karein',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: _pickMonth,
            child: Row(
              children: [
                const Icon(Icons.calendar_month_rounded,
                    color: AppColors.primary, size: 24),
                const SizedBox(width: 12),
                Text(
                  Fmt.monthLabel(
                      '${_selectedMonth.year}-${_selectedMonth.month.toString().padLeft(2, '0')}'),
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (_loading)
            const Expanded(
                child: Center(
                    child: CircularProgressIndicator(color: AppColors.primary)))
          else if (_exams.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  'Is month mein koi exam nahi',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _exams.length,
                itemBuilder: (_, i) {
                  final exam = _exams[i];
                  return GlassCard(
                    padding: const EdgeInsets.all(14),
                    onTap: () => _generateMarksheetPdf(exam),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.assignment_rounded,
                              color: AppColors.primary, size: 24),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                exam.title,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                exam.examDate != null
                                    ? Fmt.date(exam.examDate)
                                    : '-',
                                style: const TextStyle(
                                    color: AppColors.textMuted, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.picture_as_pdf_rounded,
                            color: AppColors.primary),
                      ],
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _generateMarksheetPdf(Exam exam) async {
    try {
      final dao = ref.read(examsDaoProvider);
      final components = await dao.getComponents(exam.id);
      final students = await ref
          .read(studentsDaoProvider)
          .getStudentsByClassroom(exam.classroomId);
      final allMarks = await dao.getMarksForExam(exam.id);
      final db = ref.read(schoolDatabaseProvider);
      Classroom? cls;
      for (final c in await db.select(db.classrooms).get()) {
        if (c.id == exam.classroomId) {
          cls = c;
          break;
        }
      }
      final rows = <pw.TableRow>[];
      for (final s in students) {
        double total = 0;
        double maxTotal = 0;
        final cells = <pw.Widget>[
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(s.fullName, style: const pw.TextStyle(fontSize: 10)),
                pw.Text(s.admissionNo, style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ];
        for (final c in components) {
          ExamMark? m;
          for (final x in allMarks) {
            if (x.studentId == s.id && x.componentId == c.id) {
              m = x;
              break;
            }
          }
          final obtained = m?.marksObtained ?? 0;
          total += obtained * c.weight;
          maxTotal += c.maxMarks * c.weight;
          cells.add(pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text('${obtained.toStringAsFixed(0)}/${c.maxMarks}',
                style: const pw.TextStyle(fontSize: 9)),
          ));
        }
        final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0.0;
        final grade = await dao.getGradeForPercent(percent);
        final passThreshold = await examPolicyService.getPassFailThreshold();
        final isPass = percent >= passThreshold;
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(
              '${total.toStringAsFixed(0)}/${maxTotal.toStringAsFixed(0)}',
              style: const pw.TextStyle(fontSize: 9)),
        ));
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(grade?.grade ?? '-',
              style: pw.TextStyle(
                  fontSize: 9, fontWeight: pw.FontWeight.bold)),
        ));
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(isPass ? 'Pass' : 'Fail',
              style: pw.TextStyle(
                  fontSize: 9,
                  fontWeight: pw.FontWeight.bold,
                  color: isPass ? PdfColors.green : PdfColors.red)),
        ));
        rows.add(pw.TableRow(children: cells));
      }
      final headerCells = <pw.Widget>[
        pw.Padding(
          padding: const pw.EdgeInsets.all(6),
          child: pw.Text('Student',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ),
        ...components.map(
          (c) => pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text(c.name,
                style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold, fontSize: 9)),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('Total',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('Grade',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('Result',
              style: pw.TextStyle(
                  fontWeight: pw.FontWeight.bold, fontSize: 10)),
        ),
      ];
      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(
            level: 0,
            child: pw.Text('Marksheet - ${exam.title}',
                style: pw.TextStyle(
                    fontSize: 22, fontWeight: pw.FontWeight.bold)),
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            'Class: ${cls?.name ?? ''} ${cls?.section ?? ''} · ${exam.examDate != null ? Fmt.date(exam.examDate) : ''}',
            style: const pw.TextStyle(fontSize: 12),
          ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(width: 0.5),
            children: [
              pw.TableRow(children: headerCells),
              ...rows,
            ],
          ),
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Marksheet PDF ready'),
            backgroundColor: AppColors.success));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Error: $e'), backgroundColor: AppColors.error));
      }
    }
  }
}

class _ClassSelector extends ConsumerWidget {
  final int? selectedId;
  final ValueChanged<int> onSelect;

  const _ClassSelector({required this.selectedId, required this.onSelect});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(schoolDatabaseProvider);
    return FutureBuilder<List<Classroom>>(
      future: db.select(db.classrooms).get(),
      builder: (ctx, snap) {
        if (!snap.hasData) return const SizedBox(height: 50);
        final classes = snap.data!;
        return Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: classes.length,
            itemBuilder: (_, i) {
              final cls = classes[i];
              final selected = cls.id == selectedId;
              return GestureDetector(
                onTap: () => onSelect(cls.id),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? AppColors.primary : AppColors.cardBorder,
                    ),
                  ),
                  child: Text(
                    '${cls.name} ${cls.section}',
                    style: TextStyle(
                      color: selected ? Colors.white : AppColors.textSecondary,
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _ExamsList extends ConsumerWidget {
  final int classroomId;
  const _ExamsList({required this.classroomId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final examsAsync = ref.watch(examsForClassProvider(classroomId));
    return examsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (exams) {
        if (exams.isEmpty) {
          return const Center(
            child: Text('No exams for this class', style: TextStyle(color: AppColors.textMuted)),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: exams.length,
          itemBuilder: (_, i) => _ExamCard(exam: exams[i], index: i),
        );
      },
    );
  }
}

class _ExamCard extends ConsumerWidget {
  final Exam exam;
  final int index;
  const _ExamCard({required this.exam, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GlassCard(
      padding: const EdgeInsets.all(16),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => _ExamDetailScreen(exam: exam),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.assignment_rounded, color: AppColors.primary, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(exam.title, style: const TextStyle(color: AppColors.textPrimary, fontSize: 15, fontWeight: FontWeight.w600)),
                Text(exam.examDate != null ? Fmt.date(exam.examDate) : 'Date TBD', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 20),
        ],
      ),
    ).animate(delay: Duration(milliseconds: index * 60)).fadeIn(duration: 300.ms).slideY(begin: 0.1, end: 0);
  }
}

class _NewExamWizardScreen extends ConsumerStatefulWidget {
  const _NewExamWizardScreen();

  @override
  ConsumerState<_NewExamWizardScreen> createState() => _NewExamWizardScreenState();
}

class _NewExamWizardScreenState extends ConsumerState<_NewExamWizardScreen> {
  int _step = 0;
  final _nameCtrl = TextEditingController();
  final List<String> _examNameOptions = [
    'Monthly Test',
    'Mid Term',
    'Final Exam',
    'Annual Exam',
    'Custom...',
  ];
  String? _selectedExamName = 'Monthly Test';
  int? _classId;
  String _className = '';
  DateTime _examMonth = DateTime.now();
  // Form2: subjectId -> (subjectName, maxMarksController)
  final Map<int, (String, TextEditingController)> _dbSubjectCtrls = {};
  int? _examId;
  final Map<int, Map<int, TextEditingController>> _marksControllers = {};

  @override
  void dispose() {
    _nameCtrl.dispose();
    for (final v in _dbSubjectCtrls.values) v.$2.dispose();
    for (final m in _marksControllers.values) {
      for (final c in m.values) c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_step == 0 ? 'Form 1: Exam Name' : _step == 1 ? 'Form 2: Subjects' : 'Form 3: Marks'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _step == 0 ? _buildStep1() : _step == 1 ? _buildStep2() : _buildStep3(),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              if (_step > 0)
                TextButton(
                  onPressed: () => setState(() => _step--),
                  child: const Text('Back'),
                ),
              const Spacer(),
              ElevatedButton(
                onPressed: _onNext,
                child: Text(_step == 2 ? 'Save & Finish' : 'Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep1() {
    final db = ref.watch(schoolDatabaseProvider);
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const Text('Exam ka name', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: _selectedExamName,
          decoration: const InputDecoration(border: OutlineInputBorder()),
          dropdownColor: AppColors.card,
          items: _examNameOptions
              .map((e) => DropdownMenuItem(value: e, child: Text(e)))
              .toList(),
          onChanged: (v) {
            setState(() {
              _selectedExamName = v;
              if (v != null && v != 'Custom...') {
                _nameCtrl.text = v;
              } else {
                _nameCtrl.clear();
              }
            });
          },
        ),
        const SizedBox(height: 8),
        if (_selectedExamName == 'Custom...' || (_nameCtrl.text.isEmpty && _selectedExamName == null))
          TextField(
            controller: _nameCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(hintText: 'Custom exam name'),
          ),
        const SizedBox(height: 24),
        const Text('Class', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        FutureBuilder<List<Classroom>>(
          future: db.select(db.classrooms).get(),
          builder: (_, snap) {
            if (!snap.hasData) return const SizedBox();
            return DropdownButtonFormField<int>(
              value: _classId,
              decoration: const InputDecoration(border: OutlineInputBorder()),
              dropdownColor: AppColors.card,
              hint: const Text('Select Class'),
              items: snap.data!.map((c) => DropdownMenuItem(value: c.id, child: Text('${c.name} ${c.section}'))).toList(),
              onChanged: (v) => setState(() => _classId = v),
            );
          },
        ),
        const SizedBox(height: 24),
        const Text('Month', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        GlassCard(
          padding: const EdgeInsets.all(14),
          onTap: () async {
            final p = await showDatePicker(context: context, initialDate: _examMonth, firstDate: DateTime(2020), lastDate: DateTime.now().add(const Duration(days: 365)), builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!));
            if (p != null) setState(() => _examMonth = DateTime(p.year, p.month));
          },
          child: Row(
            children: [
              const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
              const SizedBox(width: 12),
              Text(Fmt.monthLabel('${_examMonth.year}-${_examMonth.month.toString().padLeft(2, '0')}'), style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep2() {
    return FutureBuilder<List<Subject>>(
      future: ref.read(settingsDaoProvider).getAllSubjects(),
      builder: (_, snap) {
        if (!snap.hasData) {
          return const Center(child: CircularProgressIndicator(color: AppColors.primary));
        }
        final activeSubjects = snap.data!.where((s) => s.isActive).toList();
        if (activeSubjects.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.book_outlined, color: AppColors.textMuted, size: 48),
                const SizedBox(height: 12),
                const Text('Koi subject nahi mila', style: TextStyle(color: AppColors.textMuted)),
                const SizedBox(height: 8),
                const Text('Settings → Academics mein subjects add karein', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          );
        }
        // init controllers for new subjects
        for (final s in activeSubjects) {
          _dbSubjectCtrls.putIfAbsent(s.id, () => (s.name, TextEditingController(text: '100')));
        }
        return ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Text('Har subject ke total marks likhein', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            const Text('(0 likhein agar ye subject is exam mein nahi)', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
            const SizedBox(height: 16),
            ...activeSubjects.map((s) {
              final ctrl = _dbSubjectCtrls[s.id]!.$2;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(s.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      width: 80,
                      child: TextField(
                        controller: ctrl,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.textPrimary),
                        decoration: const InputDecoration(
                          labelText: 'Max',
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildStep3() {
    if (_examId == null || _classId == null) return const Center(child: Text('Loading...'));
    final studentsAsync = ref.watch(_studentsInClassProvider(_classId!));
    final componentsAsync = ref.watch(examComponentsProvider(_examId!));
    return studentsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
      error: (e, _) => Center(child: Text('Error: $e')),
      data: (students) => componentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (components) {
          return FutureBuilder<List<ExamMark>>(
            future: ref.read(examsDaoProvider).getMarksForExam(_examId!),
            builder: (_, snapMarks) {
              if (!snapMarks.hasData) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primary));
              }
              final allMarks = snapMarks.data ?? [];
              for (final s in students) {
                _marksControllers.putIfAbsent(s.id, () => {});
                for (final c in components) {
                  _marksControllers[s.id]!.putIfAbsent(c.id, () {
                    ExamMark? m;
                    for (final x in allMarks) {
                      if (x.studentId == s.id && x.componentId == c.id) {
                        m = x;
                        break;
                      }
                    }
                    return TextEditingController(
                      text: m != null && m.marksObtained > 0
                          ? m.marksObtained.toStringAsFixed(0)
                          : '',
                    );
                  });
                }
              }
              return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: students.length,
            itemBuilder: (_, i) {
              final s = students[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(s.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600, fontSize: 15)),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        const Icon(Icons.badge_outlined, size: 12, color: AppColors.textMuted),
                        const SizedBox(width: 4),
                        Text(s.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        const SizedBox(width: 12),
                        const Icon(Icons.class_outlined, size: 12, color: AppColors.primary),
                        const SizedBox(width: 4),
                        Text(_className, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: components.map((c) {
                        final ctrl = _marksControllers[s.id]![c.id]!;
                        return SizedBox(
                          width: 100,
                          child: TextField(
                            controller: ctrl,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(color: AppColors.textPrimary, fontSize: 12),
                            decoration: InputDecoration(
                              labelText: c.name,
                              hintText: '0/${c.maxMarks}',
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              isDense: true,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              );
            },
          );
            },
          );
        },
      ),
    );
  }

  Future<void> _onNext() async {
    if (_step == 0) {
      if (_nameCtrl.text.trim().isEmpty || _classId == null) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name aur class required')));
        return;
      }
      // fetch class name for display in Form 3
      final db = ref.read(schoolDatabaseProvider);
      final cls = await (db.select(db.classrooms)..where((c) => c.id.equals(_classId!))).getSingleOrNull();
      final examId = await ref.read(examsDaoProvider).createExam(
        ExamsCompanion.insert(
          title: _nameCtrl.text.trim(),
          classroomId: _classId!,
          examDate: Value(DateTime(_examMonth.year, _examMonth.month, 15)),
        ),
      );
      setState(() {
        _examId = examId;
        _className = cls != null ? '${cls.name} ${cls.section}' : '';
        _step = 1;
      });
    } else if (_step == 1) {
      // collect subjects from DB subject controllers (skip those with 0 or empty marks)
      final selectedSubjects = _dbSubjectCtrls.entries
          .where((e) => (int.tryParse(e.value.$2.text) ?? 0) > 0)
          .toList();
      if (selectedSubjects.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Kam az kam 1 subject ke marks daalen')));
        return;
      }
      final dao = ref.read(examsDaoProvider);
      for (final e in selectedSubjects) {
        await dao.upsertComponent(ExamComponentsCompanion(
          examId: Value(_examId!),
          name: Value(e.value.$1),
          maxMarks: Value(int.tryParse(e.value.$2.text) ?? 100),
          weight: const Value(1.0),
        ));
      }
      setState(() => _step = 2);
    } else {
      final dao = ref.read(examsDaoProvider);
      final components = await dao.getComponents(_examId!);
      final students = await ref.read(studentsDaoProvider).getStudentsByClassroom(_classId!);
      try {
        for (final s in students) {
          for (final c in components) {
            final ctrl = _marksControllers[s.id]?[c.id];
            if (ctrl != null) {
              final marks = double.tryParse(ctrl.text) ?? 0;
              await dao.upsertMark(ExamMarksCompanion(
                examId: Value(_examId!),
                studentId: Value(s.id),
                componentId: Value(c.id),
                marksObtained: Value(marks),
              ));
            }
          }
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam saved! Marksheet ready.'), backgroundColor: AppColors.success));
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('SQLite error: $e'), backgroundColor: AppColors.error));
        }
      }
    }
  }
}

class _ExamDetailScreen extends ConsumerWidget {
  final Exam exam;
  const _ExamDetailScreen({required this.exam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final componentsAsync = ref.watch(examComponentsProvider(exam.id));
    return Scaffold(
      appBar: AppBar(
        title: Text('${exam.title} (${exam.examDate != null ? Fmt.date(exam.examDate) : ''})'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.primary),
            onPressed: () => _generatePdf(context, ref),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _editExam(context, ref);
                  break;
                case 'delete':
                  _confirmDeleteExam(context, ref);
                  break;
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(
                value: 'edit',
                child: Text('Edit exam info'),
              ),
              PopupMenuItem(
                value: 'delete',
                child: Text('Delete exam'),
              ),
            ],
          )
        ],
      ),
      body: componentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (components) {
          if (components.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('No subjects', style: TextStyle(color: AppColors.textMuted)),
                  const SizedBox(height: 16),
                  ElevatedButton(onPressed: () => _addComponent(context, ref), child: const Text('Add Subject')),
                ],
              ),
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              GlassCard(
                padding: const EdgeInsets.all(16),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => _Form3MarksScreen(exam: exam)),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.assignment_turned_in_rounded, color: AppColors.primary, size: 28),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Form 3: Enter Marks & Report', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
                          Text('Student, class, subjects, obtained, Pass/Fail, PDF report', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppColors.primary),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Text('Subjects (edit/delete below)', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              const SizedBox(height: 8),
              ...List.generate(components.length, (i) => _ComponentCard(component: components[i], exam: exam)),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addComponent(context, ref),
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Future<void> _editExam(BuildContext context, WidgetRef ref) async {
    final nameCtrl = TextEditingController(text: exam.title);
    DateTime selectedDate = exam.examDate ?? DateTime.now();
    await showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: StatefulBuilder(
          builder: (ctx, setSheetState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Edit Exam', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                TextField(
                  controller: nameCtrl,
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: const InputDecoration(labelText: 'Exam name'),
                ),
                const SizedBox(height: 16),
                GlassCard(
                  padding: const EdgeInsets.all(12),
                  onTap: () async {
                    final p = await showDatePicker(
                      context: ctx,
                      initialDate: selectedDate,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (c, child) => Theme(
                        data: Theme.of(c).copyWith(
                          colorScheme: const ColorScheme.dark(primary: AppColors.primary),
                        ),
                        child: child!,
                      ),
                    );
                    if (p != null) {
                      setSheetState(() => selectedDate = p);
                    }
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Text(
                        Fmt.date(selectedDate),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () async {
                      await ref.read(examsDaoProvider).updateExam(
                            examId: exam.id,
                            title: nameCtrl.text.trim().isEmpty ? null : nameCtrl.text.trim(),
                            examDate: selectedDate,
                          );
                      ref.invalidate(examsForClassProvider(exam.classroomId));
                      if (context.mounted) Navigator.pop(ctx);
                    },
                    child: const Text('Save changes'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _confirmDeleteExam(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete exam?'),
        content: const Text('Is exam ke saare subjects aur marks delete ho jaayenge. Continue?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(examsDaoProvider).deleteExam(exam.id);
    ref.invalidate(examsForClassProvider(exam.classroomId));
    if (context.mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Exam deleted'), backgroundColor: AppColors.success),
      );
    }
  }

  void _addComponent(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController();
    final marksCtrl = TextEditingController(text: '100');
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: MediaQuery.of(context).viewInsets.bottom + 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Add Subject', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            TextField(controller: nameCtrl, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Subject Name')),
            const SizedBox(height: 12),
            TextField(controller: marksCtrl, keyboardType: TextInputType.number, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(labelText: 'Max Marks')),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  final name = nameCtrl.text.trim();
                  if (name.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject name likhein')));
                    return;
                  }
                  await ref.read(examsDaoProvider).upsertComponent(ExamComponentsCompanion(examId: Value(exam.id), name: Value(name), maxMarks: Value(int.tryParse(marksCtrl.text) ?? 100), weight: const Value(1.0)));
                  ref.invalidate(examComponentsProvider(exam.id));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _generatePdf(BuildContext context, WidgetRef ref) async {
    try {
      final dao = ref.read(examsDaoProvider);
      final components = await dao.getComponents(exam.id);
      final students = await ref.read(studentsDaoProvider).getStudentsByClassroom(exam.classroomId);
      final allMarks = await dao.getMarksForExam(exam.id);
      final rows = <pw.Widget>[];
      for (final s in students) {
        double total = 0;
        double maxTotal = 0;
        final subMarks = <String>[];
        for (final c in components) {
          ExamMark? m;
          for (final x in allMarks) {
            if (x.studentId == s.id && x.componentId == c.id) { m = x; break; }
          }
          final obtained = m?.marksObtained ?? 0;
          total += obtained * c.weight;
          maxTotal += c.maxMarks * c.weight;
          subMarks.add('${c.name}: ${obtained.toStringAsFixed(0)}/${c.maxMarks}');
        }
        final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0.0;
        final grade = await dao.getGradeForPercent(percent);
        rows.add(pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 8),
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Expanded(child: pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [pw.Text(s.fullName, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)), pw.Text(s.admissionNo, style: const pw.TextStyle(fontSize: 10)), pw.Text(subMarks.join(' · '), style: const pw.TextStyle(fontSize: 9))])),
              pw.Text('${grade?.grade ?? '-'} (${percent.toStringAsFixed(0)}%)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ],
          ),
        ));
      }
      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('${exam.title} - Result', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 20),
          ...rows,
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF ready'), backgroundColor: AppColors.success));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }
}

/// Form 3: Student name, class name, subject names, obtained marks, Pass/Fail, Report (PDF)
class _Form3MarksScreen extends ConsumerStatefulWidget {
  final Exam exam;
  const _Form3MarksScreen({required this.exam});

  @override
  ConsumerState<_Form3MarksScreen> createState() => _Form3MarksScreenState();
}

class _Form3MarksScreenState extends ConsumerState<_Form3MarksScreen> {
  final Map<int, Map<int, TextEditingController>> _controllers = {};
  String _className = '';
  double _passThreshold = ExamPolicyService.defaultAutoThreshold;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadClassAndThreshold();
  }

  Future<void> _loadClassAndThreshold() async {
    final db = ref.read(schoolDatabaseProvider);
    final cls = await (db.select(db.classrooms)..where((c) => c.id.equals(widget.exam.classroomId))).getSingleOrNull();
    final t = await examPolicyService.getPassFailThreshold();
    if (mounted) setState(() {
      _className = cls != null ? '${cls.name} ${cls.section}' : '';
      _passThreshold = t;
    });
  }

  @override
  void dispose() {
    for (final m in _controllers.values) {
      for (final c in m.values) c.dispose();
    }
    super.dispose();
  }

  Future<void> _saveAll() async {
    setState(() => _saving = true);
    try {
      final dao = ref.read(examsDaoProvider);
      final components = await dao.getComponents(widget.exam.id);
      for (final e in _controllers.entries) {
        for (final c in components) {
          final ctrl = e.value[c.id];
          if (ctrl != null) {
            await dao.upsertMark(ExamMarksCompanion(
              examId: Value(widget.exam.id),
              studentId: Value(e.key),
              componentId: Value(c.id),
              marksObtained: Value(double.tryParse(ctrl.text) ?? 0),
            ));
          }
        }
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marks saved'), backgroundColor: AppColors.success));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  /// Build SMS body for one student's result and open SMS app (parent number = student.phone).
  Future<void> _sendResultToParent(
    Student s,
    List<ExamComponent> components,
    double total,
    double maxTotal,
    double percent,
    bool isPass,
  ) async {
    final phone = s.phone?.trim();
    if (phone == null || phone.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Is student ka parent number add karein (Students profile)'),
            backgroundColor: AppColors.warning,
          ),
        );
      }
      return;
    }
    final parts = <String>[];
    for (final c in components) {
      final v = _controllers[s.id]?[c.id]?.text ?? '';
      parts.add('${c.name}: ${v.isEmpty ? "0" : v}/${c.maxMarks}');
    }
    final body = '${widget.exam.title}\n'
        'Student: ${s.fullName}\n'
        'Admission: ${s.admissionNo}\n'
        'Class: $_className\n'
        '${parts.join("\n")}\n'
        'Total: ${total.toStringAsFixed(0)}/${maxTotal.toStringAsFixed(0)} · ${percent.toStringAsFixed(0)}%\n'
        'Result: ${isPass ? "Pass" : "Fail"}';
    final uri = Uri(
      scheme: 'sms',
      path: phone.replaceAll(RegExp(r'[\s\-\(\)]'), ''),
      queryParameters: <String, String>{'body': body},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SMS open nahi ho saka'), backgroundColor: AppColors.error),
        );
      }
    }
  }

  Future<void> _generateReport() async {
    try {
      final dao = ref.read(examsDaoProvider);
      final components = await dao.getComponents(widget.exam.id);
      final students = await ref.read(studentsDaoProvider).getStudentsByClassroom(widget.exam.classroomId);
      final allMarks = await dao.getMarksForExam(widget.exam.id);
      final passThreshold = await examPolicyService.getPassFailThreshold();
      final rows = <pw.TableRow>[];
      for (final s in students) {
        double total = 0;
        double maxTotal = 0;
        final cells = <pw.Widget>[
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.Text(s.fullName, style: const pw.TextStyle(fontSize: 10)),
                pw.Text(s.admissionNo, style: const pw.TextStyle(fontSize: 8)),
                pw.Text(_className, style: const pw.TextStyle(fontSize: 8)),
              ],
            ),
          ),
        ];
        for (final c in components) {
          ExamMark? m;
          for (final x in allMarks) {
            if (x.studentId == s.id && x.componentId == c.id) { m = x; break; }
          }
          final obtained = m?.marksObtained ?? 0;
          total += obtained * c.weight;
          maxTotal += c.maxMarks * c.weight;
          cells.add(pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text('${obtained.toStringAsFixed(0)}/${c.maxMarks}', style: const pw.TextStyle(fontSize: 9)),
          ));
        }
        final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0.0;
        final grade = await dao.getGradeForPercent(percent);
        final isPass = percent >= passThreshold;
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text('${total.toStringAsFixed(0)}/${maxTotal.toStringAsFixed(0)}', style: const pw.TextStyle(fontSize: 9)),
        ));
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(grade?.grade ?? '-', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold)),
        ));
        cells.add(pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text(isPass ? 'Pass' : 'Fail', style: pw.TextStyle(fontSize: 9, fontWeight: pw.FontWeight.bold, color: isPass ? PdfColors.green : PdfColors.red)),
        ));
        rows.add(pw.TableRow(children: cells));
      }
      final headerCells = <pw.Widget>[
        pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Student', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
        ...components.map((c) => pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(c.name, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 9)))),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Grade', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
        pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Result', style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 10))),
      ];
      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Marksheet - ${widget.exam.title}', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 4),
          pw.Text('Class: $_className · ${widget.exam.examDate != null ? Fmt.date(widget.exam.examDate) : ''}', style: const pw.TextStyle(fontSize: 12)),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(width: 0.5),
            children: [pw.TableRow(children: headerCells), ...rows],
          ),
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Report PDF ready'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(_studentsInClassProvider(widget.exam.classroomId));
    final componentsAsync = ref.watch(examComponentsProvider(widget.exam.id));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form 3: Marks & Report'),
        actions: [
          if (_saving) const Padding(padding: EdgeInsets.all(16), child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
          else TextButton(onPressed: _saveAll, child: const Text('Save', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600))),
          TextButton.icon(
            onPressed: _generateReport,
            icon: const Icon(Icons.picture_as_pdf_rounded, size: 20),
            label: const Text('Report'),
            style: TextButton.styleFrom(foregroundColor: AppColors.primary),
          ),
        ],
      ),
      body: studentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (students) => componentsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (components) {
            if (components.isEmpty) {
              return const Center(child: Text('Pehle Form 2 mein subjects add karein', style: TextStyle(color: AppColors.textMuted)));
            }
            return FutureBuilder<List<ExamMark>>(
              future: ref.read(examsDaoProvider).getMarksForExam(widget.exam.id),
              builder: (_, snapMarks) {
                if (!snapMarks.hasData) return const Center(child: CircularProgressIndicator(color: AppColors.primary));
                final allMarks = snapMarks.data ?? [];
                for (final s in students) {
                  _controllers.putIfAbsent(s.id, () => {});
                  for (final c in components) {
                    _controllers[s.id]!.putIfAbsent(c.id, () {
                      ExamMark? m;
                      for (final x in allMarks) {
                        if (x.studentId == s.id && x.componentId == c.id) { m = x; break; }
                      }
                      return TextEditingController(
                        text: m != null && m.marksObtained > 0 ? m.marksObtained.toStringAsFixed(0) : '',
                      );
                    });
                  }
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline_rounded, color: AppColors.primary, size: 22),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Class: $_className · ${students.length} students\nHar student ke apne obtained number daalein. Har student ka marks alag save hoga, Pass/Fail alag, report mein sab track hoga.',
                              style: const TextStyle(color: AppColors.textPrimary, fontSize: 12, height: 1.35),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...List.generate(students.length, (i) {
                    final s = students[i];
                    double total = 0;
                    double maxTotal = 0;
                    for (final c in components) {
                      final ctrl = _controllers[s.id]?[c.id];
                      final v = double.tryParse(ctrl?.text ?? '') ?? 0;
                      total += v * c.weight;
                      maxTotal += c.maxMarks * c.weight;
                    }
                    final percent = maxTotal > 0 ? (total / maxTotal) * 100 : 0.0;
                    final isPass = percent >= _passThreshold;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 14),
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.cardBorder),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text('Student ${i + 1}', style: const TextStyle(color: AppColors.primary, fontSize: 11, fontWeight: FontWeight.w600)),
                              ),
                              const SizedBox(width: 10),
                              Expanded(child: Text(s.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700, fontSize: 15))),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.badge_outlined, size: 12, color: AppColors.textMuted),
                              const SizedBox(width: 4),
                              Text(s.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                              const SizedBox(width: 12),
                              const Icon(Icons.class_outlined, size: 12, color: AppColors.primary),
                              const SizedBox(width: 4),
                              Text(_className, style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ...components.map((c) {
                            final ctrl = _controllers[s.id]?[c.id];
                            if (ctrl == null) return const SizedBox();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Row(
                                children: [
                                  SizedBox(width: 100, child: Text(c.name, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12))),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: TextField(
                                      controller: ctrl,
                                      keyboardType: TextInputType.number,
                                      style: const TextStyle(color: AppColors.textPrimary),
                                      decoration: InputDecoration(
                                        hintText: '0/${c.maxMarks}',
                                        isDense: true,
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      ),
                                      onChanged: (_) => setState(() {}),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                            decoration: BoxDecoration(
                              color: isPass ? AppColors.success.withOpacity(0.2) : AppColors.error.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text('Total: ${total.toStringAsFixed(0)}/${maxTotal.toStringAsFixed(0)} · ${percent.toStringAsFixed(0)}% · ${isPass ? 'Pass' : 'Fail'}', style: TextStyle(color: isPass ? AppColors.success : AppColors.error, fontWeight: FontWeight.w600, fontSize: 12)),
                          ),
                          const SizedBox(height: 8),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton.icon(
                              onPressed: () => _sendResultToParent(s, components, total, maxTotal, percent, isPass),
                              icon: const Icon(Icons.sms_rounded, size: 18),
                              label: const Text('Parent ko bhejein'),
                              style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                            ),
                          ),
                        ],
                      ),
                    );
                    }),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _ComponentCard extends ConsumerWidget {
  final ExamComponent component;
  final Exam exam;
  const _ComponentCard({required this.component, required this.exam});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.cardBorder)),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.book_rounded, color: AppColors.secondary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(component.name, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Max: ${component.maxMarks}', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit_note_rounded, color: AppColors.primary, size: 22),
            tooltip: 'Enter marks (Form 3)',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => _MarksEntryScreen(exam: exam, component: component)),
            ),
          ),
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  _editSubject(context, ref);
                  break;
                case 'delete':
                  _confirmDeleteSubject(context, ref);
                  break;
              }
            },
            itemBuilder: (ctx) => const [
              PopupMenuItem(value: 'edit', child: Text('Edit subject')),
              PopupMenuItem(value: 'delete', child: Text('Delete subject')),
            ],
          ),
        ],
      ),
    );
  }

  void _editSubject(BuildContext context, WidgetRef ref) {
    final nameCtrl = TextEditingController(text: component.name);
    final marksCtrl = TextEditingController(text: component.maxMarks.toString());
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Edit Subject', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 16),
            TextField(
              controller: nameCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(labelText: 'Subject name'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: marksCtrl,
              keyboardType: TextInputType.number,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(labelText: 'Max marks'),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () async {
                  await ref.read(examsDaoProvider).updateComponent(
                        componentId: component.id,
                        name: nameCtrl.text.trim().isEmpty ? null : nameCtrl.text.trim(),
                        maxMarks: int.tryParse(marksCtrl.text),
                      );
                  ref.invalidate(examComponentsProvider(exam.id));
                  if (context.mounted) Navigator.pop(context);
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmDeleteSubject(BuildContext context, WidgetRef ref) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete subject?'),
        content: const Text('Is subject ke saare marks bhi delete ho jaayenge. Continue?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
          TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Delete', style: TextStyle(color: AppColors.error))),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(examsDaoProvider).deleteComponent(component.id);
    ref.invalidate(examComponentsProvider(exam.id));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Subject deleted'), backgroundColor: AppColors.success),
      );
    }
  }
}

class _MarksEntryScreen extends ConsumerStatefulWidget {
  final Exam exam;
  final ExamComponent component;
  const _MarksEntryScreen({required this.exam, required this.component});

  @override
  ConsumerState<_MarksEntryScreen> createState() => _MarksEntryScreenState();
}

class _MarksEntryScreenState extends ConsumerState<_MarksEntryScreen> {
  final Map<int, TextEditingController> _controllers = {};
  bool _saving = false;
  double _passThreshold = ExamPolicyService.defaultAutoThreshold;

  @override
  void initState() {
    super.initState();
    _loadThreshold();
  }

  Future<void> _loadThreshold() async {
    final t = await examPolicyService.getPassFailThreshold();
    if (mounted) {
      setState(() {
        _passThreshold = t;
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers.values) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final studentsAsync = ref.watch(_studentsInClassProvider(widget.exam.classroomId));
    final marksAsync = ref.watch(_marksForExamComponentProvider((widget.exam.id, widget.component.id)));
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.component.name} (Max: ${widget.component.maxMarks})'),
        actions: [
          if (_saving) const Padding(padding: EdgeInsets.all(16), child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)))
          else TextButton(onPressed: () => _saveAll(context), child: const Text('Save', style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.w600))),
        ],
      ),
      body: studentsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (students) {
          if (students.isEmpty) return const Center(child: Text('No students', style: TextStyle(color: AppColors.textMuted)));
          return marksAsync.when(
            loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primary)),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (marks) {
              for (final s in students) {
                ExamMark? m;
                for (final x in marks) {
                  if (x.studentId == s.id) { m = x; break; }
                }
                _controllers.putIfAbsent(s.id, () => TextEditingController(text: m != null && m.marksObtained > 0 ? m.marksObtained.toStringAsFixed(0) : ''));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: students.length,
                itemBuilder: (_, i) {
                  final s = students[i];
                  final ctrl = _controllers[s.id]!;
                  final obtained = double.tryParse(ctrl.text) ?? 0;
                  final percent = widget.component.maxMarks > 0 ? (obtained / widget.component.maxMarks) * 100 : 0;
                  final isPass = percent >= _passThreshold;
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
                    child: Row(
                      children: [
                        Expanded(flex: 2, child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(s.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)), Text(s.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 12))])),
                        SizedBox(width: 70, child: TextField(controller: ctrl, keyboardType: TextInputType.number, style: const TextStyle(color: AppColors.textPrimary), decoration: const InputDecoration(hintText: '0', contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))), onChanged: (_) => setState(() {}))),
                        const SizedBox(width: 12),
                        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: isPass ? AppColors.success.withOpacity(0.2) : AppColors.error.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Text(ctrl.text.isEmpty ? '-' : (isPass ? 'Pass' : 'Fail'), style: TextStyle(color: isPass ? AppColors.success : AppColors.error, fontWeight: FontWeight.w600, fontSize: 12))),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Future<void> _saveAll(BuildContext context) async {
    setState(() => _saving = true);
    try {
      final dao = ref.read(examsDaoProvider);
      for (final e in _controllers.entries) {
        await dao.upsertMark(ExamMarksCompanion(examId: Value(widget.exam.id), studentId: Value(e.key), componentId: Value(widget.component.id), marksObtained: Value(double.tryParse(e.value.text) ?? 0)));
      }
      if (mounted) {
        ref.invalidate(_marksForExamComponentProvider((widget.exam.id, widget.component.id)));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marks saved'), backgroundColor: AppColors.success));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

final _studentsInClassProvider = FutureProvider.family<List<Student>, int>((ref, classroomId) {
  return ref.watch(studentsDaoProvider).getStudentsByClassroom(classroomId);
});

final _marksForExamComponentProvider = FutureProvider.family<List<ExamMark>, (int, int)>((ref, pair) async {
  final (examId, componentId) = pair;
  final all = await ref.watch(examsDaoProvider).getMarksForExam(examId);
  return all.where((m) => m.componentId == componentId).toList();
});
