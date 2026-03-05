import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/repositories/database_provider.dart';
import '../../../services/biometric/biometric_service.dart';
import '../../../services/exams/exam_policy_service.dart';
import '../../academics/presentation/academics_screen.dart';
import '../../tools/presentation/ocr_screen.dart';
import '../../tools/presentation/scanner_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Security', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          FutureBuilder<List<bool>>(
            future: Future.wait([
              biometricService.isAvailable(),
              biometricService.isFingerprintLoginEnabled(),
            ]),
            builder: (_, snap) {
              if (!snap.hasData || snap.data![0] != true) return const SizedBox();
              final enabled = snap.data![1];
              return GlassCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.fingerprint_rounded, color: AppColors.primary, size: 24),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Login Fingerprint', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                              Text('Login screen par biometric prompt', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                            ],
                          ),
                        ),
                        Switch(
                          value: enabled,
                          activeColor: AppColors.primary,
                          onChanged: (v) async {
                            await biometricService.setFingerprintLoginEnabled(v);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(v ? 'Fingerprint login ON' : 'Fingerprint login OFF'),
                                backgroundColor: v ? AppColors.success : AppColors.warning,
                                behavior: SnackBarBehavior.floating,
                              ));
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: () async {
                          final ok = await biometricService.authenticate(reason: 'Test fingerprint');
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(ok ? 'Fingerprint verified' : 'Failed'),
                              backgroundColor: ok ? AppColors.success : AppColors.error,
                              behavior: SnackBarBehavior.floating,
                            ));
                          }
                        },
                        icon: const Icon(Icons.verified_rounded, size: 18),
                        label: const Text('Test fingerprint'),
                        style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('Exams & Marksheet', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          FutureBuilder<List<dynamic>>(
            future: Future.wait([
              examPolicyService.isPassFailAuto(),
              examPolicyService.getPassFailThreshold(),
            ]),
            builder: (_, snap) {
              if (!snap.hasData) return const SizedBox();
              final auto = snap.data![0] as bool;
              final threshold = snap.data![1] as double;
              final ctrl = TextEditingController(text: threshold.toStringAsFixed(0));
              return GlassCard(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.rule_rounded, color: AppColors.secondary, size: 24),
                        ),
                        const SizedBox(width: 14),
                        const Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pass / Fail Threshold', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                              Text('School policy ke mutabiq % set karein', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                            ],
                          ),
                        ),
                        Switch(
                          value: auto,
                          activeColor: AppColors.primary,
                          onChanged: (v) async {
                            await examPolicyService.setPassFailAuto(v);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(v ? 'Auto policy (33%) enabled' : 'Custom % policy enabled'),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (auto)
                      const Text('Auto mode: 33% passing (Pakistan board style)', style: TextStyle(color: AppColors.textMuted, fontSize: 12))
                    else ...[
                      const Text('Custom passing percentage (%)', style: TextStyle(color: AppColors.textPrimary, fontSize: 13, fontWeight: FontWeight.w500)),
                      const SizedBox(height: 6),
                      Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: TextField(
                              controller: ctrl,
                              keyboardType: TextInputType.number,
                              style: const TextStyle(color: AppColors.textPrimary),
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                suffixText: '%',
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton(
                            onPressed: () async {
                              final v = double.tryParse(ctrl.text);
                              if (v == null || v <= 0 || v > 100) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('0 se 100 ke beech valid % likhein'),
                                      backgroundColor: AppColors.error,
                                    ),
                                  );
                                }
                                return;
                              }
                              await examPolicyService.setCustomPassFailThreshold(v);
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Passing ${v.toStringAsFixed(0)}% set ho gaya'),
                                    backgroundColor: AppColors.success,
                                    behavior: SnackBarBehavior.floating,
                                  ),
                                );
                              }
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          const Text('Database (SQLite)', style: TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w700)),
          const SizedBox(height: 8),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () => _backupDatabase(context, ref),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.backup_rounded, color: AppColors.success, size: 24)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Backup', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Export SQLite database', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ]),
          ),
          const SizedBox(height: 10),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () => _restoreDatabase(context, ref),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.restore_rounded, color: AppColors.warning, size: 24)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Restore', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Import from backup file', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ]),
          ),
          const SizedBox(height: 24),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AcademicsScreen())),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.school_rounded, color: AppColors.secondary, size: 24)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Classes & Subjects', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Manage classes, subjects, teachers', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ]),
          ),
          const SizedBox(height: 10),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const OcrScreen())),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.secondary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.document_scanner_rounded, color: AppColors.secondary, size: 24)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('OCR', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Extract text from documents', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ]),
          ),
          const SizedBox(height: 10),
          GlassCard(
            padding: const EdgeInsets.all(14),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ScannerScreen())),
            child: Row(children: [
              Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.accent.withOpacity(0.15), borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.document_scanner_rounded, color: AppColors.accent, size: 24)),
              const SizedBox(width: 14),
              const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text('Scanner', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w600)),
                Text('Scan to PDF/Image', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
              ])),
              const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
            ]),
          ),
        ],
      ),
    );
  }

  Future<void> _backupDatabase(BuildContext context, WidgetRef ref) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final src = File('${dir.path}/hubschool_pro.sqlite');
      if (!await src.exists()) {
        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Database not found')));
        return;
      }
      final dest = File('${dir.path}/hubschool_backup_${DateTime.now().millisecondsSinceEpoch}.sqlite');
      await src.copy(dest.path);
      await Share.shareXFiles([XFile(dest.path)], text: 'HubSchool Pro Backup');
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Backup created'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }

  Future<void> _restoreDatabase(BuildContext context, WidgetRef ref) async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.any, allowMultiple: false);
      if (result == null || result.files.isEmpty) return;
      final path = result.files.single.path;
      if (path == null) {
        if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('File path not available')));
        return;
      }
      final dir = await getApplicationDocumentsDirectory();
      final dest = File('${dir.path}/hubschool_pro.sqlite');
      await File(path).copy(dest.path);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Restore successful! Restart app.'), backgroundColor: AppColors.success, behavior: SnackBarBehavior.floating));
      }
    } catch (e) {
      if (context.mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error));
    }
  }
}
