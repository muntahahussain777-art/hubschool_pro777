import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class SalarySlipPdfService {
  Future<void> printSalarySlip({
    required String schoolName,
    required String employeeName,
    required String designation,
    required String monthKey,
    required int grossSalary,
    required int advanceDeduction,
    required int absentDeduction,
    required int netSalary,
    required int daysPresent,
    required int totalDays,
  }) async {
    final doc = pw.Document();
    final boldFont = await PdfGoogleFonts.poppinsBold();
    final regular = await PdfGoogleFonts.poppinsRegular();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            pw.Container(
              padding: const pw.EdgeInsets.all(16),
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('1F2937'),
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text(schoolName,
                          style: pw.TextStyle(font: boldFont, fontSize: 20, color: PdfColors.white)),
                      pw.Text('Salary Slip',
                          style: pw.TextStyle(font: regular, fontSize: 12, color: PdfColors.white)),
                    ],
                  ),
                  pw.Text(monthKey,
                      style: pw.TextStyle(font: boldFont, fontSize: 14, color: PdfColors.white)),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(
                color: PdfColors.grey100,
                borderRadius: pw.BorderRadius.circular(8),
              ),
              child: pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Employee Name',
                            style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.grey600)),
                        pw.Text(employeeName,
                            style: pw.TextStyle(font: boldFont, fontSize: 13)),
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text('Designation',
                            style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.grey600)),
                        pw.Text(designation, style: pw.TextStyle(font: boldFont, fontSize: 13)),
                      ],
                    ),
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.end,
                    children: [
                      pw.Text('Attendance',
                          style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.grey600)),
                      pw.Text('$daysPresent / $totalDays days',
                          style: pw.TextStyle(font: boldFont, fontSize: 13)),
                    ],
                  ),
                ],
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey300),
              children: [
                _tableHeader(['Description', 'Amount (Rs)'], boldFont),
                _tableRow('Gross Salary', 'Rs $grossSalary', regular),
                _tableRow('Absent Deduction', '- Rs $absentDeduction', regular, isNeg: true),
                _tableRow('Advance Deduction', '- Rs $advanceDeduction', regular, isNeg: true),
              ],
            ),
            pw.SizedBox(height: 0),
            pw.Container(
              padding: const pw.EdgeInsets.all(14),
              decoration: pw.BoxDecoration(color: PdfColor.fromHex('3B1FA8')),
              child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('NET PAY',
                      style: pw.TextStyle(font: boldFont, fontSize: 14, color: PdfColors.white)),
                  pw.Text('Rs $netSalary',
                      style: pw.TextStyle(font: boldFont, fontSize: 18, color: PdfColors.white)),
                ],
              ),
            ),
            pw.Spacer(),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('Employee Signature: _______________',
                    style: pw.TextStyle(font: regular, fontSize: 10)),
                pw.Text('Authorized Signature: _______________',
                    style: pw.TextStyle(font: regular, fontSize: 10)),
              ],
            ),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
      name: 'Salary_Slip_${employeeName}_$monthKey',
    );
  }

  pw.TableRow _tableHeader(List<String> headers, pw.Font bold) {
    return pw.TableRow(
      decoration: pw.BoxDecoration(color: PdfColors.grey200),
      children: headers
          .map((h) => pw.Padding(
                padding: const pw.EdgeInsets.all(8),
                child: pw.Text(h, style: pw.TextStyle(font: bold, fontSize: 10)),
              ))
          .toList(),
    );
  }

  pw.TableRow _tableRow(String label, String value, pw.Font regular, {bool isNeg = false}) {
    return pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(label, style: pw.TextStyle(font: regular, fontSize: 10)),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            value,
            style: pw.TextStyle(
              font: regular,
              fontSize: 10,
              color: isNeg ? PdfColors.red700 : PdfColors.black,
            ),
            textAlign: pw.TextAlign.right,
          ),
        ),
      ],
    );
  }
}
