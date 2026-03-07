import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class ExamFormPage extends StatefulWidget {
  const ExamFormPage({super.key, this.id});
  static const List<String> examTypes = ['Monthly Test', 'Mid Term', 'Final Exam', 'Annual Exam', 'Custom'];
  final int? id;

  @override
  State<ExamFormPage> createState() => _ExamFormPageState();
}

class _ExamFormPageState extends State<ExamFormPage> {
  String _examType = 'Monthly Test';
  final _customTitleCtrl = TextEditingController();
  int? _classroomId;
  String? _examDate;
  List<Map<String, dynamic>> _classrooms = [];
  bool _loading = false, _fetching = true;

  String get _title => _examType == 'Custom' ? _customTitleCtrl.text.trim() : _examType;

  @override
  void initState() { super.initState(); _loadClasses(); if (widget.id != null) _load(); else setState(() => _fetching = false); }

  Future<void> _loadClasses() async {
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select('id, name, section').order('name');
      if (mounted) setState(() => _classrooms = List<Map<String, dynamic>>.from(res));
    } catch (_) {}
  }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tExams).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        final t = r['title'] as String? ?? '';
        if (ExamFormPage.examTypes.contains(t)) {
          _examType = t;
        } else {
          _examType = 'Custom';
          _customTitleCtrl.text = t;
        }
        _classroomId = r['classroom_id'] as int?;
        final d = r['exam_date']?.toString();
        _examDate = d != null && d.length >= 10 ? d.substring(0, 10) : null;
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _customTitleCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_title.isEmpty || _classroomId == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam name and Class required'))); return; }
    setState(() => _loading = true);
    try {
      final map = {'title': _title, 'classroom_id': _classroomId, 'exam_date': _examDate, 'is_published': false};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tExams).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam updated'))); context.pop(); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tExams).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Exam added'))); context.pop(); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Exam' : 'Add Exam'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/exams'); })),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        DropdownButtonFormField<String>(value: _examType, decoration: const InputDecoration(labelText: 'Exam Name *', border: OutlineInputBorder()), items: ExamFormPage.examTypes.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(), onChanged: (v) => setState(() => _examType = v ?? 'Monthly Test')),
        if (_examType == 'Custom') ...[const SizedBox(height: 16), TextField(controller: _customTitleCtrl, decoration: const InputDecoration(labelText: 'Custom Exam Name *', border: OutlineInputBorder()), onChanged: (_) => setState(() {}))],
        const SizedBox(height: 16),
        DropdownButtonFormField<int>(value: _classroomId, decoration: const InputDecoration(labelText: 'Class *', border: OutlineInputBorder()), items: [const DropdownMenuItem(value: null, child: Text('Select Class')), ..._classrooms.map((c) => DropdownMenuItem(value: c['id'] as int?, child: Text('${c['name']} - ${c['section']}')))], onChanged: (v) => setState(() => _classroomId = v)),
        const SizedBox(height: 16),
        ListTile(title: Text(_examDate ?? 'Exam Date (optional)'), trailing: const Icon(Icons.calendar_today_rounded), onTap: () async { final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030)); if (d != null) setState(() => _examDate = '${d.toIso8601String().substring(0, 10)}'); }),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
