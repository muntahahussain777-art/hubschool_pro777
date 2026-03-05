import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class StudentAttendanceRecord {
  final int studentId;
  final String studentName;
  final DateTime date;
  final String status;

  StudentAttendanceRecord({required this.studentId, required this.studentName, required this.date, required this.status});

  Map<String, dynamic> toJson() => {'studentId': studentId, 'studentName': studentName, 'date': date.toIso8601String(), 'status': status};
  factory StudentAttendanceRecord.fromJson(Map<String, dynamic> j) => StudentAttendanceRecord(
    studentId: j['studentId'], studentName: j['studentName'], date: DateTime.parse(j['date']), status: j['status'],
  );
}

class StudentAttendanceService {
  static Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/student_attendance.json');
  }

  static Future<List<StudentAttendanceRecord>> _load() async {
    try {
      final f = await _getFile();
      if (!await f.exists()) return [];
      final s = await f.readAsString();
      final list = jsonDecode(s) as List;
      return list.map((e) => StudentAttendanceRecord.fromJson(e as Map<String, dynamic>)).toList();
    } catch (_) { return []; }
  }

  static Future<void> _save(List<StudentAttendanceRecord> list) async {
    final f = await _getFile();
    await f.writeAsString(jsonEncode(list.map((e) => e.toJson()).toList()));
  }

  static Future<void> markAttendance(int studentId, String studentName, String status) async {
    final list = await _load();
    final now = DateTime.now();
    final dateKey = DateTime(now.year, now.month, now.day);
    list.removeWhere((r) => r.studentId == studentId && DateTime(r.date.year, r.date.month, r.date.day) == dateKey);
    list.add(StudentAttendanceRecord(studentId: studentId, studentName: studentName, date: now, status: status));
    await _save(list);
  }

  static Future<List<StudentAttendanceRecord>> getForDate(DateTime date) async {
    final list = await _load();
    final d = DateTime(date.year, date.month, date.day);
    return list.where((r) => DateTime(r.date.year, r.date.month, r.date.day) == d).toList();
  }
}
