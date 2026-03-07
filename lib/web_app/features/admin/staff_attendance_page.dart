import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// Staff attendance: date + list of staff with P / A / L (Present, Absent, Leave).
class StaffAttendancePage extends StatefulWidget {
  const StaffAttendancePage({super.key});

  @override
  State<StaffAttendancePage> createState() => _StaffAttendancePageState();
}

class _StaffAttendancePageState extends State<StaffAttendancePage> {
  List<Map<String, dynamic>> _staff = [];
  Map<int, String> _status = {}; // staffId -> present | absent | leave
  String? _date;
  bool _loading = true;
  String? _error;
  bool _saving = false;

  Future<void> _loadStaff() async {
    setState(() { _loading = true; _error = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tStaff).select('id, full_name, employee_code').eq('is_active', true).order('full_name');
      if (mounted) setState(() => _staff = List<Map<String, dynamic>>.from(res));
      if (mounted && _date != null) await _loadForDate();
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _loadForDate() async {
    if (_date == null) return;
    setState(() => _loading = true);
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tStaffAttendance).select('staff_id, status').eq('date', _date!);
      final map = <int, String>{};
      for (final r in res as List) {
        final id = r['staff_id'] as int?;
        final s = r['status'] as String?;
        if (id != null && s != null) map[id] = s;
      }
      if (mounted) setState(() { _status = map; _loading = false; });
    } catch (_) {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _setStatus(int staffId, String status) {
    setState(() => _status[staffId] = status);
  }

  void _markAllPresent() {
    setState(() {
      for (final s in _staff) {
        final id = s['id'] as int?;
        if (id != null) _status[id] = 'present';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('All marked Present. Tap Save to store.')));
  }

  Future<void> _save() async {
    if (_date == null) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Select date first'))); return; }
    setState(() => _saving = true);
    try {
      for (final s in _staff) {
        final id = s['id'] as int?;
        if (id == null) continue;
        final status = _status[id] ?? 'present';
        final existing = await Supabase.instance.client.from(SupabaseConfig.tStaffAttendance).select('id').eq('staff_id', id).eq('date', _date!).maybeSingle();
        if (existing != null) {
          await Supabase.instance.client.from(SupabaseConfig.tStaffAttendance).update({'status': status}).eq('id', existing['id']);
        } else {
          await Supabase.instance.client.from(SupabaseConfig.tStaffAttendance).insert({'staff_id': id, 'date': _date!, 'status': status});
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
    _loadStaff();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading && _staff.isEmpty) return Scaffold(appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin'); })), body: const Center(child: CircularProgressIndicator()));
    if (_error != null) return Scaffold(appBar: AppBar(leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin'); })), body: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(_error!), const SizedBox(height: 16), FilledButton(onPressed: _loadStaff, child: const Text('Retry'))])));
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Attendance'),
        leading: IconButton(icon: const Icon(Icons.arrow_back_rounded), onPressed: () { if (Navigator.of(context).canPop()) context.pop(); else context.go('/admin'); }),
      ),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        const SizedBox(height: 16),
        Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
          Expanded(child: ListTile(title: const Text('Date'), subtitle: Text(_date ?? 'Select'), trailing: const Icon(Icons.calendar_today_rounded), onTap: () async { final d = await showDatePicker(context: context, initialDate: _date != null ? DateTime.tryParse(_date!) ?? DateTime.now() : DateTime.now(), firstDate: DateTime(2020), lastDate: DateTime(2030)); if (d != null) setState(() { _date = d.toIso8601String().substring(0, 10); _loadForDate(); }); })),
          TextButton.icon(onPressed: _staff.isEmpty ? null : _markAllPresent, icon: const Icon(Icons.done_all_rounded), label: const Text('Mark all P')),
          FilledButton.icon(onPressed: _saving ? null : _save, icon: _saving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_rounded), label: Text(_saving ? 'Saving...' : 'Save')),
        ]))),
        const SizedBox(height: 16),
        Text('Mark P (Present), A (Absent), L (Leave)', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 8),
        ..._staff.map((s) {
          final id = s['id'] as int?;
          final name = s['full_name'] as String? ?? '—';
          final code = s['employee_code'] as String? ?? '';
          final current = _status[id] ?? 'present';
          return Card(margin: const EdgeInsets.only(bottom: 8), child: Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), child: Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w600)), if (code.isNotEmpty) Text(code, style: Theme.of(context).textTheme.bodySmall)])),
            SegmentedButton<String>(segments: const [ButtonSegment(value: 'present', label: Text('P'), icon: Icon(Icons.check_circle_rounded, size: 18)), ButtonSegment(value: 'absent', label: Text('A'), icon: Icon(Icons.cancel_rounded, size: 18)), ButtonSegment(value: 'leave', label: Text('L'), icon: Icon(Icons.event_busy_rounded, size: 18))], selected: {current}, onSelectionChanged: (v) => _setStatus(id ?? 0, v.first)),
          ])));
        }),
      ]),
    );
  }
}
