import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class ResultLine {
  final String subject;
  final double obtained;
  final double maxMarks;
  final double weight;

  const ResultLine({
    required this.subject,
    required this.obtained,
    required this.maxMarks,
    required this.weight,
  });

  double get weightedScore => obtained * weight;
  double get percentage => maxMarks == 0 ? 0 : (obtained / maxMarks) * 100;
}

class ResultCardPdfService {
  Future<void> printResultCard({
    required String schoolName,
    required String schoolAddress,
    required String studentName,
    required String admissionNo,
    required String className,
    required String examTitle,
    required List<ResultLine> lines,
    required String grade,
    required int position,
    required double percentage,
    required String remark,
  }) async {
    final doc = pw.Document();
    final regularFont = await PdfGoogleFonts.poppinsRegular();
    final boldFont = await PdfGoogleFonts.poppinsBold();
    final semiBoldFont = await PdfGoogleFonts.poppinsMedium();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (ctx) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
          children: [
            _buildHeader(schoolName, schoolAddress, boldFont, regularFont),
            pw.SizedBox(height: 16),
            _buildDivider(),
            pw.SizedBox(height: 8),
            pw.Center(
              child: pw.Text(
                examTitle,
                style: pw.TextStyle(font: boldFont, fontSize: 14, color: PdfColors.indigo900),
              ),
            ),
            pw.SizedBox(height: 12),
            _buildStudentInfo(studentName, admissionNo, className, regularFont, semiBoldFont),
            pw.SizedBox(height: 16),
            _buildMarksTable(lines, boldFont, regularFont, semiBoldFont),
            pw.SizedBox(height: 16),
            _buildResultSummary(grade, position, percentage, remark, boldFont, regularFont),
            pw.Spacer(),
            _buildFooter(regularFont),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(
      onLayout: (_) async => doc.save(),
      name: 'Result_Card_$studentName',
    );
  }

  pw.Widget _buildHeader(String name, String address, pw.Font bold, pw.Font regular) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(16),
      decoration: pw.BoxDecoration(
        color: PdfColor.fromHex('3B1FA8'),
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(
            name,
            style: pw.TextStyle(font: bold, fontSize: 22, color: PdfColors.white),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 4),
          pw.Text(
            address,
            style: pw.TextStyle(font: regular, fontSize: 10, color: PdfColors.white),
            textAlign: pw.TextAlign.center,
          ),
          pw.SizedBox(height: 8),
          pw.Container(
            padding: const pw.EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: pw.BoxDecoration(
              color: PdfColors.white,
              borderRadius: pw.BorderRadius.circular(20),
            ),
            child: pw.Text(
              'RESULT CARD',
              style: pw.TextStyle(
                font: bold,
                fontSize: 11,
                color: PdfColor.fromHex('3B1FA8'),
                letterSpacing: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _buildDivider() {
    return pw.Container(height: 2, color: PdfColor.fromHex('3B1FA8'));
  }

  pw.Widget _buildStudentInfo(
    String name,
    String admNo,
    String className,
    pw.Font regular,
    pw.Font semiBold,
  ) {
    return pw.Container(
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: PdfColors.indigo50,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Row(
        children: [
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _infoRow('Student Name', name, regular, semiBold),
                pw.SizedBox(height: 4),
                _infoRow('Admission No', admNo, regular, semiBold),
              ],
            ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                _infoRow('Class', className, regular, semiBold),
                pw.SizedBox(height: 4),
                _infoRow(
                  'Date',
                  '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  regular,
                  semiBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _infoRow(String label, String value, pw.Font regular, pw.Font semiBold) {
    return pw.Row(
      children: [
        pw.Text('$label: ', style: pw.TextStyle(font: regular, fontSize: 10, color: PdfColors.grey700)),
        pw.Text(value, style: pw.TextStyle(font: semiBold, fontSize: 10)),
      ],
    );
  }

  pw.Widget _buildMarksTable(
    List<ResultLine> lines,
    pw.Font bold,
    pw.Font regular,
    pw.Font semiBold,
  ) {
    final headerStyle = pw.TextStyle(font: bold, fontSize: 10, color: PdfColors.white);
    final cellStyle = pw.TextStyle(font: regular, fontSize: 10);
    final totalObtained = lines.fold<double>(0, (s, l) => s + l.obtained);
    final totalMax = lines.fold<double>(0, (s, l) => s + l.maxMarks);
    final totalPercent = totalMax == 0 ? 0.0 : (totalObtained / totalMax) * 100;

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300),
      columnWidths: {
        0: const pw.FlexColumnWidth(3),
        1: const pw.FlexColumnWidth(1.5),
        2: const pw.FlexColumnWidth(1.5),
        3: const pw.FlexColumnWidth(1.5),
      },
      children: [
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColor.fromHex('3B1FA8')),
          children: [
            _th('Subject', headerStyle),
            _th('Obtained', headerStyle, align: pw.TextAlign.center),
            _th('Max Marks', headerStyle, align: pw.TextAlign.center),
            _th('Percentage', headerStyle, align: pw.TextAlign.center),
          ],
        ),
        ...lines.asMap().entries.map((e) {
          final line = e.value;
          final isEven = e.key % 2 == 0;
          return pw.TableRow(
            decoration: pw.BoxDecoration(
              color: isEven ? PdfColors.white : PdfColors.indigo50,
            ),
            children: [
              _td(line.subject, cellStyle),
              _td(line.obtained.toStringAsFixed(1), cellStyle, align: pw.TextAlign.center),
              _td(line.maxMarks.toStringAsFixed(1), cellStyle, align: pw.TextAlign.center),
              _td('${line.percentage.toStringAsFixed(1)}%', cellStyle, align: pw.TextAlign.center),
            ],
          );
        }),
        pw.TableRow(
          decoration: pw.BoxDecoration(color: PdfColor.fromHex('EEF2FF')),
          children: [
            _td('TOTAL', pw.TextStyle(font: bold, fontSize: 10)),
            _td(totalObtained.toStringAsFixed(1), pw.TextStyle(font: bold, fontSize: 10), align: pw.TextAlign.center),
            _td(totalMax.toStringAsFixed(1), pw.TextStyle(font: bold, fontSize: 10), align: pw.TextAlign.center),
            _td('${totalPercent.toStringAsFixed(2)}%', pw.TextStyle(font: bold, fontSize: 10), align: pw.TextAlign.center),
          ],
        ),
      ],
    );
  }

  pw.Widget _th(String text, pw.TextStyle style, {pw.TextAlign? align}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(text, style: style, textAlign: align ?? pw.TextAlign.left),
    );
  }

  pw.Widget _td(String text, pw.TextStyle style, {pw.TextAlign? align}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: pw.Text(text, style: style, textAlign: align ?? pw.TextAlign.left),
    );
  }

  pw.Widget _buildResultSummary(
    String grade,
    int position,
    double percentage,
    String remark,
    pw.Font bold,
    pw.Font regular,
  ) {
    return pw.Row(
      children: [
        _summaryBox('Grade', grade, PdfColor.fromHex('3B1FA8'), bold, regular),
        pw.SizedBox(width: 12),
        _summaryBox('Position', '#$position', PdfColor.fromHex('0891B2'), bold, regular),
        pw.SizedBox(width: 12),
        _summaryBox('Percentage', '${percentage.toStringAsFixed(1)}%', PdfColor.fromHex('059669'), bold, regular),
        pw.SizedBox(width: 12),
        pw.Expanded(
          child: pw.Container(
            padding: const pw.EdgeInsets.all(12),
            decoration: pw.BoxDecoration(
              color: PdfColors.amber50,
              borderRadius: pw.BorderRadius.circular(8),
              border: pw.Border.all(color: PdfColors.amber300),
            ),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Remark', style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.grey600)),
                pw.Text(remark, style: pw.TextStyle(font: bold, fontSize: 11)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _summaryBox(String label, String value, PdfColor color, pw.Font bold, pw.Font regular) {
    return pw.Container(
      width: 80,
      padding: const pw.EdgeInsets.all(12),
      decoration: pw.BoxDecoration(
        color: color,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Text(value, style: pw.TextStyle(font: bold, fontSize: 18, color: PdfColors.white),
              textAlign: pw.TextAlign.center),
          pw.Text(label, style: pw.TextStyle(font: regular, fontSize: 9, color: PdfColors.white),
              textAlign: pw.TextAlign.center),
        ],
      ),
    );
  }

  pw.Widget _buildFooter(pw.Font regular) {
    return pw.Row(
      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
      children: [
        pw.Text(
          'Generated by HubSchool Pro',
          style: pw.TextStyle(font: regular, fontSize: 8, color: PdfColors.grey500),
        ),
        pw.Text(
          'Principal Signature: ___________________',
          style: pw.TextStyle(font: regular, fontSize: 9),
        ),
      ],
    );
  }
}
