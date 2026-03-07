import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/roles.dart';

/// Dual login: Supabase (email + password) OR username "admin" + password "admin123@".
/// In Supabase Auth create user: email = admin@hubschool.local, password = admin123@,
/// and set User Metadata: { "role": "admin" }.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailOrUserCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _loading = false;
  bool _obscurePassword = true;
  String? _error;

  static const String _adminUsername = 'admin';
  static const String _adminEmail = 'admin@hubschool.local';

  @override
  void dispose() {
    _emailOrUserCtrl.dispose();
    _passCtrl.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final emailOrUser = _emailOrUserCtrl.text.trim();
      final password = _passCtrl.text;

      String email = emailOrUser;
      if (!emailOrUser.contains('@')) {
        if (emailOrUser.toLowerCase() == _adminUsername) {
          email = _adminEmail;
        } else {
          if (mounted) setState(() => _error = 'Use email or username: $_adminUsername');
          return;
        }
      }

      await Supabase.instance.client.auth.signInWithPassword(
        email: email,
        password: password,
      );
      final role = _getRole();
      if (mounted) context.go(role?.dashboardPath ?? '/admin');
    } on AuthException catch (e) {
      if (mounted) setState(() => _error = e.message);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  AppRole? _getRole() {
    final role = Supabase.instance.client.auth.currentSession?.user.userMetadata?['role'] as String?;
    return roleFromString(role);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'HubSchool Pro',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in with Email or Username',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  TextField(
                    controller: _emailOrUserCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Email or Username',
                      hintText: 'e.g. admin or your@email.com',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _passCtrl,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock_outline_rounded),
                      suffixIcon: IconButton(
                        icon: Icon(_obscurePassword ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                        onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                      ),
                    ),
                    obscureText: _obscurePassword,
                    onSubmitted: (_) => _login(),
                  ),
                  if (_error != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      _error!,
                      style: TextStyle(color: Theme.of(context).colorScheme.error, fontSize: 12),
                    ),
                  ],
                  const SizedBox(height: 24),
                  FilledButton(
                    onPressed: _loading ? null : _login,
                    child: _loading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Sign in'),
                  ),
                  const SizedBox(height: 16),
                  TextButton(
                    onPressed: () => context.go('/'),
                    child: const Text('Back to website'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
