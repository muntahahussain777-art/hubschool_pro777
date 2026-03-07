import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

class NewsFormPage extends StatefulWidget {
  final int? id;

  const NewsFormPage({super.key, this.id});

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  String _type = 'news';
  bool _published = true;
  bool _loading = false, _fetching = true;

  @override
  void initState() { super.initState(); if (widget.id != null) _load(); else setState(() => _fetching = false); }

  Future<void> _load() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tNewsPosts).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) { _titleCtrl.text = r['title'] as String? ?? ''; _bodyCtrl.text = r['body'] as String? ?? ''; _type = r['type'] as String? ?? 'news'; _published = r['is_published'] == true; }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  @override
  void dispose() { _titleCtrl.dispose(); _bodyCtrl.dispose(); super.dispose(); }

  Future<void> _submit() async {
    if (_titleCtrl.text.trim().isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title required'))); return; }
    setState(() => _loading = true);
    try {
      final map = {'title': _titleCtrl.text.trim(), 'body': _bodyCtrl.text.trim().isEmpty ? null : _bodyCtrl.text.trim(), 'type': _type, 'is_published': _published, 'updated_at': DateTime.now().toIso8601String()};
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tNewsPosts).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Updated'))); context.pop(true); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tNewsPosts).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Added'))); context.pop(true); }
      }
    } catch (e) { if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e'))); }
    finally { if (mounted) setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit' : 'Add News/Blog'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () => context.pop())),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder())),
        const SizedBox(height: 16),
        DropdownButtonFormField<String>(value: _type, decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()), items: const [DropdownMenuItem(value: 'news', child: Text('News')), DropdownMenuItem(value: 'blog', child: Text('Blog'))], onChanged: (v) => setState(() => _type = v ?? 'news')),
        const SizedBox(height: 16),
        TextField(controller: _bodyCtrl, decoration: const InputDecoration(labelText: 'Body', border: OutlineInputBorder()), maxLines: 6),
        const SizedBox(height: 16),
        SwitchListTile(title: const Text('Published'), value: _published, onChanged: (v) => setState(() => _published = v)),
        const SizedBox(height: 24),
        FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Save')),
      ]),
    );
  }
}
