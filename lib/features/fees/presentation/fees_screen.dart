import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../application/fee_payment_controller.dart';
import 'collect_payment_sheet.dart';

class FeesScreen extends ConsumerStatefulWidget {
  const FeesScreen({super.key});
  @override
  ConsumerState<FeesScreen> createState() => _FeesScreenState();
}

class _FeesScreenState extends ConsumerState<FeesScreen> {
  List<Student> _students = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    try {
      final dao = ref.read(studentsDaoProvider);
      final list = await dao.getAllStudents();
      if (mounted) setState(() { _students = list.where((s) => s.isActive).toList(); _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fee Management')),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
          : _students.isEmpty
              ? const Center(child: Text('No students found\nAdd students first', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted)))
              : RefreshIndicator(
                  onRefresh: _loadStudents,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _students.length,
                    itemBuilder: (_, i) => _StudentFeeCard(student: _students[i], index: i),
                  ),
                ),
    );
  }
}

class _StudentFeeCard extends ConsumerWidget {
  final Student student;
  final int index;
  const _StudentFeeCard({required this.student, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fee = student.monthlyFee;
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: () => _showFeeDetail(context, ref),
      child: Row(children: [
        Container(
          width: 46, height: 46,
          decoration: BoxDecoration(color: AppColors.success.withOpacity(0.2), borderRadius: BorderRadius.circular(14)),
          child: Center(child: Text(student.fullName.substring(0, 1).toUpperCase(), style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.w700, fontSize: 18))),
        ),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(student.fullName, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, fontWeight: FontWeight.w600)),
          Text(student.admissionNo, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
        ])),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(fee > 0 ? 'Rs ${fee ~/ 100}/mo' : 'No fee set', style: TextStyle(color: fee > 0 ? AppColors.primary : AppColors.textMuted, fontSize: 13, fontWeight: FontWeight.w700)),
          const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted, size: 18),
        ]),
      ]),
    ).animate(delay: Duration(milliseconds: index * 50)).fadeIn(duration: 300.ms).slideX(begin: -0.05);
  }

  void _showFeeDetail(BuildContext context, WidgetRef ref) {
    final invoicesAsync = ref.read(studentInvoicesProvider(student.id));
    showModalBottomSheet(
      context: context, backgroundColor: AppColors.surface, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => _FeeDetailSheet(student: student),
    );
  }
}

class _FeeDetailSheet extends ConsumerStatefulWidget {
  final Student student;
  const _FeeDetailSheet({required this.student});
  @override
  ConsumerState<_FeeDetailSheet> createState() => _FeeDetailSheetState();
}

class _FeeDetailSheetState extends ConsumerState<_FeeDetailSheet> {
  List<FeeInvoice> _invoices = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final dao = ref.read(feesDaoProvider);
      final db = ref.read(schoolDatabaseProvider);
      final rows = await (db.select(db.feeInvoices)..where((i) => i.studentId.equals(widget.student.id))..orderBy([(i) => OrderingTerm.desc(i.createdAt)])).get();
      if (mounted) setState(() { _invoices = rows; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.8, minChildSize: 0.5, maxChildSize: 0.95, expand: false,
      builder: (_, ctrl) => Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(2))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
          child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(widget.student.fullName, style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
              Text('Monthly: Rs ${widget.student.monthlyFee ~/ 100}', style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
            ])),
            Row(children: [
              OutlinedButton.icon(
                onPressed: () => _sendDuesReminder(context),
                icon: const Icon(Icons.notifications_active_rounded, size: 16),
                label: const Text('Reminder', style: TextStyle(fontSize: 11)),
                style: OutlinedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8), side: const BorderSide(color: AppColors.primary)),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: () => _generateInvoice(context),
                icon: const Icon(Icons.add_card_rounded, size: 16),
                label: const Text('Generate Invoice', style: TextStyle(fontSize: 11)),
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
              ),
            ]),
          ]),
        ),
        Expanded(
          child: _loading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : _invoices.isEmpty
                  ? const Center(child: Text('No invoices yet\nTap "Generate Invoice"', textAlign: TextAlign.center, style: TextStyle(color: AppColors.textMuted)))
                  : ListView.separated(
                      controller: ctrl, padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _invoices.length, separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (_, i) => _InvoiceTile(
                        invoice: _invoices[i],
                        student: widget.student,
                        onPaymentDone: _load,
                      ),
                    ),
        ),
      ]),
    );
  }

  Future<void> _generateInvoice(BuildContext context) async {
    final fee = widget.student.monthlyFee;
    if (fee <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student ki fee set nahi hai'), backgroundColor: AppColors.warning));
      return;
    }
    final now = DateTime.now();
    int year = now.year;
    int month = now.month;
    final picked = await showModalBottomSheet<DateTime>(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (_) => _MonthPickerSheet(selected: DateTime(year, month)));
    if (picked == null) return;
    year = picked.year;
    month = picked.month;
    final monthKey = '${year}-${month.toString().padLeft(2, '0')}';
    try {
      final dao = ref.read(feesDaoProvider);
      final db = ref.read(schoolDatabaseProvider);
      final existing = await (db.select(db.feeInvoices)..where((i) => i.studentId.equals(widget.student.id) & i.monthKey.equals(monthKey))).get();
      if (existing.isNotEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${Fmt.monthLabel(monthKey)} ka invoice pehle se hai'), backgroundColor: AppColors.warning, behavior: SnackBarBehavior.floating));
        return;
      }
      await dao.createInvoice(FeeInvoicesCompanion.insert(
        studentId: widget.student.id,
        monthKey: monthKey,
        totalAmount: fee,
        netAmount: fee,
        dueAmount: fee,
        dueDate: Value(DateTime(year, month, 10)),
      ));
      await _load();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Invoice generated for ${Fmt.monthLabel(monthKey)}'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }

  Future<void> _sendDuesReminder(BuildContext context) async {
    final phone = widget.student.phone;
    if (phone == null || phone.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student ka phone number add karein'), backgroundColor: AppColors.warning));
      return;
    }
    final invoices = await ref.read(feesDaoProvider).watchStudentInvoices(widget.student.id).first;
    final unpaid = invoices.where((i) => i.status != 'paid').toList();
    if (unpaid.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Koi dues nahi hai'), backgroundColor: AppColors.success));
      return;
    }
    final totalDue = unpaid.fold<int>(0, (s, i) => s + i.dueAmount);
    final msg = Uri.encodeComponent(
      'Assalam-o-Alaikum!\n\n${widget.student.fullName} (Adm: ${widget.student.admissionNo}) ki fee dues: Rs ${totalDue ~/ 100}\n\nPlease pay at your earliest. Thank you.\n- HubSchool Pro',
    );
    final ph = phone.replaceAll(RegExp(r'[^\d]'), '');
    final waNum = ph.startsWith('0') ? '92${ph.substring(1)}' : (ph.length == 10 ? '92$ph' : ph);
    final url = Uri.parse('https://wa.me/$waNum?text=$msg');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('WhatsApp open nahi ho sakta'), backgroundColor: AppColors.error));
    }
  }
}

class _InvoiceTile extends ConsumerWidget {
  final FeeInvoice invoice;
  final Student student;
  final VoidCallback onPaymentDone;
  const _InvoiceTile({required this.invoice, required this.student, required this.onPaymentDone});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statusColor = {'paid': AppColors.success, 'partial': AppColors.warning, 'unpaid': AppColors.error}[invoice.status] ?? AppColors.textMuted;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(14), border: Border.all(color: AppColors.cardBorder)),
      child: Column(children: [
        Row(children: [
          Text(Fmt.monthLabel(invoice.monthKey), style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
          const Spacer(),
          IconButton(icon: const Icon(Icons.edit_rounded, color: AppColors.primary, size: 20), onPressed: () => _showEditInvoice(context, ref), padding: EdgeInsets.zero, constraints: const BoxConstraints()),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
            decoration: BoxDecoration(color: statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
            child: Text(invoice.status.toUpperCase(), style: TextStyle(color: statusColor, fontSize: 10, fontWeight: FontWeight.w700)),
          ),
        ]),
        const Divider(height: 16),
        Row(children: [
          _amountCol('Total', invoice.netAmount, AppColors.textSecondary),
          _amountCol('Paid', invoice.paidAmount, AppColors.success),
          _amountCol('Due', invoice.dueAmount, AppColors.error),
        ]),
        if (invoice.status != 'paid') ...[
          const SizedBox(height: 10),
          Row(children: [
            Expanded(child: SizedBox(height: 36, child: ElevatedButton(
              style: ElevatedButton.styleFrom(padding: EdgeInsets.zero, backgroundColor: AppColors.success),
              onPressed: () {
                showModalBottomSheet(
                  context: context, backgroundColor: AppColors.surface, isScrollControlled: true,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
                  builder: (_) => CollectPaymentSheet(student: student, invoices: [invoice]),
                ).then((_) => onPaymentDone());
              },
              child: const Text('Collect Payment', style: TextStyle(fontSize: 12)),
            ))),
            const SizedBox(width: 8),
            IconButton(icon: const Icon(Icons.print_rounded, color: AppColors.primary, size: 20), onPressed: () => _printReceipt(context, ref)),
          ]),
        ],
      ]),
    );
  }

  void _showEditInvoice(BuildContext context, WidgetRef ref) async {
    DateTime? dueDate = invoice.dueDate;
    final picked = await showDatePicker(context: context, initialDate: dueDate ?? DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030), builder: (c, child) => Theme(data: Theme.of(c).copyWith(colorScheme: const ColorScheme.dark(primary: AppColors.primary)), child: child!));
    if (picked == null) return;
    try {
      final db = ref.read(schoolDatabaseProvider);
      await (db.update(db.feeInvoices)..where((i) => i.id.equals(invoice.id))).write(FeeInvoicesCompanion(dueDate: Value(picked)));
      onPaymentDone();
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invoice updated'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }

  void _printReceipt(BuildContext context, WidgetRef ref) {
    // Thermal print - will integrate with CollectPaymentSheet
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Print from Collect Payment'), backgroundColor: AppColors.primary, behavior: SnackBarBehavior.floating));
  }

  Widget _amountCol(String label, int amount, Color color) {
    return Expanded(child: Column(children: [
      Text('Rs ${amount ~/ 100}', style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.w700)),
      Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 10)),
    ]));
  }
}

class _MonthPickerSheet extends StatelessWidget {
  final DateTime selected;
  const _MonthPickerSheet({required this.selected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('Select Month', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: _YearMonthSelector(selected: selected, onChanged: (v) => Navigator.pop(context, v))),
        ]),
        const SizedBox(height: 20),
        SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context, selected), child: const Text('Generate'))),
      ]),
    );
  }
}

class _YearMonthSelector extends StatefulWidget {
  final DateTime selected;
  final ValueChanged<DateTime> onChanged;

  const _YearMonthSelector({required this.selected, required this.onChanged});

  @override
  State<_YearMonthSelector> createState() => _YearMonthSelectorState();
}

class _YearMonthSelectorState extends State<_YearMonthSelector> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    _year = widget.selected.year;
    _month = widget.selected.month;
  }

  @override
  Widget build(BuildContext context) {
    final months = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text('Year', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
      const SizedBox(height: 4),
      Row(children: [
        IconButton(icon: const Icon(Icons.chevron_left, color: AppColors.primary), onPressed: () => setState(() => _year--)),
        Expanded(child: Center(child: Text('$_year', style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)))),
        IconButton(icon: const Icon(Icons.chevron_right, color: AppColors.primary), onPressed: () => setState(() => _year++)),
      ]),
      const SizedBox(height: 12),
      const Text('Month', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
      const SizedBox(height: 4),
      Wrap(spacing: 8, runSpacing: 8, children: List.generate(12, (i) {
        final selected = _month == i + 1;
        return GestureDetector(
          onTap: () => setState(() => _month = i + 1),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? AppColors.primary : AppColors.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: selected ? AppColors.primary : AppColors.cardBorder),
            ),
            child: Text(months[i], style: TextStyle(color: selected ? Colors.white : AppColors.textSecondary, fontSize: 12, fontWeight: selected ? FontWeight.w600 : FontWeight.w400)),
          ),
        );
      })),
      const SizedBox(height: 16),
      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => widget.onChanged(DateTime(_year, _month)), child: const Text('Select'))),
    ]);
  }
}
