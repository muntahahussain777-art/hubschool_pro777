import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';

class ThermalReceiptService {
  Future<List<int>> buildFeeReceipt({
    required String schoolName,
    required String receiptNo,
    required String studentName,
    required String className,
    required int paidAmountRs,
    required int dueAmountRs,
    required int totalAmountRs,
    required DateTime paidAt,
    required String paymentMethod,
    bool is80mm = false,
  }) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(
      is80mm ? PaperSize.mm80 : PaperSize.mm58,
      profile,
    );

    final bytes = <int>[];

    bytes.addAll(generator.reset());
    bytes.addAll(generator.text(
      schoolName,
      styles: const PosStyles(
        align: PosAlign.center,
        bold: true,
        height: PosTextSize.size2,
        width: PosTextSize.size2,
      ),
    ));
    bytes.addAll(generator.text(
      'FEE RECEIPT',
      styles: const PosStyles(align: PosAlign.center, bold: true),
    ));
    bytes.addAll(generator.hr());

    bytes.addAll(generator.row([
      PosColumn(text: 'Receipt:', width: 5, styles: const PosStyles(bold: false)),
      PosColumn(text: receiptNo, width: 7, styles: const PosStyles(bold: true)),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Student:', width: 5),
      PosColumn(text: studentName, width: 7, styles: const PosStyles(bold: true)),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Class:', width: 5),
      PosColumn(text: className, width: 7),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Date:', width: 5),
      PosColumn(
        text: '${paidAt.day}/${paidAt.month}/${paidAt.year}',
        width: 7,
      ),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Method:', width: 5),
      PosColumn(text: paymentMethod.toUpperCase(), width: 7),
    ]));
    bytes.addAll(generator.hr());

    bytes.addAll(generator.row([
      PosColumn(text: 'Total Due', width: 7),
      PosColumn(
        text: 'Rs $totalAmountRs',
        width: 5,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Amount Paid', width: 7, styles: const PosStyles(bold: true)),
      PosColumn(
        text: 'Rs $paidAmountRs',
        width: 5,
        styles: const PosStyles(align: PosAlign.right, bold: true),
      ),
    ]));
    bytes.addAll(generator.row([
      PosColumn(text: 'Remaining Due', width: 7),
      PosColumn(
        text: 'Rs $dueAmountRs',
        width: 5,
        styles: PosStyles(
          align: PosAlign.right,
          bold: dueAmountRs > 0,
        ),
      ),
    ]));
    bytes.addAll(generator.hr());

    if (dueAmountRs == 0) {
      bytes.addAll(generator.text(
        '*** PAID IN FULL ***',
        styles: const PosStyles(align: PosAlign.center, bold: true),
      ));
    } else {
      bytes.addAll(generator.text(
        'PARTIAL PAYMENT',
        styles: const PosStyles(align: PosAlign.center),
      ));
    }

    bytes.addAll(generator.feed(1));
    bytes.addAll(generator.text(
      'Thank you!',
      styles: const PosStyles(align: PosAlign.center),
    ));
    bytes.addAll(generator.text(
      'Powered by HubSchool Pro',
      styles: const PosStyles(align: PosAlign.center),
    ));
    bytes.addAll(generator.feed(2));
    bytes.addAll(generator.cut());

    return bytes;
  }
}
