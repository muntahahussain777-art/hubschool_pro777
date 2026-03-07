import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// Student attendance: date, class filter, list of students with P / A / L.
class StudentAttendancePage extends StatefulWidget {
  const StudentAttendancePage({super.key});

  @override
  State<StudentAttendancePage> createState() => _StudentAttendancePageState();
}

class _StudentAttendancePageState extends State<StudentAttendancePage> {
  List<Map<String, dynamic>> _classrooms = [];
  List<Map<String, dynamic>> _students = [];
  Map<int, String> _status = {};
  int? _filterClassId;
  String? _date;
  bool _loading = true;
  String? _error;
  bool _saving = false;

  Future<void> _loadClassrooms() async {
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select('id, name, section').order('name');
      if (mounted) setState(() => _classrooms = List<Map<String, dynamic>>.from(res));
    } catch (_) {}
  }

  Future<void> _loadStudents() async {
    if (_filterClassId == null) {
      if (mounted) setState(() { _students = []; _status = {}; _loading = false; });
      return;
    }
    setState(() { _loading = true; _error = null; _students = []; _status = {}; });
    try {
      List<Map<String, dynamic>> stu = [];
      try {
        final enroll = await Supabase.instance.client.from(SupabaseConfig.tEnrollments).select('student_id').eq('classroom_id', _filterClassId!).eq('current', true);
        final ids = (enroll as List).map((e) => e['student_id']).whereType<int>().toSet().toList();
        if (ids.isNotEmpty) {
          final res = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').inFilter('id', ids).eq('is_active', true).order('full_name');
          stu = List<Map<String, dynamic>>.from(res);
        }
      } catch (_) {}
      if (stu.isEmpty) {
        final fallback = await Supabase.instance.client.from(SupabaseConfig.tStudents).select('id, full_name, admission_no').eq('classroom_id', _filterClassId!).eq('is_active', true).order('full_name');
        stu = List<Map<String, dynamic>>.from(fallback);
      }
      if (mounted) setState(() { _students = stu; _status = {}; });
      if (mounted && _date != null && _students.isNotEmpty) await _loadForDate();
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadForDate() async {
    if (_date == null || _students.isEmpty) return;
    try {
      final ids = _students.map((s) => s['id'] as int).toList();
      final res = await Supabase.instance.client.from(SupabaseConfig.tStudentAttendance).select('student_id, status').eq('date', _date!).inFilter('student_id', ids);
      final map = <int, String>{};
      for (final r in res as List) {
        final id = r['student_id'] as int?;
        final s = r['status'] as String?;
        if (id != null && s != null) map[id] = s;
      }
      if (mounted) setState(() => _status = map);
    } catch (_) {}
  }

  void _setStatus(int studentId, String status) {
    setState(() => _status[studentId] = status);
  }

  void _markAllPresent() {
    setState(() {
      for (final s in _students) {
        final id = s['id'] as int?;
        if (id != null) _status[id] = 'present';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All marked Present. Tap Save to store.')));
  }

  Future<void> _save() async {
    if (_date == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select date first'))); return; }
    if (_students.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select a class'))); return; }
    setState(() => _saving = true);
    try {
      for (final s in _students) {
        final id = s['id'] as int?;
        if (id == null) continue;
        final status = _status[id] ?? 'present';
        final existing = await Supabase.instance.client.from(SupabaseConfig.tStudentAttendance).select('id').eq('student_id', id).eq('date', _date!).maybeSingle();
        if (existing != null) {
          await Supabase.instance.client.from(SupabaseConfig.tStudentAttendance).update({'status': status}).eq('id', existing['id']);
        } else {
          await Supabase.instance.client.from(SupabaseConfig.tStudentAttendance).insert({'student_id': id, 'date': _date!, 'status': status});
        }
      }
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Attendance saved'))); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _date = DateTime.now().toIso8601String().substring(0, 10);
    _loadClassrooms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Attendance'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin'); }),
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const SizedBox(height: 8),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Row(children: [
            Expanded(child: ListTile(title: const Text('Date'), subtitle: Text(_date ?? 'Select'), trailing: const Icon(Icons.calendar_today_rounded), onTap: () async { final d = await showDatePicker(context: context, initialDate: _date != null ? DateTime.tryParse(_date!) ?? DateTime.now() : DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030)); if (d != null) { setState(() => _date = d.toIso8601String().substring(0, 10)); if (_filterClassId != null && _students.isNotEmpty) _loadForDate(); } })),
            const SizedBox(width: 16),
            Expanded(child: DropdownButtonFormField<int>(value: _filterClassId, decoration: const InputDecoration(labelText: 'Class', border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('Select Class')), ..._classrooms.map((c) => DropdownMenuItem(value: c['id'] as int?, child: Text('${c['name']} - ${c['section']}')))], onChanged: (v) async { setState(() => _filterClassId = v); await _loadStudents(); })),
          ]),
          const SizedBox(height: 12),
          Row(children: [TextButton.icon(onPressed: _students.isEmpty ? null : _markAllPresent, icon: const Icon(Icons.done_all_rounded), label: const Text('Mark all P')), const SizedBox(width: 8), FilledButton.icon(onPressed: _saving ? null : _save, icon: _saving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_rounded), label: Text(_saving ? 'Saving...' : 'Save'))]),
        ]))),
        const SizedBox(height: 16),
        Text('Mark P (Present), A (Absent), L (Leave)', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        if (_filterClassId == null)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('Select a class to load students.')))
        else if (_loading)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
        else if (_students.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No students in this class.')))
        else
          ..._students.map((s) {
            final id = s['id'] as int?;
            final name = s['full_name'] as String? ?? '—';
            final rollNo = s['admission_no'] as String? ?? '';
            final current = _status[id] ?? 'present';
            return Card(margin: const EdgeInsets.only(bottom: 8), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w600)), if (rollNo.isNotEmpty) Text('Roll: $rollNo', style: Theme.of(context).textTheme.bodySmall)])),
              SegmentedButton<String>(segments: const [ButtonSegment(value: 'present', label: Text('P'), icon: Icon(Icons.check_circle_rounded, size: 18)), ButtonSegment(value: 'absent', label: Text('A'), icon: Icon(Icons.cancel_rounded, size: 18)), ButtonSegment(value: 'leave', label: Text('L'), icon: Icon(Icons.event_busy_rounded, size: 18))], selected: {current}, onSelectionChanged: (v) => _setStatus(id ?? 0, v.first)),
            ])));
          }),
      ]),
    );
  }
}
