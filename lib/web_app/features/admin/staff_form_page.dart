import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class StaffFormPage extends StatefulWidget {
  final int? id;

  const StaffFormPage({super.key, this.id});

  @override
  State<StaffFormPage> createState() => _StaffFormPageState();
}

class _StaffFormPageState extends State<StaffFormPage> {
  final _codeCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  final _designationCtrl = TextEditingController(text: 'Teacher');
  final _phoneCtrl = TextEditingController();
  final _salaryCtrl = TextEditingController();
  bool _loading = false, _fetching = true;

  @override
  void initState() { super.initState(); if (widget.id != null) _load(); else setState(() => _fetching = false); }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tStaff).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        _codeCtrl.text = r['employee_code'] as String? ?? '';
        _nameCtrl.text = r['full_name'] as String? ?? '';
        _designationCtrl.text = r['designation'] as String? ?? 'Teacher';
        _phoneCtrl.text = r['phone'] as String? ?? '';
        final s = r['base_salary'] as int?;
        _salaryCtrl.text = s != null && s > 0 ? '${s ~/ 100}' : '';
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _codeCtrl.dispose(); _nameCtrl.dispose(); _designationCtrl.dispose(); _phoneCtrl.dispose(); _salaryCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_codeCtrl.text.trim().isEmpty || _nameCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code and Name required'))); return; }
    final salary = (int.tryParse(_salaryCtrl.text.trim()) ?? 0) * 100;
    setState(() => _loading = true);
    try {
      final map = {'employee_code': _codeCtrl.text.trim(), 'full_name': _nameCtrl.text.trim(), 'designation': _designationCtrl.text.trim().isEmpty ? 'Teacher' : _designationCtrl.text.trim(), 'phone': _phoneCtrl.text.trim().isEmpty ? null : _phoneCtrl.text.trim(), 'base_salary': salary, 'is_active': true};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tStaff).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Staff updated'))); context.pop(); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tStaff).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Staff added'))); context.pop(); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Staff' : 'Add Staff'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _codeCtrl, decoration: const InputDecoration(labelText: 'Employee Code *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Full Name *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _designationCtrl, decoration: const InputDecoration(labelText: 'Designation', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _phoneCtrl, decoration: const InputDecoration(labelText: 'Phone', border: OutlineInputBorder()), keyboardType: TextInputType.phone),
        const SizedBox(height: 16),
        TextField(controller: _salaryCtrl, decoration: const InputDecoration(labelText: 'Base Salary (Rs)', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
