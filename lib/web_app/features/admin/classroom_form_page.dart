import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class ClassroomFormPage extends StatefulWidget {
  final int? id;

  const ClassroomFormPage({super.key, this.id});

  @override
  State<ClassroomFormPage> createState() => _ClassroomFormPageState();
}

class _ClassroomFormPageState extends State<ClassroomFormPage> {
  final _nameCtrl = TextEditingController();
  final _sectionCtrl = TextEditingController(text: 'A');
  final _yearCtrl = TextEditingController(text: DateTime.now().year.toString());
  bool _loading = false, _fetching = true;

  @override
  void initState() {
    super.initState();
    if (widget.id != null) _load(); else setState(() => _fetching = false);
  }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tClassrooms).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        _nameCtrl.text = r['name'] as String? ?? '';
        _sectionCtrl.text = r['section'] as String? ?? 'A';
        _yearCtrl.text = (r['academic_year'] as int?)?.toString() ?? '';
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _nameCtrl.dispose(); _sectionCtrl.dispose(); _yearCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    final name = _nameCtrl.text.trim();
    final year = int.tryParse(_yearCtrl.text.trim()) ?? DateTime.now().year;
    if (name.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name required'))); return; }
    setState(() => _loading = true);
    try {
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tClassrooms).update({'name': name, 'section': _sectionCtrl.text.trim().isEmpty ? 'A' : _sectionCtrl.text.trim(), 'academic_year': year}).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Class updated'))); context.pop(); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tClassrooms).insert({'name': name, 'section': _sectionCtrl.text.trim().isEmpty ? 'A' : _sectionCtrl.text.trim(), 'academic_year': year});
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Class added'))); context.pop(); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Class' : 'Add Class'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Class Name *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _sectionCtrl, decoration: const InputDecoration(labelText: 'Section', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _yearCtrl, decoration: const InputDecoration(labelText: 'Academic Year', border: OutlineInputBorder()), keyboardType: TextInputType.number),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
