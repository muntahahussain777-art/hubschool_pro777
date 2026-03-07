import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../config/supabase_config.dart';

/// User management: create (Supabase Auth + role in metadata + app_user_profiles), list, edit, delete from list.
class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  String _role = 'teacher';
  bool _loading = false;
  bool _obscurePassword = true;
  List<Map<String, dynamic>> _users = [];
  bool _loadingList = true;
  String? _listError;

  Future<void> _loadUsers() async {
    setState(() { _loadingList = true; _listError = null; });
    try {
      final res = await Supabase.instance.client.from(SupabaseConfig.tAppUserProfiles).select().order('created_at', ascending: false);
      if (mounted) setState(() { _users = List<Map<String, dynamic>>.from(res); _loadingList = false; });
    } catch (e) {
      if (mounted) setState(() { _listError = e.toString(); _loadingList = false; });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _createUser() async {
    final email = _emailCtrl.text.trim();
    final password = _passwordCtrl.text.trim();
    if (email.isEmpty) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Email required'))); return; }
    if (password.length < 6) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be at least 6 characters'))); return; }
    setState(() => _loading = true);
    try {
      final res = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
        data: {'role': _role},
      );
      if (res.user != null) {
        try {
          await Supabase.instance.client.from(SupabaseConfig.tAppUserProfiles).insert({
            'id': res.user!.id,
            'email': email,
            'role': _role,
          });
        } catch (_) {}
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('User created: $email. They can log in with this email and password. Role: $_role')));
          _emailCtrl.clear();
          _passwordCtrl.clear();
          _loadUsers();
        }
      } else {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User created. If email confirmation is enabled, they must confirm before logging in.')));
        _emailCtrl.clear();
        _passwordCtrl.clear();
        _loadUsers();
      }
    } on AuthException catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _updateUser(String id, String email, String role) async {
    try {
      await Supabase.instance.client.from(SupabaseConfig.tAppUserProfiles).update({'email': email, 'role': role, 'updated_at': DateTime.now().toIso8601String()}).eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User updated'))); _loadUsers(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> _deleteUser(String id, String email) async {
    final ok = await showDialog<bool>(context: context, builder: (ctx) => AlertDialog(
      title: const Text('Remove user'),
      content: Text('Remove "$email" from the list? They will no longer appear here. To fully remove login, use Supabase Dashboard → Authentication.'),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Remove'))],
    ));
    if (ok != true) return;
    try {
      await Supabase.instance.client.from(SupabaseConfig.tAppUserProfiles).delete().eq('id', id);
      if (mounted) { ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('User removed from list'))); _loadUsers(); }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(24),
      children: [
        Text('User Management', style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text('Create users; they can log in with email and password. Role is stored and used for dashboard access.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 24),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Create new user', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailCtrl,
                  decoration: const InputDecoration(labelText: 'Email *', border: OutlineInputBorder()),
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _passwordCtrl,
                  decoration: InputDecoration(
                    labelText: 'Password * (min 6 characters)',
                    border: const OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(_obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  obscureText: _obscurePassword,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: _role,
                  decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()),
                  items: const [
                    DropdownMenuItem(value: 'admin', child: Text('Admin')),
                    DropdownMenuItem(value: 'teacher', child: Text('Teacher')),
                    DropdownMenuItem(value: 'operator', child: Text('Operator')),
                    DropdownMenuItem(value: 'parent', child: Text('Parent')),
                  ],
                  onChanged: (v) => setState(() => _role = v ?? 'teacher'),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: _loading ? null : _createUser,
                  icon: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.person_add_rounded),
                  label: Text(_loading ? 'Creating...' : 'Create user'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text('Users', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        if (_loadingList)
          const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator()))
        else if (_listError != null)
          Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(children: [Text(_listError!), const SizedBox(height: 8), TextButton(onPressed: _loadUsers, child: const Text('Retry'))])))
        else if (_users.isEmpty)
          const Card(child: Padding(padding: EdgeInsets.all(24), child: Text('No users in list. Create a user above. (Run the app_user_profiles migration in Supabase to enable listing.)')))
        else
          ..._users.map((u) {
            final id = u['id']?.toString();
            final email = u['email'] as String? ?? '-';
            final role = u['role'] as String? ?? '-';
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(email),
                subtitle: Text('Role: $role'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit_rounded), onPressed: () async {
                      final emailCtrl = TextEditingController(text: email);
                      String selRole = role;
                      final result = await showDialog<Map<String, dynamic>>(context: context, builder: (ctx) => StatefulBuilder(
                        builder: (ctx, setDialog) => AlertDialog(
                          title: const Text('Edit user'),
                          content: Column(mainAxisSize: MainAxisSize.min, children: [
                            TextField(controller: emailCtrl, decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder())),
                            const SizedBox(height: 12),
                            DropdownButtonFormField<String>(value: selRole, decoration: const InputDecoration(labelText: 'Role', border: OutlineInputBorder()), items: const [DropdownMenuItem(value: 'admin', child: Text('Admin')), DropdownMenuItem(value: 'teacher', child: Text('Teacher')), DropdownMenuItem(value: 'operator', child: Text('Operator')), DropdownMenuItem(value: 'parent', child: Text('Parent'))], onChanged: (v) => setDialog(() => selRole = v ?? selRole)),
                          ]),
                          actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')), FilledButton(onPressed: () => Navigator.pop(ctx, {'email': emailCtrl.text.trim(), 'role': selRole}), child: const Text('Save'))],
                        ),
                      ));
                      if (result != null && id != null) await _updateUser(id, result['email'] as String? ?? email, result['role'] as String? ?? role);
                    }),
                    IconButton(icon: Icon(Icons.delete_rounded, color: Theme.of(context).colorScheme.error), onPressed: id != null ? () => _deleteUser(id, email) : null),
                  ],
                ),
              ),
            );
          }),
        const SizedBox(height: 24),
        Card(
          child: const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Password reset', style: TextStyle(fontWeight: FontWeight.w600)),
                SizedBox(height: 8),
                Text('Use Supabase Dashboard → Authentication → Users → select user → Send password recovery.'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
