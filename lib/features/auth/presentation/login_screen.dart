import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../services/biometric/biometric_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  final _passFocus = FocusNode();
  bool _obscure = true;
  bool _loading = false;
  String? _error;

  int _fingerFailCount = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeAutoFingerprint());
  }

  @override
  void dispose() {
    _userCtrl.dispose();
    _passCtrl.dispose();
    _passFocus.dispose();
    super.dispose();
  }

  Future<void> _maybeAutoFingerprint() async {
    final enabled = await biometricService.isFingerprintLoginEnabled();
    if (!enabled) return;
    final available = await biometricService.isAvailable();
    if (!available || !mounted) return;
    await _runFingerprintLogin();
  }

  Future<void> _runFingerprintLogin() async {
    if (!mounted) return;
    final ok = await biometricService.authenticate(reason: 'Login with fingerprint');
    if (!mounted) return;
    if (ok) {
      context.go('/dashboard');
    } else {
      _fingerFailCount++;
      if (_fingerFailCount >= 3) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Fingerprint failed. Please use password.'),
          behavior: SnackBarBehavior.floating,
        ));
        FocusScope.of(context).requestFocus(_passFocus);
      }
    }
  }

  Future<void> _login() async {
    final user = _userCtrl.text.trim();
    final pass = _passCtrl.text.trim();
    if (user.isEmpty || pass.isEmpty) {
      setState(() => _error = 'Username aur password daalen');
      return;
    }
    setState(() { _loading = true; _error = null; });
    await Future.delayed(const Duration(milliseconds: 400));

    if (user == 'admin' && (pass == 'admin123' || pass == 'admin123@')) {
      if (mounted) {
        _loading = false;
        context.go('/dashboard');
      }
    } else {
      setState(() { _loading = false; _error = 'Ghalat username ya password'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.bg, Color(0xFF0D1630), AppColors.bg],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(28),
              child: Column(
                children: [
                  Container(
                    width: 90, height: 90,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryLight]),
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 24, offset: const Offset(0, 8))],
                    ),
                    child: const Icon(Icons.school_rounded, color: Colors.white, size: 48),
                  ).animate().scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 600.ms, curve: Curves.elasticOut),
                  const SizedBox(height: 20),
                  const Text('HubSchool Pro', style: TextStyle(color: AppColors.textPrimary, fontSize: 32, fontWeight: FontWeight.w800))
                      .animate(delay: 200.ms).fadeIn(duration: 400.ms).slideY(begin: 0.3, end: 0),
                  const SizedBox(height: 6),
                  const Text('Offline-First School ERP', style: TextStyle(color: AppColors.textSecondary, fontSize: 13))
                      .animate(delay: 300.ms).fadeIn(),
                  const SizedBox(height: 40),
                  GlassCard(
                    borderColor: AppColors.primary.withOpacity(0.3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Welcome Back', style: TextStyle(color: AppColors.textPrimary, fontSize: 22, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 24),
                        TextField(
                          controller: _userCtrl,
                          style: const TextStyle(color: AppColors.textPrimary),
                          decoration: const InputDecoration(labelText: 'Username', prefixIcon: Icon(Icons.person_rounded, color: AppColors.primary, size: 20)),
                        ),
                        const SizedBox(height: 14),
                        TextField(
                          controller: _passCtrl,
                          focusNode: _passFocus,
                          obscureText: _obscure,
                          style: const TextStyle(color: AppColors.textPrimary),
                          onSubmitted: (_) => _login(),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: const Icon(Icons.lock_rounded, color: AppColors.primary, size: 20),
                            suffixIcon: IconButton(
                              icon: Icon(_obscure ? Icons.visibility_off_rounded : Icons.visibility_rounded, color: AppColors.textMuted, size: 18),
                              onPressed: () => setState(() => _obscure = !_obscure),
                            ),
                          ),
                        ),
                        if (_error != null) ...[
                          const SizedBox(height: 12),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                            child: Text(_error!, style: const TextStyle(color: AppColors.error, fontSize: 12)),
                          ),
                        ],
                        const SizedBox(height: 28),
                        SizedBox(
                          width: double.infinity, height: 52,
                          child: ElevatedButton(
                            onPressed: _loading ? null : _login,
                            child: _loading
                                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2.5))
                                : const Text('Login', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                          ),
                        ),
                        const SizedBox(height: 26),
                        Center(
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                            const SizedBox(width: 6),
                            const Text('100% Offline · No internet required', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
                          ]),
                        ),
                      ],
                    ),
                  ).animate(delay: 400.ms).fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
