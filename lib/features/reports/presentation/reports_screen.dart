import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';

class ReportsScreen extends ConsumerStatefulWidget {
  const ReportsScreen({super.key});

  @override
  ConsumerState<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends ConsumerState<ReportsScreen> {
  DateTime _fromDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _toDate = DateTime.now();
  bool _loading = false;
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';
  Student? _selectedStudent;

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickFromDate() async {
    final p = await showDatePicker(context: context, initialDate: _fromDate, firstDate: DateTime(2020), lastDate: DateTime.now(), builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!));
    if (p != null) setState(() => _fromDate = p);
  }

  Future<void> _pickToDate() async {
    final p = await showDatePicker(context: context, initialDate: _toDate, firstDate: _fromDate, lastDate: DateTime.now().add(const Duration(days: 365)), builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!));
    if (p != null) setState(() => _toDate = p);
  }

  Future<void> _generateReport() async {
    setState(() => _loading = true);
    try {
      final db = ref.read(schoolDatabaseProvider);
      final students = await db.select(db.students).get();
      final from = DateTime(_fromDate.year, _fromDate.month, _fromDate.day);
      final to = DateTime(_toDate.year, _toDate.month, _toDate.day, 23, 59, 59);
      final allInvoices = await db.select(db.feeInvoices).get();
      final allExpenses = await db.select(db.expenses).get();
      final invoices = allInvoices.where((i) => i.createdAt.isAfter(from.subtract(const Duration(days: 1))) && i.createdAt.isBefore(to.add(const Duration(days: 1)))).toList();
      final expenses = allExpenses.where((e) => e.spentAt.isAfter(from.subtract(const Duration(days: 1))) && e.spentAt.isBefore(to.add(const Duration(days: 1)))).toList();

      final revenue = invoices.fold<int>(0, (s, i) => s + i.paidAmount);
      final expenseTotal = expenses.fold<int>(0, (s, e) => s + e.amount);

      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('HubSchool Pro - Complete Report', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 20),
          pw.Text('Period: ${Fmt.date(_fromDate)} to ${Fmt.date(_toDate)}'),
          pw.SizedBox(height: 20),
          pw.Table(border: pw.TableBorder.all(), children: [
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Metric', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Value'))]),
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Total Students')), pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('${students.length}'))]),
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Fee Revenue')), pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(Fmt.moneyInt(revenue ~/ 100)))]),
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Expenses')), pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(Fmt.moneyInt(expenseTotal ~/ 100)))]),
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Net')), pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text(Fmt.moneyInt((revenue - expenseTotal) ~/ 100)))]),
          ]),
          pw.SizedBox(height: 30),
          pw.Header(level: 1, child: pw.Text('Invoices', style: pw.TextStyle(fontSize: 16))),
          pw.Table(border: pw.TableBorder.all(), columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(2), 2: const pw.FlexColumnWidth(1)}, children: [
            pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Month', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Amount', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Status', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))]),
            ...invoices.take(50).map((i) => pw.TableRow(children: [
              pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.monthLabel(i.monthKey))),
              pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.moneyInt(i.netAmount ~/ 100))),
              pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(i.status)),
            ])),
          ]),
        ],
      ));

      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _generateDuesReport() async {
    setState(() => _loading = true);
    try {
      final list = await ref.read(feesDaoProvider).getStudentsWithDues();
      if (list.isEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Koi dues nahi hai'), backgroundColor: AppColors.success));
        return;
      }
      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Fee Dues Report', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 8),
          pw.Text('Generated: ${Fmt.date(DateTime.now())} · ${list.length} students with dues'),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1), 2: const pw.FlexColumnWidth(1)},
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Student', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Adm No', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(padding: const pw.EdgeInsets.all(8), child: pw.Text('Due (Rs)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              ]),
              ...list.map((e) {
                final (s, due) = e;
                return pw.TableRow(children: [
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(s.fullName)),
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(s.admissionNo)),
                  pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.moneyInt(due ~/ 100))),
                ]);
              }),
            ],
          ),
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Dues report generated'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _generateMarksheetPdf(Student student) async {
    setState(() => _loading = true);
    try {
      final db = ref.read(schoolDatabaseProvider);
      final examsDao = ref.read(examsDaoProvider);
      final classroomId = student.classroomId;
      if (classroomId == null) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student not in any class')));
        return;
      }
      final exams = await (db.select(db.exams)..where((e) => e.classroomId.equals(classroomId))).get();
      final List<pw.Widget> rows = [];
      for (final exam in exams) {
        final components = await examsDao.getComponents(exam.id);
        final marks = await examsDao.getMarksForStudent(student.id, exam.id);
        double totalObtained = 0;
        double maxTotal = 0;
        for (final c in components) {
          maxTotal += c.maxMarks * c.weight;
          ExamMark? m;
        for (final x in marks) { if (x.componentId == c.id) { m = x; break; } }
          final obtained = m?.marksObtained ?? 0;
          totalObtained += obtained * c.weight;
        }
        final percent = maxTotal > 0 ? (totalObtained / maxTotal) * 100 : 0;
        final grade = await examsDao.getGradeForPercent(percent.toDouble());
        rows.add(pw.Padding(
          padding: const pw.EdgeInsets.only(bottom: 12),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(exam.title, style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)),
              pw.SizedBox(height: 6),
              pw.Table(
                border: pw.TableBorder.all(width: 0.5),
                columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1), 2: const pw.FlexColumnWidth(1)},
                children: [
                  pw.TableRow(children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Subject', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Marks', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Status', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ]),
                  ...components.map((c) {
                    ExamMark? m;
                    for (final x in marks) { if (x.componentId == c.id) { m = x; break; } }
                    final obtained = m?.marksObtained ?? 0;
                    final pct = c.maxMarks > 0 ? (obtained / c.maxMarks) * 100 : 0;
                    final pass = pct >= 50;
                    return pw.TableRow(children: [
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(c.name)),
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${obtained.toStringAsFixed(0)} / ${c.maxMarks}')),
                      pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text(pass ? 'Pass' : 'Fail')),
                    ]);
                  }),
                  pw.TableRow(children: [
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${totalObtained.toStringAsFixed(0)} / ${maxTotal.toStringAsFixed(0)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                    pw.Padding(padding: const pw.EdgeInsets.all(4), child: pw.Text('${grade?.grade ?? '-'} (${percent.toStringAsFixed(1)}%)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                  ]),
                ],
              ),
            ],
          ),
        ));
      }

      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Marksheet - ${student.fullName}', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 8),
          pw.Text('Admission No: ${student.admissionNo}'),
          pw.SizedBox(height: 20),
          ...rows,
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Marksheet PDF generated'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _generateFeesPdf(Student student) async {
    setState(() => _loading = true);
    try {
      final feesDao = ref.read(feesDaoProvider);
      final invoices = await feesDao.watchStudentInvoices(student.id).first;
      final pdf = pw.Document();
      pdf.addPage(pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Fees & Dues - ${student.fullName}', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.SizedBox(height: 8),
          pw.Text('Admission No: ${student.admissionNo}'),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1), 2: const pw.FlexColumnWidth(1), 3: const pw.FlexColumnWidth(1)},
            children: [
              pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Month', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Total', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Paid', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Due', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))),
              ]),
              ...invoices.map((i) => pw.TableRow(children: [
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.monthLabel(i.monthKey))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.moneyInt(i.netAmount ~/ 100))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.moneyInt(i.paidAmount ~/ 100))),
                pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(Fmt.moneyInt(i.dueAmount ~/ 100))),
              ])),
            ],
          ),
          pw.SizedBox(height: 12),
          pw.Text('Total Dues: ${Fmt.moneyInt(invoices.where((i) => i.status != 'paid').fold<int>(0, (s, i) => s + i.dueAmount) ~/ 100)}', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ],
      ));
      await Printing.layoutPdf(onLayout: (_) async => pdf.save());
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fees PDF generated'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reports')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Student Search', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          TextField(
            controller: _searchCtrl,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: InputDecoration(
              hintText: 'Search by name or admission no',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textMuted),
              filled: true,
              fillColor: AppColors.card,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
            onChanged: (v) => setState(() => _searchQuery = v.trim()),
          ),
          if (_searchQuery.isNotEmpty) ...[
            const SizedBox(height: 12),
            FutureBuilder<List<Student>>(
              future: ref.read(studentsDaoProvider).searchStudents(_searchQuery),
              builder: (_, snap) {
                if (!snap.hasData) return const SizedBox();
                final list = snap.data!;
                if (list.isEmpty) return const Text('No students found', style: TextStyle(color: AppColors.textMuted));
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: list.take(10).map((s) => GlassCard(
                    padding: const EdgeInsets.all(12),
                    onTap: () => setState(() => _selectedStudent = s),
                    child: Row(
                      children: [
                        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          Text(s.fullName, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                          Text(s.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                        ])),
                        if (_selectedStudent?.id == s.id) const Icon(Icons.check_circle, color: AppColors.success),
                      ],
                    ),
                  )).toList(),
                );
              },
            ),
          ],
          if (_selectedStudent != null) ...[
            const SizedBox(height: 20),
            const Text('Student Reports', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _loading ? null : () => _generateMarksheetPdf(_selectedStudent!),
                    icon: const Icon(Icons.assignment_rounded, size: 20),
                    label: const Text('Marksheet PDF'),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _loading ? null : () => _generateFeesPdf(_selectedStudent!),
                    icon: const Icon(Icons.receipt_long_rounded, size: 20),
                    label: const Text('Fees PDF'),
                    style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 28),
          const Text('Date Range', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: GlassCard(
              padding: const EdgeInsets.all(14),
              onTap: _pickFromDate,
              child: Row(children: [
                const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Text(Fmt.date(_fromDate), style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ]),
            )),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Icon(Icons.arrow_forward_rounded, color: AppColors.textMuted)),
            Expanded(child: GlassCard(
              padding: const EdgeInsets.all(14),
              onTap: _pickToDate,
              child: Row(children: [
                const Icon(Icons.calendar_today_rounded, color: AppColors.primary, size: 20),
                const SizedBox(width: 10),
                Text(Fmt.date(_toDate), style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
              ]),
            )),
          ]),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton.icon(
              onPressed: _loading ? null : _generateDuesReport,
              icon: const Icon(Icons.money_off_rounded, size: 20),
              label: const Text('Dues Report (Students with Pending Fees)'),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.warning)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: _loading ? null : _generateReport,
              icon: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.picture_as_pdf_rounded),
              label: Text(_loading ? 'Generating...' : 'Generate Full PDF Report'),
            ),
          ),
        ]),
      ),
    );
  }
}
