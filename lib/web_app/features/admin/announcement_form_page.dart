import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// Admin: Create/Edit announcement.
class AnnouncementFormPage extends StatefulWidget {
  final String? id;

  const AnnouncementFormPage({super.key, this.id});

  @override
  State<AnnouncementFormPage> createState() => _AnnouncementFormPageState();
}

class _AnnouncementFormPageState extends State<AnnouncementFormPage> {
  final _titleCtrl = TextEditingController();
  final _messageCtrl = TextEditingController();
  String _type = 'announcement';
  String _priority = 'normal';
  bool _isPublished = true;
  bool _isPinned = false;
  String? _startDate;
  String? _endDate;
  bool _loading = false;
  bool _fetching = true;

  static const List<String> _types = ['announcement', 'holiday', 'exam', 'admission', 'urgent'];
  static const List<String> _priorities = ['normal', 'important', 'urgent'];

  @override
  void initState() {
    super.initState();
    if (widget.id != null) _load(); else setState(() => _fetching = false);
  }

  Future<void> _load() async {
    if (widget.id == null) return;
    setState(() => _fetching = true);
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).select().eq('id', widget.id!).maybeSingle();
      if (r != null && mounted) {
        _titleCtrl.text = r['title'] as String? ?? '';
        _messageCtrl.text = r['message'] as String? ?? '';
        _type = r['type'] as String? ?? 'announcement';
        _priority = r['priority'] as String? ?? 'normal';
        _isPublished = r['is_published'] == true;
        _isPinned = r['is_pinned'] == true;
        final s = r['start_date']?.toString();
        final e = r['end_date']?.toString();
        _startDate = s != null && s.length >= 10 ? s.substring(0, 10) : null;
        _endDate = e != null && e.length >= 10 ? e.substring(0, 10) : null;
      }
    } catch (_) {}
    if (mounted) setState(() => _fetching = false);
  }

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    final message = _messageCtrl.text.trim();
    if (title.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Title required'))); return; }
    if (message.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Message required'))); return; }
    setState(() => _loading = true);
    try {
      final now = DateTime.now().toIso8601String();
      final map = {
        'title': title,
        'message': message,
        'type': _type,
        'priority': _priority,
        'is_published': _isPublished,
        'is_pinned': _isPinned,
        'start_date': _startDate,
        'end_date': _endDate,
        'updated_at': now,
      };
      if (widget.id != null) {
        await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).update(map).eq('id', widget.id!);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Announcement updated'))); context.pop(true); }
      } else {
        await Supabase.instance.client.from(SupabaseConfig.tAnnouncements).insert(map);
        if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Announcement created'))); context.pop(true); }
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
    _messageCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_fetching) return const Scaffold(body: Center(child: CircularProgressIndicator()));
    return Scaffold(
      appBar: AppBar(title: Text(widget.id != null ? 'Edit announcement' : 'New announcement'), leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin/announcements'); })),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(controller: _titleCtrl, decoration: const InputDecoration(labelText: 'Title *', border: OutlineInputBorder())),
          const SizedBox(height: 12),
          TextField(controller: _messageCtrl, decoration: const InputDecoration(labelText: 'Message *', border: OutlineInputBorder()), maxLines: 4),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _type, decoration: const InputDecoration(labelText: 'Type', border: OutlineInputBorder()), items: _types.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(), onChanged: (v) => setState(() => _type = v ?? 'announcement')),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(value: _priority, decoration: const InputDecoration(labelText: 'Priority', border: OutlineInputBorder()), items: _priorities.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(), onChanged: (v) => setState(() => _priority = v ?? 'normal')),
          const SizedBox(height: 12),
          ListTile(title: Text(_startDate ?? 'Start date (optional)'), trailing: const Icon(Icons.calendar_today_rounded), onTap: () async { final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030)); if (d != null) setState(() => _startDate = d.toIso8601String().substring(0, 10)); }),
          ListTile(title: Text(_endDate ?? 'End date / Expiry (optional)'), trailing: const Icon(Icons.calendar_today_rounded), onTap: () async { final d = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030)); if (d != null) setState(() => _endDate = d.toIso8601String().substring(0, 10)); }),
          SwitchListTile(title: const Text('Published'), value: _isPublished, onChanged: (v) => setState(() => _isPublished = v)),
          SwitchListTile(title: const Text('Pinned to top'), value: _isPinned, onChanged: (v) => setState(() => _isPinned = v)),
          const SizedBox(height: 24),
          FilledButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(strokeWidth: 2)) : Text(widget.id != null ? 'Update' : 'Create')),
        ],
      ),
    );
  }
}
