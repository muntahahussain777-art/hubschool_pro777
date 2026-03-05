import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/utils/formatters.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../../../services/print/bluetooth_printer_service.dart';
import '../application/fee_payment_controller.dart';

class CollectPaymentSheet extends ConsumerStatefulWidget {
  final Student student;
  final List<FeeInvoice> invoices;

  const CollectPaymentSheet({
    super.key,
    required this.student,
    required this.invoices,
  });

  @override
  ConsumerState<CollectPaymentSheet> createState() => _CollectPaymentSheetState();
}

class _CollectPaymentSheetState extends ConsumerState<CollectPaymentSheet> {
  final _amountCtrl = TextEditingController();
  final _refCtrl = TextEditingController();
  String _method = 'cash';
  FeeInvoice? _selectedInvoice;

  @override
  void initState() {
    super.initState();
    if (widget.invoices.isNotEmpty) {
      _selectedInvoice = widget.invoices.first;
      _amountCtrl.text = (_selectedInvoice!.dueAmount ~/ 100).toString();
    }
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _refCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(feePaymentControllerProvider);

    ref.listen(feePaymentControllerProvider, (prev, next) {
      if (next.successMessage != null) {
        _autoPrintIfConnected();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.successMessage!),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.pop(context);
      }
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    });

    return Padding(
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40, height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(color: AppColors.cardBorder, borderRadius: BorderRadius.circular(2)),
            ),
          ),
          Text(
            'Collect Payment',
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700),
          ),
          Text(
            widget.student.fullName,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          const SizedBox(height: 20),

          // Invoice selector
          const Text('Select Invoice', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.cardBorder),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<FeeInvoice>(
                value: _selectedInvoice,
                isExpanded: true,
                dropdownColor: AppColors.card,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 13),
                items: widget.invoices.map((inv) {
                  return DropdownMenuItem(
                    value: inv,
                    child: Text(
                      '${Fmt.monthLabel(inv.monthKey)} · Due: ${Fmt.moneyInt(inv.dueAmount ~/ 100)}',
                    ),
                  );
                }).toList(),
                onChanged: (inv) {
                  if (inv == null) return;
                  setState(() {
                    _selectedInvoice = inv;
                    _amountCtrl.text = (inv.dueAmount ~/ 100).toString();
                  });
                },
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Amount
          TextField(
            controller: _amountCtrl,
            keyboardType: TextInputType.number,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Amount (Rs)',
              prefixIcon: Icon(Icons.payments_rounded, color: AppColors.success, size: 20),
            ),
          ),
          const SizedBox(height: 14),

          // Payment method
          const Text('Payment Method', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: AppConstants.paymentMethods.map((m) {
              return ChoiceChip(
                label: Text(m.toUpperCase()),
                selected: _method == m,
                onSelected: (_) => setState(() => _method = m),
                selectedColor: AppColors.primary.withOpacity(0.3),
                backgroundColor: AppColors.card,
                labelStyle: TextStyle(
                  color: _method == m ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                ),
                side: BorderSide(
                  color: _method == m ? AppColors.primary : AppColors.cardBorder,
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 14),

          if (_method != 'cash')
            TextField(
              controller: _refCtrl,
              style: const TextStyle(color: AppColors.textPrimary),
              decoration: const InputDecoration(
                labelText: 'Reference / Transaction No',
                prefixIcon: Icon(Icons.receipt_rounded, color: AppColors.primary, size: 20),
              ),
            ),

          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: OutlinedButton.icon(
              onPressed: _showPrinterDialog,
              icon: const Icon(Icons.print_rounded, size: 18),
              label: const Text('Print Setup'),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
            )),
            const SizedBox(width: 12),
            Expanded(flex: 2, child: SizedBox(
              height: 52,
              child: ElevatedButton(
                onPressed: state.loading ? null : _submit,
                child: state.loading
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                    : const Text('Confirm Payment'),
              ),
            )),
          ]),
        ],
      ),
    );
  }

  void _showPrinterDialog() async {
    final devices = await BluetoothPrinterService.getBondedDevices();
    if (!mounted) return;
    if (devices.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('No Bluetooth printer found. Pair printer in Settings.')));
      return;
    }
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Select Printer', style: TextStyle(color: AppColors.textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 16),
          ...devices.map((d) => ListTile(
            leading: const Icon(Icons.print_rounded, color: AppColors.primary),
            title: Text(d.name ?? 'Unknown', style: const TextStyle(color: AppColors.textPrimary)),
            subtitle: Text(d.address ?? '', style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
            onTap: () async {
              final ok = await BluetoothPrinterService.connect(d);
              if (mounted) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(ok ? 'Connected: ${d.name}' : 'Connection failed'), backgroundColor: ok ? AppColors.success : AppColors.error));
              }
            },
          )),
        ]),
      ),
    );
  }

  Future<void> _autoPrintIfConnected() async {
    final connected = await BluetoothPrinterService.isConnected;
    if (!connected || _selectedInvoice == null) return;
    final inv = _selectedInvoice!;
    final paid = int.tryParse(_amountCtrl.text.trim()) ?? (inv.paidAmount ~/ 100);
    final due = (inv.netAmount ~/ 100) - paid;
    await BluetoothPrinterService.printFeeReceipt(
      schoolName: 'HubSchool Pro',
      receiptNo: 'INV-${inv.id}',
      studentName: widget.student.fullName,
      className: '-',
      paidAmountRs: paid,
      dueAmountRs: due > 0 ? due : 0,
      totalAmountRs: (inv.netAmount ~/ 100),
      paidAt: DateTime.now(),
      paymentMethod: _method,
    );
  }

  void _submit() {
    if (_selectedInvoice == null) return;
    final amount = int.tryParse(_amountCtrl.text.trim());
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter a valid amount'), backgroundColor: AppColors.error),
      );
      return;
    }
    ref.read(feePaymentControllerProvider.notifier).collectPayment(
          studentId: widget.student.id,
          invoiceId: _selectedInvoice!.id,
          amount: amount * 100, // to paisa
          userId: 1,
          method: _method,
          referenceNo: _refCtrl.text.trim().isEmpty ? null : _refCtrl.text.trim(),
        );
  }
}
