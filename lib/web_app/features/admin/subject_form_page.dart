import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class SubjectFormPage extends StatefulWidget {
  final int? id;

  const SubjectFormPage({super.key, this.id});

  @override
  State<SubjectFormPage> createState() => _SubjectFormPageState();
}

class _SubjectFormPageState extends State<SubjectFormPage> {
  final _nameCtrl = TextEditingController();
  final _codeCtrl = TextEditingController();
  bool _loading = false, _fetching = true;

  @override
  void initState() { super.initState(); if (widget.id != null) _load(); else setState(() => _fetching = false); }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tSubjects).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) { _nameCtrl.text = r['name'] as String? ?? ''; _codeCtrl.text = r['code'] as String? ?? ''; }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _nameCtrl.dispose(); _codeCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_nameCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Name required'))); return; }
    setState(() => _loading = true);
    try {
      final map = {'name': _nameCtrl.text.trim(), 'code': _codeCtrl.text.trim().isEmpty ? null : _codeCtrl.text.trim(), 'is_active': true};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tSubjects).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject updated'))); context.pop(); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tSubjects).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Subject added'))); context.pop(); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Subject' : 'Add Subject'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Subject Name *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _codeCtrl, decoration: const InputDecoration(labelText: 'Code', border: OutlineInputBorder())),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
