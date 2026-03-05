import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

enum _ScanMode { document, cnic }

class _ScannerScreenState extends State<ScannerScreen> {
  final _picker = ImagePicker();
  final List<File> _images = [];
  final List<String> _labels = []; // 'Front', 'Back', or page number
  bool _loading = false;
  _ScanMode _mode = _ScanMode.document;

  Future<void> _capture({String? label}) async {
    setState(() => _loading = true);
    try {
      final x = await _picker.pickImage(source: ImageSource.camera, imageQuality: 95);
      if (x != null) {
        final bytes = await File(x.path).readAsBytes();
        var decoded = img.decodeImage(bytes);
        if (decoded != null) {
          if (_mode == _ScanMode.cnic) {
            const ratio = 85.6 / 53.98;
            int cw = decoded.width, ch = decoded.height;
            int x = 0, y = 0;
            if (cw / ch > ratio) {
              cw = (ch * ratio).round();
              x = (decoded.width - cw) ~/ 2;
            } else {
              ch = (cw / ratio).round();
              y = (decoded.height - ch) ~/ 2;
            }
            decoded = img.copyCrop(decoded, x: x, y: y, width: cw, height: ch);
            decoded = img.copyResize(decoded, width: 400, height: (400 / ratio).round());
          } else {
            decoded = img.adjustColor(decoded, contrast: 1.05, brightness: 1.02);
          }
          final dir = await getTemporaryDirectory();
          final outPath = '${dir.path}/scan_${DateTime.now().millisecondsSinceEpoch}.png';
          await File(outPath).writeAsBytes(img.encodePng(decoded));
          if (mounted) {
            setState(() {
              _images.add(File(outPath));
              _labels.add(label ?? 'Page ${_images.length}');
            });
          }
        } else {
          if (mounted) setState(() {
            _images.add(File(x.path));
            _labels.add(label ?? 'Page ${_images.length}');
          });
        }
      }
    } catch (e) {
      if (mounted && _images.isEmpty) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _saveAsPdf() async {
    if (_images.isEmpty) return;
    setState(() => _loading = true);
    try {
      final pdf = pw.Document();
      for (final f in _images) {
        final bytes = await f.readAsBytes();
        final pdfImg = pw.MemoryImage(bytes);
        pdf.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (ctx) => pw.Padding(
            padding: const pw.EdgeInsets.all(24),
            child: pw.Center(child: pw.Image(pdfImg, fit: pw.BoxFit.contain)),
          ),
        ));
      }
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/scan_${DateTime.now().millisecondsSinceEpoch}.pdf');
      await file.writeAsBytes(await pdf.save());
      await Share.shareXFiles([XFile(file.path)], text: 'Scanned Document');
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF saved'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _removeImage(int i) {
    setState(() {
      _images.removeAt(i);
      if (i < _labels.length) _labels.removeAt(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Document Scanner'),
        actions: [
          SegmentedButton<_ScanMode>(
            segments: const [
              ButtonSegment(value: _ScanMode.document, label: Text('Document'), icon: Icon(Icons.description_rounded, size: 18)),
              ButtonSegment(value: _ScanMode.cnic, label: Text('CNIC'), icon: Icon(Icons.badge_rounded, size: 18)),
            ],
            selected: {_mode},
            onSelectionChanged: (s) => setState(() => _mode = s.first),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 8, vertical: 4)),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(children: [
        Row(children: [
          if (_mode == _ScanMode.cnic) ...[
            Expanded(child: Padding(
              padding: const EdgeInsets.all(12),
              child: ElevatedButton.icon(
                onPressed: _loading ? null : () => _capture(label: 'CNIC Front'),
                icon: const Icon(Icons.badge_rounded, size: 20),
                label: const Text('Front'),
              ),
            )),
            Expanded(child: Padding(
              padding: const EdgeInsets.all(12),
              child: OutlinedButton.icon(
                onPressed: _loading ? null : () => _capture(label: 'CNIC Back'),
                icon: const Icon(Icons.flip_rounded, size: 20),
                label: const Text('Back'),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
              ),
            )),
          ] else
            Expanded(child: Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton.icon(
                onPressed: _loading ? null : () => _capture(),
                icon: const Icon(Icons.document_scanner_rounded),
                label: const Text('Scan (Auto Enhance)'),
              ),
            )),
          if (_images.isNotEmpty)
            Expanded(child: Padding(
              padding: const EdgeInsets.all(16),
              child: OutlinedButton.icon(
                onPressed: _loading ? null : _saveAsPdf,
                icon: const Icon(Icons.picture_as_pdf_rounded),
                label: const Text('Save PDF'),
                style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)),
              ),
            )),
        ]),
        if (_loading) const LinearProgressIndicator(color: AppColors.primary),
        Expanded(
          child: _images.isEmpty
              ? const Center(child: Text('Scan to add pages', style: TextStyle(color: AppColors.textMuted)))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _images.length,
                  itemBuilder: (_, i) => Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.cardBorder)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (i < _labels.length)
                              Padding(
                                padding: const EdgeInsets.fromLTRB(12, 8, 8, 4),
                                child: Text(_labels[i], style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.w600)),
                              ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(_images[i], fit: BoxFit.contain, height: 200),
                            ),
                          ],
                        ),
                      ),
                      Positioned(top: 8, right: 8, child: IconButton(
                        icon: const Icon(Icons.close, color: AppColors.error),
                        onPressed: () => _removeImage(i),
                      )),
                    ],
                  ),
                ),
        ),
      ]),
    );
  }
}
