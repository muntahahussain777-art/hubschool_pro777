import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../config/supabase_config.dart';

class StudentFormPage extends StatefulWidget {
  final int? studentId;

  const StudentFormPage({super.key, this.studentId});

  @override
  State<StudentFormPage> createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _fatherCtrl = TextEditingController();
  final _admNoCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _feeCtrl = TextEditingController();
  final _prevSchoolCtrl = TextEditingController();

  DateTime? _dob;
  int? _classroomId;
  String? _gender;
  bool _loading = false;
  bool _fetching = true;
  List<Map<String, dynamic>> _classrooms = [];

  @override
  void initState() {
    super.initState();
    _loadClassrooms();
    if (widget.studentId != null) _loadStudent();
    else setState(() => _fetching = false);
  }

  Future<void> _loadClassrooms() async {
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select('id, name, section').order('name');
      if (mounted) setState(() => _classrooms = List<Map<String, dynamic>>.from(res));
    } catch (_) {}
  }

  Future<void> _loadStudent() async {
    try {
      final res = await Supabase.instance.client
          .from(SupabaseConfig.tStudents)
          .select()
          .eq('id', widget.studentId!)
          .maybeSingle();
      if (res != null && mounted) {
        final s = res as Map<String, dynamic>;
        _nameCtrl.text = s['full_name'] as String? ?? '';
        _fatherCtrl.text = s['father_name'] as String? ?? '';
        _admNoCtrl.text = s['admission_no'] as String? ?? '';
        _phoneCtrl.text = s['phone'] as String? ?? '';
        _addressCtrl.text = s['address'] as String? ?? '';
        _prevSchoolCtrl.text = s['previous_school'] as String? ?? '';
        final fee = s['monthly_fee'];
        _feeCtrl.text = fee != null && (fee as int) > 0 ? '${(fee ~/ 100)}' : '';
        _classroomId = s['classroom_id'] as int?;
        _gender = s['gender'] as String?;
        final dob = s['dob'];
        if (dob != null) _dob = DateTime.tryParse(dob.toString());
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _fatherCtrl.dispose();
    _admNoCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _feeCtrl.dispose();
    _prevSchoolCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    try {
      final fee = int.tryParse(_feeCtrl.text.trim()) ?? 0;
      final feePaisa = fee * 100;
      final dobStr = _dob != null ? '${_dob!.toIso8601String().split('T')[0]}' : null;
      final baseMap = <String, dynamic>{
        'full_name': _nameCtrl.text.trim(),
        'father_name': _fatherCtrl.text.trim(),
        'admission_no': _admNoCtrl.text.trim(),
        'phone': _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(),
        'address': _addressCtrl.text.trim().isEmpty ? null : _addressCtrl.text.trim(),
        'dob': dobStr,
      };
      final optionalMap = <String, dynamic>{
        'previous_school': _prevSchoolCtrl.text.trim().isEmpty ? null : _prevSchoolCtrl.text.trim(),
        'classroom_id': _classroomId,
        'monthly_fee': feePaisa,
        'gender': _gender,
      };

      if (widget.studentId != null) {
        final full = Map<String, dynamic>.from(baseMap)..addAll(optionalMap);
        try {
          await Supabase.instance.client.from(SupabaseConfig.tStudents).update(full).eq('id', widget.studentId!);
        } catch (e) {
          if (e.toString().contains('classroom_id') || e.toString().contains('could not find')) {
            await Supabase.instance.client.from(SupabaseConfig.tStudents).update(baseMap).eq('id', widget.studentId!);
          } else rethrow;
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student updated')));
          context.pop(true);
        }
      } else {
        final qrToken = const Uuid().v4();
        final full = Map<String, dynamic>.from(baseMap)
          ..addAll(optionalMap)
          ..['qr_token'] = qrToken
          ..['is_active'] = true;
        try {
          await Supabase.instance.client.from(SupabaseConfig.tStudents).insert(full);
        } catch (e) {
          if (e.toString().contains('classroom_id') || e.toString().contains('could not find')) {
            final fallback = Map<String, dynamic>.from(baseMap);
            fallback['qr_token'] = qrToken;
            fallback['is_active'] = true;
            await Supabase.instance.client.from(SupabaseConfig.tStudents).insert(fallback);
          } else rethrow;
        }
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Student added')));
          context.pop(true);
        }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.studentId != null ? 'Edit Student' : 'New Admission'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop()),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(labelText: 'Full Name *', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person_rounded)),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _fatherCtrl,
              decoration: const InputDecoration(labelText: "Father's Name *", border: OutlineInputBorder(), prefixIcon: Icon(Icons.family_restroom_rounded)),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _admNoCtrl,
              decoration: const InputDecoration(labelText: 'Admission No *', border: OutlineInputBorder(), prefixIcon: Icon(Icons.badge_rounded)),
              validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
              items: const [
                DropdownMenuItem(value: 'male', child: Text('Male')),
                DropdownMenuItem(value: 'female', child: Text('Female')),
              ],
              onChanged: (v) => setState(() => _gender = v),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<int>(
              value: _classroomId,
              decoration: const InputDecoration(labelText: 'Class', border: OutlineInputBorder()),
              items: [
                const DropdownMenuItem(value: null, child: Text('Select class')),
                ..._classrooms.map((c) {
                  final id = c['id'] as int?;
                  final name = c['name'] as String? ?? '';
                  final sec = c['section'] as String? ?? '';
                  return DropdownMenuItem(value: id, child: Text('$name - $sec'));
                }),
              ],
              onChanged: (v) => setState(() => _classroomId = v),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _feeCtrl,
              decoration: const InputDecoration(labelText: 'Monthly Fee (Rs)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.payments_rounded)),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _phoneCtrl,
              decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone_rounded)),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _prevSchoolCtrl,
              decoration: const InputDecoration(labelText: 'Previous School', border: OutlineInputBorder(), prefixIcon: Icon(Icons.school_rounded)),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _addressCtrl,
              decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder(), prefixIcon: Icon(Icons.location_on_rounded)),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: Text(_dob == null ? 'Date of Birth (optional)' : 'DOB: ${_dob!.day}/${_dob!.month}/${_dob!.year}'),
              trailing: const Icon(Icons.calendar_today_rounded),
              onTap: () async {
                final p = await showDatePicker(context: context, initialDate: _dob ?? DateTime(2010), firstDate: DateTime(1990), lastDate: DateTime.now());
                if (p != null) setState(() => _dob = p);
              },
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _loading ? null : _submit,
              child: _loading
                  ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2))
                  : Text(widget.studentId != null ? 'Update Student' : 'Save Student'),
            ),
          ],
        ),
      ),
    );
  }
}
