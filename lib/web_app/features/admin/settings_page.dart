import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';
import '../../theme_provider.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  int _passPercentage = 40;
  bool _loadingPass = true;
  bool _savingPass = false;

  Future<void> _loadPassPercentage() async {
    try {
      final r = await Supabase.instance.client.from(SupabaseConfig.tAppSettings).select('value').eq('key', 'pass_percentage').maybeSingle();
      if (r != null && mounted) {
        final v = int.tryParse(r['value']?.toString() ?? '');
        if (v != null && v >= 0 && v <= 100) setState(() => _passPercentage = v);
      }
    } catch (_) {}
    if (mounted) setState(() => _loadingPass = false);
  }

  Future<void> _savePassPercentage() async {
    setState(() => _savingPass = true);
    try {
      await Supabase.instance.client.from(SupabaseConfig.tAppSettings).upsert({'key': 'pass_percentage', 'value': _passPercentage.toString()}, onConflict: 'key');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pass percentage saved')));
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _savingPass = false);
    }
  }

  @override
  void initState() {
    super.initState();
    _loadPassPercentage();
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = ref.watch(themeModeProvider);
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('Settings', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Appearance', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 12),
                SegmentedButton<ThemeMode>(
                  segments: const [
                    ButtonSegment(value: ThemeMode.light, icon: Icon(Icons.light_mode_rounded), label: Text('Light')),
                    ButtonSegment(value: ThemeMode.dark, icon: Icon(Icons.dark_mode_rounded), label: Text('Dark')),
                    ButtonSegment(value: ThemeMode.system, icon: Icon(Icons.brightness_auto_rounded), label: Text('System')),
                  ],
                  selected: {themeMode},
                  onSelectionChanged: (s) => ref.read(themeModeProvider.notifier).state = s.first,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Exams & Marksheet', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text('Default pass percentage. Result/marksheet will show Pass if student percentage ≥ this value.', style: Theme.of(context).textTheme.bodySmall),
                const SizedBox(height: 12),
                if (_loadingPass)
                  const SizedBox(height: 48, child: Center(child: CircularProgressIndicator()))
                else
                  Row(
                    children: [
                      DropdownButton<int>(
                        value: [33, 40, 50, 60].contains(_passPercentage) ? _passPercentage : 40,
                        items: [33, 40, 50, 60].map((v) => DropdownMenuItem(value: v, child: Text('$v%'))).toList(),
                        onChanged: (v) => setState(() => _passPercentage = v ?? 40),
                      ),
                      const SizedBox(width: 16),
                      FilledButton(
                        onPressed: _savingPass ? null : _savePassPercentage,
                        child: _savingPass ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
