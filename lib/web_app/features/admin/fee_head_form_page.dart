import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class FeeHeadFormPage extends StatefulWidget {
  final int? id;

  const FeeHeadFormPage({super.key, this.id});

  @override
  State<FeeHeadFormPage> createState() => _FeeHeadFormPageState();
}

class _FeeHeadFormPageState extends State<FeeHeadFormPage> {
  final _codeCtrl = TextEditingController();
  final _nameCtrl = TextEditingController();
  bool _isDiscount = false, _loading = false, _fetching = true;

  @override
  void initState() { super.initState(); if (widget.id != null) _load(); else setState(() => _fetching = false); }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tFeeHeads).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) { _codeCtrl.text = r['code'] as String? ?? ''; _nameCtrl.text = r['name'] as String? ?? ''; _isDiscount = r['is_discount'] == true; }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _codeCtrl.dispose(); _nameCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_codeCtrl.text.trim().isEmpty || _nameCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Code and Name required'))); return; }
    setState(() => _loading = true);
    try {
      final map = {'code': _codeCtrl.text.trim(), 'name': _nameCtrl.text.trim(), 'is_discount': _isDiscount};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tFeeHeads).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fee head updated'))); context.pop(); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tFeeHeads).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Fee head added'))); context.pop(); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit Fee Head' : 'Add Fee Head'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _codeCtrl, decoration: const InputDecoration(labelText: 'Code *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        TextField(controller: _nameCtrl, decoration: const InputDecoration(labelText: 'Name *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('Is Discount'), value: _isDiscount, onChanged: (v) => setState(() => _isDiscount = v)),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
