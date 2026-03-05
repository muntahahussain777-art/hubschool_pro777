import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';

class OcrScreen extends StatefulWidget {
  const OcrScreen({super.key});

  @override
  State<OcrScreen> createState() => _OcrScreenState();
}

class _OcrScreenState extends State<OcrScreen> {
  final _picker = ImagePicker();
  String _extractedText = '';
  bool _loading = false;

  Future<void> _pickAndExtract() async {
    setState(() => _loading = true);
    try {
      final x = await _picker.pickImage(source: ImageSource.camera, imageQuality: 90);
      if (x == null) { setState(() => _loading = false); return; }
      final input = InputImage.fromFilePath(x.path);
      final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final result = await recognizer.processImage(input);
      await recognizer.close();
      setState(() { _extractedText = result.text; _loading = false; });
    } catch (e) {
      setState(() { _extractedText = 'Error: $e'; _loading = false; });
    }
  }

  Future<void> _pickFromGallery() async {
    setState(() => _loading = true);
    try {
      final x = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
      if (x == null) { setState(() => _loading = false); return; }
      final input = InputImage.fromFilePath(x.path);
      final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
      final result = await recognizer.processImage(input);
      await recognizer.close();
      setState(() { _extractedText = result.text; _loading = false; });
    } catch (e) {
      setState(() { _extractedText = 'Error: $e'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('OCR - Extract Text')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Row(children: [
            Expanded(child: ElevatedButton.icon(onPressed: _loading ? null : _pickAndExtract, icon: const Icon(Icons.camera_alt_rounded), label: const Text('Camera'))),
            const SizedBox(width: 12),
            Expanded(child: OutlinedButton.icon(onPressed: _loading ? null : _pickFromGallery, icon: const Icon(Icons.photo_library_rounded), label: const Text('Gallery'), style: OutlinedButton.styleFrom(side: const BorderSide(color: AppColors.primary)))),
          ]),
          const SizedBox(height: 20),
          if (_loading) const Center(child: CircularProgressIndicator(color: AppColors.primary)),
          if (!_loading && _extractedText.isNotEmpty) ...[
            const Text('Extracted Text', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            Expanded(
              child: GlassCard(
                padding: const EdgeInsets.all(14),
                child: SingleChildScrollView(
                  child: SelectableText(_extractedText, style: const TextStyle(color: AppColors.textPrimary, fontSize: 14, height: 1.5)),
                ),
              ),
            ),
          ],
        ]),
      ),
    );
  }
}
