import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../data/local/school_database.dart';
import '../../../data/repositories/database_provider.dart';
import '../../../services/student_attendance_service.dart';

class VoiceAttendanceScreen extends ConsumerStatefulWidget {
  const VoiceAttendanceScreen({super.key});
  @override
  ConsumerState<VoiceAttendanceScreen> createState() => _VoiceAttendanceScreenState();
}

class _VoiceAttendanceScreenState extends ConsumerState<VoiceAttendanceScreen> {
  final _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  String _status = 'Tap mic: "Mark [Student Name] present" or "Mark [Name] absent"';
  final List<String> _log = [];

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    await _speech.initialize(onStatus: (s) {
      if (s == 'notListening') setState(() => _isListening = false);
    });
  }

  void _startListening() async {
    if (!_speech.isAvailable) {
      setState(() => _status = 'Speech not available on this device');
      return;
    }
    setState(() { _isListening = true; _text = ''; });
    await _speech.listen(
      onResult: (result) {
        setState(() => _text = result.recognizedWords);
        if (result.finalResult) _processCommand(result.recognizedWords);
      },
      listenFor: const Duration(seconds: 10),
      localeId: 'en_US',
    );
  }

  void _stopListening() {
    _speech.stop();
    setState(() => _isListening = false);
  }

  Future<void> _processCommand(String text) async {
    final lower = text.toLowerCase().trim();
    String? name;
    String status = 'present';

    if (lower.contains('present')) {
      status = 'present';
      name = _extractName(lower, 'present');
    } else if (lower.contains('absent')) {
      status = 'absent';
      name = _extractName(lower, 'absent');
    } else if (lower.contains('leave')) {
      status = 'leave';
      name = _extractName(lower, 'leave');
    }

    if (name == null || name.isEmpty) {
      setState(() => _status = 'Try: "Mark Ali present"');
      return;
    }

    final studentsDao = ref.read(studentsDaoProvider);
    final allStudents = await studentsDao.watchActiveStudents().first;
    final match = allStudents.where((s) => s.fullName.toLowerCase().contains(name!.toLowerCase()) || s.admissionNo.toLowerCase().contains(name.toLowerCase())).toList();

    if (match.isEmpty) {
      setState(() { _status = 'Student "$name" not found'; _log.add('? $name - not found'); });
      return;
    }

    final student = match.first;
    await StudentAttendanceService.markAttendance(student.id, student.fullName, status);
    setState(() {
      _status = '${student.fullName} marked $status';
      _log.insert(0, '${status == 'present' ? '✓' : '✗'} ${student.fullName} - $status');
    });
  }

  String? _extractName(String text, String keyword) {
    final patterns = [
      RegExp('mark\\s+(.+?)\\s+$keyword', caseSensitive: false),
      RegExp('(.+?)\\s+$keyword', caseSensitive: false),
      RegExp('$keyword\\s+(.+)', caseSensitive: false),
    ];
    for (final p in patterns) {
      final match = p.firstMatch(text);
      if (match != null) return match.group(1)?.trim();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Attendance')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          GlassCard(
            borderColor: _isListening ? AppColors.success.withOpacity(0.5) : AppColors.glassBorder,
            child: Column(children: [
              GestureDetector(
                onTap: _isListening ? _stopListening : _startListening,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 100, height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: _isListening
                        ? [AppColors.success, const Color(0xFF00E5A0)]
                        : [AppColors.primary, AppColors.primaryLight]),
                    boxShadow: _isListening
                        ? [BoxShadow(color: AppColors.success.withOpacity(0.4), blurRadius: 30, spreadRadius: 5)]
                        : [],
                  ),
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none_rounded, color: Colors.white, size: 44),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                _isListening ? 'Listening...' : 'Tap to speak',
                style: TextStyle(color: _isListening ? AppColors.success : AppColors.textSecondary, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              if (_text.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text('"$_text"', style: const TextStyle(color: AppColors.primary, fontSize: 14, fontStyle: FontStyle.italic)),
              ],
              const SizedBox(height: 8),
              Text(_status, style: const TextStyle(color: AppColors.textMuted, fontSize: 12), textAlign: TextAlign.center),
            ]),
          ),
          const SizedBox(height: 20),
          if (_log.isNotEmpty) ...[
            const Align(alignment: Alignment.centerLeft, child: Text('Activity Log', style: TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.w700))),
            const SizedBox(height: 10),
          ],
          Expanded(
            child: ListView.builder(
              itemCount: _log.length,
              itemBuilder: (_, i) => Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppColors.card, borderRadius: BorderRadius.circular(10), border: Border.all(color: AppColors.cardBorder)),
                child: Text(_log[i], style: const TextStyle(color: AppColors.textPrimary, fontSize: 13)),
              ).animate(delay: Duration(milliseconds: i * 30)).fadeIn(duration: 200.ms),
            ),
          ),
        ]),
      ),
    );
  }
}
