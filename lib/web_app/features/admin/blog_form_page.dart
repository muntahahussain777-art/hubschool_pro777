import 'dart:io';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import '../../../../config/supabase_config.dart';
import '../../utils/slug_utils.dart';

/// Admin: Create/Edit blog post. Cover image upload to Supabase Storage.
class BlogFormPage extends StatefulWidget {
  final String? id;

  const BlogFormPage({super.key, this.id});

  @override
  State<BlogFormPage> createState() => _BlogFormPageState();
}

class _BlogFormPageState extends State<BlogFormPage> {
  final _titleCtrl = TextEditingController();
  final _slugCtrl = TextEditingController();
  final _summaryCtrl = TextEditingController();
  final _contentCtrl = TextEditingController();
  final _authorCtrl = TextEditingController();
  final _tagsCtrl = TextEditingController();
  String _category = 'Blog';
  bool _isPublished = false;
  bool _isFeatured = false;
  bool _isPinned = false;
  String? _coverImageUrl;
  bool _loading = false;
  bool _fetching = true;

  static const List<String> _categories = ['Blog', 'News', 'Event', 'Update'];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) _load(); else setState(() => _fetching = false);
  }

  Future<void> _load() async {
    if (widget.id == null) return;
    setState(() => _fetching = true);
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tBlogPosts).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        _titleCtrl.text = r['title'] as String? ?? '';
        _slugCtrl.text = r['slug'] as String? ?? '';
        _summaryCtrl.text = r['summary'] as String? ?? '';
        _contentCtrl.text = r['content'] as String? ?? '';
        _authorCtrl.text = r['author_name'] as String? ?? '';
        _tagsCtrl.text = r['tags'] is String ? (r['tags'] as String) : (r['tags']?.toString() ?? '');
        _category = r['category'] as String? ?? 'Blog';
        _isPublished = r['is_published'] == true;
        _isFeatured = r['is_featured'] == true;
        _isPinned = r['is_pinned'] == true;
        _coverImageUrl = r['cover_image_url']?.toString();
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  void _slugFromTitle() {
    final t = _titleCtrl.text.trim().toLowerCase().replaceAll(RegExp(r'[^a-z0-9\s-]'), '').replaceAll(RegExp(r'\s+'), '-').replaceAll(RegExp(r'-+'), '-');
    if (t.isNotEmpty) _slugCtrl.text = t;
  }

  Future<void> _pickAndUploadCover() async {
    try {
      final result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);
      if (result == null || result.files.isEmpty) return;
      final file = result.files.single;
      List<int>? bytes = file.bytes;
      String? ext = file.extension?.toLowerCase();
      if (ext == null || !['jpg', 'jpeg', 'png', 'gif', 'webp'].contains(ext)) ext = 'jpg';
      if (bytes == null && !kIsWeb && file.path != null) {
        final f = File(file.path!);
        if (await f.exists()) bytes = await f.readAsBytes();
      }
      if (bytes == null || bytes.isEmpty) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Could not read file')));
        return;
      }
      final name = '${const Uuid().v4()}.$ext';
      final data = bytes is Uint8List ? bytes : Uint8List.fromList(bytes!);
      await Supabase.instance.client.storage.from(SupabaseConfig.storageBlogCovers).uploadBinary(name, data, fileOptions: const FileOptions(upsert: true));
      final url = Supabase.instance.client.storage.from(SupabaseConfig.storageBlogCovers).getPublicUrl(name);
      if (mounted) setState(() => _coverImageUrl = url);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Cover image uploaded')));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Upload failed: $e')));
    }
  }

  void _removeCover() => setState(() => _coverImageUrl = null);

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    var slug = _slugCtrl.text.trim();
    if (title.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title required'))); return; }
    if (slug.contains('://') || slug.toLowerCase().startsWith('http')) { _slugFromTitle(); slug = _slugCtrl.text.trim(); }
    if (slug.isEmpty) { _slugFromTitle(); slug = _slugCtrl.text.trim(); }
    slug = safeSlugForRoute(slug).isEmpty ? title.toLowerCase().replaceAll(RegExp(r'[^a-z0-9\s-]'), '').replaceAll(RegExp(r'\s+'), '-') : safeSlugForRoute(slug);
    if (slug.isEmpty) slug = 'post-${DateTime.now().millisecondsSinceEpoch}';
    setState(() => _loading = true);
    try {
      final now = DateTime.now().toIso8601String();
      final map = <String, dynamic>{
        'title': title,
        'slug': slug,
        'summary': _summaryCtrl.text.trim().isEmpty ? null : _summaryCtrl.text.trim(),
        'content': _contentCtrl.text.trim().isEmpty ? null : _contentCtrl.text.trim(),
        'cover_image_url': _coverImageUrl,
        'category': _category,
        'author_name': _authorCtrl.text.trim().isEmpty ? null : _authorCtrl.text.trim(),
        'tags': _tagsCtrl.text.trim().isEmpty ? null : _tagsCtrl.text.trim(),
        'is_published': _isPublished,
        'is_featured': _isFeatured,
        'is_pinned': _isPinned,
        'updated_at': now,
        'published_at': _isPublished ? now : null,
      };
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tBlogPosts).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post updated'))); context.pop(true); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tBlogPosts).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Post created'))); context.pop(true); }
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _titleCtrl.dispose();
    _slugCtrl.dispose();
    _summaryCtrl.dispose();
    _contentCtrl.dispose();
    _authorCtrl.dispose();
    _tagsCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit post' : 'New post'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/blog'); })),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder()), onChanged: (_) => setState(() {})),
          const SizedBox(height: 12),
          Row(children: [
            Expanded(child: TextField(controller: _slugCtrl, decoration: const InputDecoration(labelText: 'Slug * (URL-friendly)', border: OutlineInputBorder()))),
            const SizedBox(width: 8),
            TextButton(onPressed: _slugFromTitle, child: const Text('From title')),
          ]),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _category, decoration: const InputDecoration(labelText: 'Category', border: OutlineInputBorder()), items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(), onChanged: (v) => setState(() => _category = v ?? 'Blog')),
          const SizedBox(height: 12),
          TextField(controller: _summaryCtrl, decoration: const InputDecoration(labelText: 'Short summary', border: OutlineInputBorder()), maxLines: 2),
          const SizedBox(height: 12),
          TextField(controller: _contentCtrl, decoration: const InputDecoration(labelText: 'Full content', border: OutlineInputBorder()), maxLines: 10),
          const SizedBox(height: 12),
          TextField(controller: _authorCtrl, decoration: const InputDecoration(labelText: 'Author name', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _tagsCtrl, decoration: const InputDecoration(labelText: 'Tags (comma-separated)', border: OutlineInputBorder())),
          const SizedBox(height: 16),
          const Text('Cover image', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          if (_coverImageUrl != null && _coverImageUrl!.isNotEmpty) ...[
            ClipRRect(borderRadius: BorderRadius.circular(8), child: Image.network(_coverImageUrl!, height: 180, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const SizedBox(height: 180, child: Placeholder()))),
            const SizedBox(height: 8),
            Row(children: [TextButton.icon(onPressed: _pickAndUploadCover, icon: const Icon(Icons.upload_rounded), label: const Text('Replace')), const SizedBox(width: 8), TextButton.icon(onPressed: _removeCover, icon: const Icon(Icons.delete_rounded), label: const Text('Remove'))]),
          ] else
            OutlinedButton.icon(onPressed: _pickAndUploadCover, icon: const Icon(Icons.upload_rounded), label: const Text('Upload cover image')),
          const SizedBox(height: 16),
          SwitchListTile(title: const Text('Published'), value: _isPublished, onChanged: (v) => setState(() => _isPublished = v)),
          SwitchListTile(title: const Text('Featured'), value: _isFeatured, onChanged: (v) => setState(() => _isFeatured = v)),
          SwitchListTile(title: const Text('Pinned'), value: _isPinned, onChanged: (v) => setState(() => _isPinned = v)),
          const SizedBox(height: 24),
          FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Create')),
        ],
      ),
    );
  }
}
