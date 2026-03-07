import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// Invoice detail and print.
class FeeInvoiceDetailPage extends StatefulWidget {
  final int invoiceId;

  const FeeInvoiceDetailPage({super.key, required this.invoiceId});

  @override
  State<FeeInvoiceDetailPage> createState() => _FeeInvoiceDetailPageState();
}

class _FeeInvoiceDetailPageState extends State<FeeInvoiceDetailPage> {
  Map<String, dynamic>? _inv;
  List<Map<String, dynamic>> _lines = [];
  List<Map<String, dynamic>> _paymentHistory = [];
  Map<int, String> _headNames = {};
  Map<String, dynamic>? _student;
  bool _loading = true;
  String? _error;
  final _paymentAmountCtrl = TextEditingController();
  String _paymentMethod = 'cash';
  bool _savingPayment = false;
  static const List<String> _paymentMethods = ['cash', 'bank', 'jazzcash', 'easypaisa', 'other'];

  Future<void> _load() async {
    setState(() { _loading = true; _error = null; });
    try {
      final inv = await Supabase.instance.client.from(SupabaseConfig.tFeeInvoices).select().eq('id', widget.invoiceId).maybeSingle();
      if (inv == null) { if (mounted) setState(() { _loading = false; _error = 'Invoice not found'; }); return; }
      final studentId = inv['student_id'] as int?;
      if (studentId != null) {
        final s = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').eq('id', studentId).maybeSingle();
        if (mounted) setState(() => _student = s != null ? Map<String, dynamic>.from(s) : null);
      }
      final lines = await Supabase.instance.client.from(SupabaseConfig.tFeeInvoiceLines).select().eq('invoice_id', widget.invoiceId);
      final headIds = (lines as List).map((l) => l['fee_head_id']).toSet().toList();
      Map<int, String> headNames = {};
      if (headIds.isNotEmpty) {
        final heads = await Supabase.instance.client.from(SupabaseConfig.tFeeHeads).select('id, name').inFilter('id', headIds);
        for (final h in heads as List) { headNames[h['id'] as int] = h['name'] as String? ?? ''; }
      }
      final allocs = await Supabase.instance.client.from(SupabaseConfig.tFeePaymentAllocs).select().eq('invoice_id', widget.invoiceId).order('id', ascending: false);
      final allocList = List<Map<String, dynamic>>.from(allocs);
      List<Map<String, dynamic>> paymentHistory = [];
      if (allocList.isNotEmpty) {
        final payIds = allocList.map((a) => a['payment_id']).whereType<int>().toSet().toList();
        final payments = await Supabase.instance.client.from(SupabaseConfig.tFeePayments).select().inFilter('id', payIds);
        final payMap = {for (final p in payments as List) p['id']: p};
        for (final a in allocList) {
          final pay = payMap[a['payment_id']];
          paymentHistory.add({'amount': a['amount'], 'method': pay?['method'], 'paid_at': pay?['paid_at'], 'allocation_id': a['id']});
        }
      }
      if (mounted) setState(() { _inv = Map<String, dynamic>.from(inv); _lines = List<Map<String, dynamic>>.from(lines); _headNames = headNames; _paymentHistory = paymentHistory; _loading = false; });
    } catch (e) {
      if (mounted) setState(() { _error = e.toString(); _loading = false; });
    }
  }

  Future<void> _recordPayment() async {
    if (_inv == null) return;
    final amountRs = int.tryParse(_paymentAmountCtrl.text.trim());
    if (amountRs == null || amountRs <= 0) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a valid amount (Rs)'))); return; }
    final amountPaisa = amountRs * 100;
    final due = (_inv!['due_amount'] as num?)?.toInt() ?? 0;
    if (amountPaisa > due) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Amount cannot exceed due amount'))); return; }
    setState(() => _savingPayment = true);
    try {
      final studentId = _inv!['student_id'] as int?;
      if (studentId == null) throw Exception('Invoice has no student');
      final pay = await Supabase.instance.client.from(SupabaseConfig.tFeePayments).insert({
        'student_id': studentId,
        'amount': amountPaisa,
        'method': _paymentMethod,
        'received_by': null,
      }).select('id').single();
      final payId = pay['id'] as int?;
      if (payId != null) {
        await Supabase.instance.client.from(SupabaseConfig.tFeePaymentAllocs).insert({'payment_id': payId, 'invoice_id': widget.invoiceId, 'amount': amountPaisa});
        final paid = (_inv!['paid_amount'] as num?)?.toInt() ?? 0;
        final newPaid = paid + amountPaisa;
        final newDue = due - amountPaisa;
        final status = newDue <= 0 ? 'paid' : 'partial';
        await Supabase.instance.client.from(SupabaseConfig.tFeeInvoices).update({'paid_amount': newPaid, 'due_amount': newDue, 'status': status}).eq('id', widget.invoiceId);
      }
      _paymentAmountCtrl.clear();
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment recorded'))); _load(); }
    } catch (e) {
      if (e.toString().contains('received_by') || e.toString().contains('null')) {
        try {
          final pay = await Supabase.instance.client.from(SupabaseConfig.tFeePayments).insert({'student_id': _inv!['student_id'], 'amount': amountPaisa, 'method': _paymentMethod, 'received_by': 1}).select('id').single();
          final payId = pay['id'] as int?;
          if (payId != null) {
            await Supabase.instance.client.from(SupabaseConfig.tFeePaymentAllocs).insert({'payment_id': payId, 'invoice_id': widget.invoiceId, 'amount': amountPaisa});
            final paid = (_inv!['paid_amount'] as num?)?.toInt() ?? 0;
            final newPaid = paid + amountPaisa;
            final newDue = due - amountPaisa;
            final status = newDue <= 0 ? 'paid' : 'partial';
            await Supabase.instance.client.from(SupabaseConfig.tFeeInvoices).update({'paid_amount': newPaid, 'due_amount': newDue, 'status': status}).eq('id', widget.invoiceId);
          }
          _paymentAmountCtrl.clear();
          if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payment recorded'))); _load(); }
        } catch (e2) {
          if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e2')));
        }
      } else if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _savingPayment = false);
    }
  }

  static String _money(int? paisa) => paisa != null ? 'Rs ${paisa ~/ 100}' : '-';

  Future<void> _printPdf() async {
    if (_inv == null) return;
    final pdf = pw.Document();
    final net = (_inv!['net_amount'] as num?)?.toInt() ?? 0;
    final paid = (_inv!['paid_amount'] as num?)?.toInt() ?? 0;
    final due = (_inv!['due_amount'] as num?)?.toInt() ?? 0;
    final month = _inv!['month_key'] as String? ?? '-';
    final status = _inv!['status'] as String? ?? '-';
    final studentName = _student?['full_name'] as String? ?? '-';
    final admissionNo = _student?['admission_no'] as String? ?? '-';

    pdf.addPage(
      pw.MultiPage(
        build: (ctx) => [
          pw.Header(level: 0, child: pw.Text('Fee Invoice', style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
          pw.Paragraph(text: 'Student: $studentName  |  Admission No: $admissionNo'),
          pw.Paragraph(text: 'Month: $month  |  Status: $status'),
          pw.SizedBox(height: 12),
          pw.Table(
            border: pw.TableBorder.all(),
            columnWidths: {0: const pw.FlexColumnWidth(2), 1: const pw.FlexColumnWidth(1)},
            children: [
              pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey300), children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Description', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Amount (Rs)', style: pw.TextStyle(fontWeight: pw.FontWeight.bold)))]),
              ..._lines.map((l) {
                final hid = l['fee_head_id'] as int?;
                final name = hid != null ? _headNames[hid] : '-';
                final amt = (l['amount'] as num?)?.toInt() ?? 0;
                return pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text(name ?? '-')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${amt ~/ 100}'))]);
              }),
              pw.TableRow(decoration: const pw.BoxDecoration(color: PdfColors.grey200), children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Net', style: pw.TextStyle(fontWeight: pw.FontWeight.bold))), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${net ~/ 100}'))]),
              pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Paid')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${paid ~/ 100}'))]),
              pw.TableRow(children: [pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('Due')), pw.Padding(padding: const pw.EdgeInsets.all(6), child: pw.Text('${due ~/ 100}'))]),
            ],
          ),
        ],
      ),
    );
    await Printing.layoutPdf(onLayout: (_) async => pdf.save());
  }

  @override
  void initState() { super.initState(); _load(); }

  @override
  void dispose() { _paymentAmountCtrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/fees'); })), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _load, child: const Text('Retry'))])));
    if (_inv == null) return const Scaffold(body: Center(child: Text('Not found')));

    final month = _inv!['month_key'] as String? ?? '-';
    final status = _inv!['status'] as String? ?? '-';
    final studentName = _student?['full_name'] as String? ?? '-';
    final admissionNo = _student?['admission_no'] as String? ?? '-';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Invoice'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/fees'); }),
        actions: [IconButton(icon: const Icon(Icons.print_rounded), onPressed: _printPdf)],
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Invoice #${_inv!['id']}', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Student: $studentName', style: Theme.of(context).textTheme.bodyLarge),
                Text('Admission No: $admissionNo'),
                Text('Month: $month'),
                Text('Status: $status'),
                const SizedBox(height: 12),
                Text('Net: ${_money((_inv!['net_amount'] as num?)?.toInt())}  |  Paid: ${_money((_inv!['paid_amount'] as num?)?.toInt())}  |  Due: ${_money((_inv!['due_amount'] as num?)?.toInt())}'),
              ]),
            ),
          ),
          if ((_inv!['due_amount'] as num?)?.toInt() != 0) ...[
            const SizedBox(height: 16),
            Text('Record payment', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(child: TextField(controller: _paymentAmountCtrl, decoration: const InputDecoration(labelText: 'Amount (Rs)', border: OutlineInputBorder()), keyboardType: TextInputType.number)),
                    const SizedBox(width: 12),
                    Expanded(child: DropdownButtonFormField<String>(value: _paymentMethod, decoration: const InputDecoration(labelText: 'Method', border: OutlineInputBorder()), items: _paymentMethods.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(), onChanged: (v) => setState(() => _paymentMethod = v ?? 'cash'))),
                    const SizedBox(width: 12),
                    FilledButton(onPressed: _savingPayment ? null : _recordPayment, child: _savingPayment ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Add payment')),
                  ],
                ),
              ),
            ),
          ],
          if (_paymentHistory.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Payment history', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ..._paymentHistory.map((p) {
              final amt = (p['amount'] as num?)?.toInt();
              final method = p['method'] as String? ?? '-';
              final paidAt = p['paid_at']?.toString();
              final dateStr = paidAt != null && paidAt.length >= 10 ? paidAt.substring(0, 10) : paidAt ?? '-';
              return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text(_money(amt)), subtitle: Text('$method \u2022 $dateStr'), trailing: const Icon(Icons.check_circle_rounded, color: Colors.green)));
            }),
          ],
          const SizedBox(height: 16),
          Text('Lines', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          ..._lines.map((l) {
            final hid = l['fee_head_id'] as int?;
            final name = hid != null ? _headNames[hid] : 'Fee';
            final amt = (l['amount'] as num?)?.toInt() ?? 0;
            return Card(margin: const EdgeInsets.only(bottom: 8), child: ListTile(title: Text(name ?? 'Fee'), trailing: Text(_money(amt))));
          }),
          const SizedBox(height: 24),
          FilledButton.icon(onPressed: _printPdf, icon: const Icon(Icons.picture_as_pdf_rounded), label: const Text('Print / Export PDF')),
        ],
      ),
    );
  }
}
