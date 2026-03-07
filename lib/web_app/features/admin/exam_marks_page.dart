import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class ExamMarksPage extends StatefulWidget {
  final int examId;

  const ExamMarksPage({super.key, required this.examId});

  @override
  State<ExamMarksPage> createState() => _ExamMarksPageState();
}

class _ExamMarksPageState extends State<ExamMarksPage> {
  Map<String, dynamic>? _exam;
  String _className = '—';
  List<Map<String, dynamic>> _components = [];
  List<Map<String, dynamic>> _students = [];
  List<Map<String, dynamic>> _marks = [];
  bool _loading = true;
  String? _error;
  final _searchCtrl = TextEditingController();
  int? _marksheetStudentId;

  List<Map<String, dynamic>> get _filteredStudents {
    final q = _searchCtrl.text.trim().toLowerCase();
    if (q.isEmpty) return _students;
    return _students.where((s) {
      final name = (s['full_name'] as String? ?? '').toLowerCase();
      final adm = (s['admission_no'] as String? ?? '').toLowerCase();
      return name.contains(q) || adm.contains(q);
    }).toList();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; _selStudentId = null; _selComponentId = null; });
    try {
      final exam = await Supabase.instance.client.from(SupabaseConfig.tExams).select().eq('id', widget.examId).maybeSingle();
      final classId = exam != null ? exam['classroom_id'] as int? : null;
      String className = '-';
      if (classId != null) {
        final cls = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select('name, section').eq('id', classId).maybeSingle();
        if (cls != null) className = '${cls['name']} ${cls['section']}';
      }
      final comp = await Supabase.instance.client.from(SupabaseConfig.tExamComponents).select().eq('exam_id', widget.examId);
      List<Map<String, dynamic>> stu = [];
      if (classId != null) {
        try {
          final enroll = await Supabase.instance.client.from(SupabaseConfig.tEnrollments).select('student_id').eq('classroom_id', classId).eq('current', true);
          List<dynamic> ids = (enroll as List).map((e) => e['student_id']).toSet().toList();
          if (ids.isEmpty) {
            final fallback = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').eq('classroom_id', classId).eq('is_active', true);
            stu = List<Map<String, dynamic>>.from(fallback);
          } else {
            final s = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').inFilter('id', ids).order('full_name');
            stu = List<Map<String, dynamic>>.from(s);
          }
        } catch (_) {
          final fallback = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').eq('classroom_id', classId).eq('is_active', true);
          stu = List<Map<String, dynamic>>.from(fallback);
        }
      }
      final marksRes = await Supabase.instance.client.from(SupabaseConfig.tExamMarks).select().eq('exam_id', widget.examId);
      if (mounted) setState(() { _exam = exam != null ? Map<String, dynamic>.from(exam) : null; _className = className; _components = List<Map<String, dynamic>>.from(comp); _students = stu; _marks = List<Map<String, dynamic>>.from(marksRes); _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    } finally {
      if (mounted && _loading) setState(() => _loading = false);
    }
  }

  double? _getMark(int studentId, int componentId) {
    for (final m in _marks) {
      if (m['student_id'] == studentId && m['component_id'] == componentId) {
        final v = m['marks_obtained'];
        if (v is num) return v.toDouble();
        return double.tryParse(v?.toString() ?? '');
      }
    }
    return null;
  }

  int? _selStudentId;
  int? _selComponentId;
  final _marksCtrl = TextEditingController();

  Future<void> _saveMark(int studentId, int componentId, double value) async {
    try {
      final existing = _marks.where((m) => m['student_id'] == studentId && m['component_id'] == componentId).firstOrNull;
      if (existing != null) {
        await Supabase.instance.client.from(SupabaseConfig.tExamMarks).update({'marks_obtained': value}).eq('id', existing['id']);
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tExamMarks).insert({'exam_id': widget.examId, 'student_id': studentId, 'component_id': componentId, 'marks_obtained': value});
      }
      await _load();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marks saved')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _editMarkDialog(int studentId, int componentId, String studentName, String componentName) async {
    final cur = _getMark(studentId, componentId);
    final ctrl = TextEditingController(text: cur != null ? cur.toStringAsFixed(1) : '');
    final v = await showDialog<double?>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Enter marks'),
        content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$studentName – $componentName', style: Theme.of(ctx).textTheme.bodyMedium),
          const SizedBox(height: 12),
          TextField(controller: ctrl, keyboardType: const TextInputType.numberWithOptions(decimal: true), decoration: const InputDecoration(labelText: 'Marks', border: OutlineInputBorder()), autofocus: true),
        ]),
        actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')), FilledButton(onPressed: () { final x = double.tryParse(ctrl.text.trim()); Navigator.pop(ctx, x); }, child: const Text('Save'))],
      ),
    );
    if (v != null) await _saveMark(studentId, componentId, v);
  }

  Future<void> _submitMark() async {
    if (_selStudentId == null || _selComponentId == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select student and component'))); return; }
    final v = double.tryParse(_marksCtrl.text.trim());
    if (v == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter marks'))); return; }
    await _saveMark(_selStudentId!, _selComponentId!, v);
    _marksCtrl.clear();
  }

  Future<int> _getPassPercentage() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tAppSettings).select('value').eq('key', 'pass_percentage').maybeSingle();
      if (r != null) {
        final v = int.tryParse(r['value']?.toString() ?? '');
        if (v != null && v >= 0 && v <= 100) return v;
      }
    } catch (_) {}
    return 40;
  }

  Future<void> _downloadMarksheetPdf(int? studentId) async {
    if (studentId == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select a student for marksheet'))); return; }
    final s = _students.where((x) => x['id'] == studentId).firstOrNull;
    if (s == null) return;
    final name = s['full_name'] as String? ?? '—';
    final rollNo = s['admission_no'] as String? ?? '—';
    final examTitle = _exam?['title'] as String? ?? 'Exam';
    final examDate = _exam?['exam_date']?.toString().substring(0, 10) ?? '—';

    int totalMax = 0;
    double totalObtained = 0;
    final rows = <pw.TableRow>[
      pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey300), children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Subject', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Max', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Obtained', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))]),
    ];
    for (final c in _components) {
      final cid = c['id'] as int?;
      final maxM = (c['max_marks'] as num?)?.toInt() ?? 0;
      final ob = _getMark(studentId, cid ?? 0);
      totalMax += maxM;
      totalObtained += ob ?? 0;
      rows.add(pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(c['name'] as String? ?? '—')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('$maxM')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(ob != null ? ob.toStringAsFixed(1) : '—'))]));
    }
    rows.add(pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey200), children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('$totalMax')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(totalObtained.toStringAsFixed(1)))]));
    final percent = totalMax > 0 ? (totalObtained / totalMax * 100) : 0.0;
    final passThreshold = await _getPassPercentage();
    final passFail = percent >= passThreshold ? 'Pass' : 'Fail';

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Marksheet', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.Paragraph(text: 'Exam: $examTitle  |  Date: $examDate'),
          pw.Paragraph(text: 'Student: $name  |  Roll No: $rollNo  |  Class: $_className'),
          pw.SizedBox(height: 16),
          pw.Table(border: pw.TableBorder.all(), columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1), 2: const pw.FlexColumnWidth(1)}, children: rows),
          pw.SizedBox(height: 12),
          pw.Paragraph(text: 'Percentage: ${percent.toStringAsFixed(1)}%  |  Pass threshold: $passThreshold%  |  Result: $passFail'),
        ],
      ),
    );
    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _marksCtrl.dispose(); _searchCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.go('/admin/exams'))), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!, textAlign: TextAlign.center), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    final filtered = _filteredStudents;
    return Scaffold(
      appBar: AppBar(title: Text(_exam?['title'] as String? ?? 'Exam Marks'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/exams'); })),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          TextField(controller: _searchCtrl, onChanged: (_) => setState(() {}), decoration: const InputDecoration(hintText: 'Search student by name or roll no...', prefixIcon: Icon(Icons.search_rounded), border: OutlineInputBorder(), isDense: true)),
          const SizedBox(height: 12),
          Wrap(spacing: 12, runSpacing: 8, children: [
            DropdownButtonFormField<int>(value: _marksheetStudentId, decoration: const InputDecoration(labelText: 'Student for marksheet', isDense: true, border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('Select student')), ..._students.map((s) => DropdownMenuItem(value: s['id'] as int?, child: Text('${s['full_name']} (${s['admission_no']})')))], onChanged: (v) => setState(() => _marksheetStudentId = v)),
            FilledButton.icon(onPressed: () => _downloadMarksheetPdf(_marksheetStudentId), icon: const Icon(Icons.picture_as_pdf_rounded), label: const Text('Download Marksheet PDF')),
          ]),
        ])),
        if (_students.isEmpty && _exam != null)
          Expanded(child: Padding(padding: const EdgeInsets.all(16), child: Center(child: Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.school_rounded, size: 48, color: Theme.of(context).colorScheme.outline), const SizedBox(height: 12), Text('No students in this exam class.', style: Theme.of(context).textTheme.titleSmall), Text('Assign a class to the exam (Edit Exam) or add enrollments for this class.', style: Theme.of(context).textTheme.bodySmall, textAlign: TextAlign.center), const SizedBox(height: 16), FilledButton.icon(onPressed: () => context.go('/admin/exams'), icon: const Icon(Icons.list_rounded), label: const Text('Back to Exams'))])))))),
        if (_students.isNotEmpty && _components.isNotEmpty)
          Card(margin: const EdgeInsets.symmetric(horizontal: 16), child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            Expanded(child: DropdownButtonFormField<int>(value: _selStudentId, decoration: const InputDecoration(labelText: 'Student', isDense: true), items: [const DropdownMenuItem(value: null, child: Text('Select')), ..._students.map((s) => DropdownMenuItem(value: s['id'] as int?, child: Text(s['full_name'] as String? ?? '')))], onChanged: (v) => setState(() => _selStudentId = v))),
            const SizedBox(width: 12),
            Expanded(child: DropdownButtonFormField<int>(value: _selComponentId, decoration: const InputDecoration(labelText: 'Subject', isDense: true), items: [const DropdownMenuItem(value: null, child: Text('Select')), ..._components.map((c) => DropdownMenuItem(value: c['id'] as int?, child: Text(c['name'] as String? ?? '')))], onChanged: (v) => setState(() => _selComponentId = v))),
            const SizedBox(width: 12),
            SizedBox(width: 90, child: TextField(controller: _marksCtrl, decoration: const InputDecoration(labelText: 'Marks', isDense: true), keyboardType: TextInputType.number)),
            const SizedBox(width: 8),
            FilledButton(onPressed: _submitMark, child: const Text('Save')),
          ]))),
        if (_students.isNotEmpty)
          Expanded(child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: SingleChildScrollView(
          child: DataTable(
            columns: [
              const DataColumn(label: Text('Student')),
              const DataColumn(label: Text('Roll No')),
              const DataColumn(label: Text('Class')),
              ..._components.map((c) => DataColumn(label: Text((c['name'] as String?) ?? ''))),
            ],
            rows: filtered.map((s) {
              final sid = s['id'] as int?;
              final name = s['full_name'] as String? ?? '—';
              final rollNo = s['admission_no'] as String? ?? '—';
              return DataRow(
                cells: [
                  DataCell(Text(name)),
                  DataCell(Text(rollNo)),
                  DataCell(Text(_className)),
                  ..._components.map((c) {
                    final cid = c['id'] as int?;
                    final cur = _getMark(sid ?? 0, cid ?? 0);
                    return DataCell(
                      InkWell(onTap: () => _editMarkDialog(sid ?? 0, cid ?? 0, name, c['name'] as String? ?? ''), child: Text(cur != null ? cur.toStringAsFixed(1) : '—')),
                    );
                  }),
                ],
              );
            }).toList(),
          ),
        ))),
      ]),
    );
  }
}
