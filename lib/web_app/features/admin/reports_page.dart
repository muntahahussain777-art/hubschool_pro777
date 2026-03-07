import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../../../config/supabase_config.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _loading = true;
  int _studentCount = 0;
  int _totalRevenue = 0;
  int _totalExpenses = 0;
  List<Map<String, dynamic>> _recentInvoices = [];
  List<Map<String, dynamic>> _recentExpenses = [];
  List<Map<String, dynamic>> _studentFeeReport = [];
  List<Map<String, dynamic>> _examMarksReport = [];
  List<Map<String, dynamic>> _classrooms = [];
  String _searchQuery = '';
  int? _filterClassId;
  String? _error;
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _load();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final client = Supabase.instance.client;
      final studentsRes = await client.from(SupabaseConfig.tStudents).select('id');
      _studentCount = (studentsRes as List).length;

      final invoicesRes = await client.from(SupabaseConfig.tFeeInvoices).select('paid_amount, net_amount, student_id, month_key, status');
      int revenue = 0;
      final invoices = List<Map<String, dynamic>>.from(invoicesRes);
      for (final i in invoices) { revenue += (i['paid_amount'] as num?)?.toInt() ?? 0; }

      final expensesRes = await client.from(SupabaseConfig.tExpenses).select('amount');
      int expenses = 0;
      for (final e in expensesRes) { expenses += (e['amount'] as num?)?.toInt() ?? 0; }

      final recentInv = await client.from(SupabaseConfig.tFeeInvoices).select().order('created_at', ascending: false).limit(15);
      final recentExp = await client.from(SupabaseConfig.tExpenses).select().order('spent_at', ascending: false).limit(15);

      final students = await client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no, classroom_id');
      final cls = await client.from(SupabaseConfig.tClassrooms).select('id, name, section');
      final stuList = List<Map<String, dynamic>>.from(students);
      final classList = List<Map<String, dynamic>>.from(cls);
      String className(int? cid) {
        if (cid == null) return '—';
        final c = classList.where((x) => x['id'] == cid).firstOrNull;
        return c != null ? '${c['name']} ${c['section']}' : '—';
      }
      List<Map<String, dynamic>> feeReport = [];
      for (final s in stuList) {
        final sid = s['id'] as int?;
        final cid = s['classroom_id'] as int?;
        int billed = 0, paid = 0;
        for (final i in invoices) {
          if (i['student_id'] == sid) {
            billed += (i['net_amount'] as num?)?.toInt() ?? 0;
            paid += (i['paid_amount'] as num?)?.toInt() ?? 0;
          }
        }
        feeReport.add({'id': sid, 'full_name': s['full_name'], 'admission_no': s['admission_no'], 'classroom_id': cid, 'class_name': className(cid), 'billed': billed, 'paid': paid, 'due': billed - paid});
      }
      feeReport.sort((a, b) => ((b['due'] as int).compareTo(a['due'] as int)));

      final marksRes = await client.from(SupabaseConfig.tExamMarks).select('exam_id, student_id, component_id, marks_obtained');
      final compRes = await client.from(SupabaseConfig.tExamComponents).select('id, exam_id, name, max_marks, weight');
      final examsRes = await client.from(SupabaseConfig.tExams).select('id, title');
      List<Map<String, dynamic>> marksReport = [];
      for (final m in marksRes as List) {
        final examId = m['exam_id']; final studentId = m['student_id']; final compId = m['component_id'];
        final comp = (compRes as List).where((c) => c['id'] == compId).firstOrNull;
        final exam = (examsRes as List).where((e) => e['id'] == examId).firstOrNull;
        final stu = stuList.where((s) => s['id'] == studentId).firstOrNull;
        final ob = (m['marks_obtained'] as num?)?.toDouble() ?? 0;
        final maxM = comp != null ? (comp['max_marks'] as num?)?.toInt() ?? 0 : 0;
        marksReport.add({'exam': exam?['title'], 'student': stu?['full_name'], 'admission_no': stu?['admission_no'], 'component': comp?['name'], 'obtained': ob, 'max_marks': maxM});
      }

      if (mounted) {
        setState(() {
          _totalRevenue = revenue;
          _totalExpenses = expenses;
          _recentInvoices = List<Map<String, dynamic>>.from(recentInv);
          _recentExpenses = List<Map<String, dynamic>>.from(recentExp);
          _studentFeeReport = feeReport;
          _examMarksReport = marksReport;
          _classrooms = classList;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  static String _money(int paisa) {
    if (paisa.abs() < 100) return 'Rs ${paisa ~/ 100}';
    return 'Rs ${(paisa / 100).toStringAsFixed(0)}';
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))]));
    final net = _totalRevenue - _totalExpenses;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Reports', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(child: TextField(controller: _searchCtrl, decoration: const InputDecoration(labelText: 'Search by student name / admission no', border: OutlineInputBorder(), isDense: true), onChanged: (v) => setState(() => _searchQuery = v.toLowerCase()))),
          const SizedBox(width: 12),
          SizedBox(width: 180, child: DropdownButtonFormField<int>(value: _filterClassId, decoration: const InputDecoration(labelText: 'Class', isDense: true, border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('All')), ..._classrooms.map((c) => DropdownMenuItem(value: c['id'] as int?, child: Text('${c['name']} ${c['section']}')))], onChanged: (v) => setState(() => _filterClassId = v))),
        ]),
        const SizedBox(height: 8),
        TabBar(controller: _tabController, isScrollable: true, tabs: const [Tab(text: 'Summary'), Tab(text: 'Profit / Loss'), Tab(text: 'Student Fee'), Tab(text: 'Exam Marksheet')]),
        const SizedBox(height: 16),
        Expanded(
          child: TabBarView(controller: _tabController, children: [
            _buildSummary(net),
            _buildProfitLoss(net),
            _buildStudentFeeReport(),
            _buildExamMarksheetReport(),
          ]),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _filterFeeReport() {
    var list = _studentFeeReport;
    if (_searchQuery.isNotEmpty) list = list.where((r) => ((r['full_name'] as String?) ?? '').toLowerCase().contains(_searchQuery) || ((r['admission_no'] as String?) ?? '').toLowerCase().contains(_searchQuery)).toList();
    if (_filterClassId != null) list = list.where((r) => r['classroom_id'] == _filterClassId).toList();
    return list;
  }

  List<Map<String, dynamic>> _filterMarksReport() {
    var list = _examMarksReport;
    if (_searchQuery.isNotEmpty) list = list.where((r) => ((r['student'] as String?) ?? '').toLowerCase().contains(_searchQuery) || ((r['admission_no'] as String?) ?? '').toLowerCase().contains(_searchQuery)).toList();
    return list;
  }

  Widget _buildSummary(int net) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Wrap(spacing: 16, runSpacing: 16, children: [
          _StatCard(title: 'Total Students', value: '$_studentCount', icon: Icons.school_rounded),
          _StatCard(title: 'Fee Revenue', value: _money(_totalRevenue), icon: Icons.payments_rounded),
          _StatCard(title: 'Expenses', value: _money(_totalExpenses), icon: Icons.receipt_long_rounded),
          _StatCard(title: 'Net', value: _money(net), icon: Icons.account_balance_wallet_rounded, color: net >= 0 ? Colors.green : Colors.red),
        ]),
        const SizedBox(height: 24),
        Text('Recent Fee Invoices', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(child: _recentInvoices.isEmpty ? const Padding(padding: EdgeInsets.all(24), child: Text('No invoices yet.')) : SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Month')), DataColumn(label: Text('Net (Rs)')), DataColumn(label: Text('Paid (Rs)')), DataColumn(label: Text('Status'))], rows: _recentInvoices.map((i) => DataRow(cells: [DataCell(Text((i['month_key'] as String?) ?? '—')), DataCell(Text('${((i['net_amount'] as num?)?.toInt() ?? 0) ~/ 100}')), DataCell(Text('${((i['paid_amount'] as num?)?.toInt() ?? 0) ~/ 100}')), DataCell(Text((i['status'] as String?) ?? '—'))])).toList()))),
        const SizedBox(height: 24),
        Text('Recent Expenses', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Card(child: _recentExpenses.isEmpty ? const Padding(padding: EdgeInsets.all(24), child: Text('No expenses yet.')) : SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Voucher')), DataColumn(label: Text('Amount (Rs)')), DataColumn(label: Text('Note'))], rows: _recentExpenses.map((e) => DataRow(cells: [DataCell(Text((e['voucher_no'] as String?) ?? '—')), DataCell(Text('${((e['amount'] as num?)?.toInt() ?? 0) ~/ 100}')), DataCell(Text((e['note'] as String?) ?? '—'))])).toList()))),
      ]),
    );
  }

  Widget _buildProfitLoss(int net) {
    return SingleChildScrollView(padding: const EdgeInsets.only(bottom: 32), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Profit & Loss Summary', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [
        _plRow('Total Fee Revenue', _money(_totalRevenue)),
        _plRow('Total Expenses', _money(_totalExpenses)),
        const Divider(),
        _plRow('Net (Profit / Loss)', _money(net), bold: true, color: net >= 0 ? Colors.green : Colors.red),
      ]))),
    ]));
  }

  Widget _plRow(String label, String value, {bool bold = false, Color? color}) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [Text(label, style: TextStyle(fontWeight: bold ? FontWeight.bold : null)), Text(value, style: TextStyle(fontWeight: bold ? FontWeight.bold : null, color: color))]));
  }

  Future<void> _exportFeeReportPdf() async {
    final list = _filterFeeReport();
    if (list.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No data to export'))); return; }
    final pdf = pw.Document();
    final dateStr = DateTime.now().toIso8601String().substring(0, 10);
    pdf.addPage(pw.MultiPage(
      header: (ctx) => pw.Padding(padding: const pw.EdgeInsets.only(bottom: 12), child: pw.Column(children: [pw.Text('HubSchool Pro', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)), pw.Text('Student Fee Report', style: pw.TextStyle(fontSize: 14)), pw.Text('Generated: $dateStr', style: const pw.TextStyle(fontSize: 10))])),
      footer: (ctx) => pw.Padding(padding: const pw.EdgeInsets.only(top: 12), child: pw.Center(child: pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}', style: const pw.TextStyle(fontSize: 10)))),
      build: (ctx) => [
        pw.SizedBox(height: 8),
        pw.Table(border: pw.TableBorder.all(), columnWidths: {0: const pw.FlexColumnWidth(1.2), 1: const pw.FlexColumnWidth(2), 2: const pw.FlexColumnWidth(1.5), 3: const pw.FlexColumnWidth(1), 4: const pw.FlexColumnWidth(1), 5: const pw.FlexColumnWidth(1)}, children: [
          pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey300), children: ['Admission No', 'Student', 'Class', 'Billed (Rs)', 'Paid (Rs)', 'Due (Rs)'].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(t, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))).toList()),
          ...list.map((r) => pw.TableRow(children: [(r['admission_no'] as String?) ?? '-', (r['full_name'] as String?) ?? '-', (r['class_name'] as String?) ?? '-', '${(r['billed'] as int? ?? 0) ~/ 100}', '${(r['paid'] as int? ?? 0) ~/ 100}', '${(r['due'] as int? ?? 0) ~/ 100}'].map((c) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(c))).toList())),
        ]),
      ],
    ));
    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  Future<void> _exportMarksheetReportPdf() async {
    final list = _filterMarksReport();
    if (list.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No marks data to export'))); return; }
    final pdf = pw.Document();
    final dateStr = DateTime.now().toIso8601String().substring(0, 10);
    pdf.addPage(pw.MultiPage(
      header: (ctx) => pw.Padding(padding: const pw.EdgeInsets.only(bottom: 12), child: pw.Column(children: [pw.Text('HubSchool Pro', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)), pw.Text('Exam Marksheet Report', style: pw.TextStyle(fontSize: 14)), pw.Text('Generated: $dateStr', style: const pw.TextStyle(fontSize: 10))])),
      footer: (ctx) => pw.Padding(padding: const pw.EdgeInsets.only(top: 12), child: pw.Center(child: pw.Text('Page ${ctx.pageNumber} of ${ctx.pagesCount}', style: const pw.TextStyle(fontSize: 10)))),
      build: (ctx) => [
        pw.SizedBox(height: 8),
        pw.Table(border: pw.TableBorder.all(), columnWidths: {0: const pw.FlexColumnWidth(1.5), 1: const pw.FlexColumnWidth(2), 2: const pw.FlexColumnWidth(1.2), 3: const pw.FlexColumnWidth(1.5), 4: const pw.FlexColumnWidth(0.8), 5: const pw.FlexColumnWidth(0.5)}, children: [
          pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey300), children: ['Exam', 'Student', 'Admission No', 'Component', 'Obtained', 'Max'].map((t) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(t, style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))).toList()),
          ...list.map((r) => pw.TableRow(children: [(r['exam'] as String?) ?? '-', (r['student'] as String?) ?? '-', (r['admission_no'] as String?) ?? '-', (r['component'] as String?) ?? '-', (r['obtained'] as num?)?.toStringAsFixed(1) ?? '-', (r['max_marks'] as int?)?.toString() ?? '-'].map((c) => pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(c))).toList())),
        ]),
      ],
    ));
    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  Widget _buildStudentFeeReport() {
    final list = _filterFeeReport();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Text('Student Fee Report', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))), FilledButton.icon(onPressed: list.isEmpty ? null : _exportFeeReportPdf, icon: const Icon(Icons.picture_as_pdf_rounded), label: const Text('Export PDF'))]),
      const SizedBox(height: 8),
      Expanded(child: Card(child: list.isEmpty ? const Center(child: Text('No data.')) : SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Admission No')), DataColumn(label: Text('Student')), DataColumn(label: Text('Class')), DataColumn(label: Text('Billed (Rs)')), DataColumn(label: Text('Paid (Rs)')), DataColumn(label: Text('Due (Rs)'))], rows: list.map((r) => DataRow(cells: [DataCell(Text((r['admission_no'] as String?) ?? '—')), DataCell(Text((r['full_name'] as String?) ?? '—')), DataCell(Text((r['class_name'] as String?) ?? '—')), DataCell(Text('${(r['billed'] as int? ?? 0) ~/ 100}')), DataCell(Text('${(r['paid'] as int? ?? 0) ~/ 100}')), DataCell(Text('${(r['due'] as int? ?? 0) ~/ 100}'))])).toList())))),
    ]);
  }

  Widget _buildExamMarksheetReport() {
    final list = _filterMarksReport();
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(children: [Expanded(child: Text('Exam Marksheet Report', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))), FilledButton.icon(onPressed: list.isEmpty ? null : _exportMarksheetReportPdf, icon: const Icon(Icons.picture_as_pdf_rounded), label: const Text('Export PDF'))]),
      const SizedBox(height: 8),
      Expanded(child: Card(child: list.isEmpty ? const Center(child: Text('No marks data.')) : SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: const [DataColumn(label: Text('Exam')), DataColumn(label: Text('Student')), DataColumn(label: Text('Admission No')), DataColumn(label: Text('Component')), DataColumn(label: Text('Obtained')), DataColumn(label: Text('Max'))], rows: list.map((r) => DataRow(cells: [DataCell(Text((r['exam'] as String?) ?? '—')), DataCell(Text((r['student'] as String?) ?? '—')), DataCell(Text((r['admission_no'] as String?) ?? '—')), DataCell(Text((r['component'] as String?) ?? '—')), DataCell(Text((r['obtained'] as num?)?.toStringAsFixed(1) ?? '—')), DataCell(Text((r['max_marks'] as int?)?.toString() ?? '—'))])).toList())))),
    ]);
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
