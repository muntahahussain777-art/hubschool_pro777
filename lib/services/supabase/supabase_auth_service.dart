import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_service.dart';

class AuthState {
  final User? user;
  final bool loading;
  final String? error;

  const AuthState({this.user, this.loading = false, this.error});

  bool get isLoggedIn => user != null;

  AuthState copyWith({User? user, bool? loading, String? error}) => AuthState(
        user: user ?? this.user,
        loading: loading ?? this.loading,
        error: error,
      );
}

class SupabaseAuthController extends StateNotifier<AuthState> {
  SupabaseAuthController() : super(AuthState(user: supabase.auth.currentUser)) {
    supabase.auth.onAuthStateChange.listen((data) {
      state = state.copyWith(user: data.session?.user, loading: false);
    });
  }

  Future<bool> signIn(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final res = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      state = state.copyWith(user: res.user, loading: false);
      return res.user != null;
    } on AuthException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
      return false;
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
      return false;
    }
  }

  Future<void> signOut() async {
    await supabase.auth.signOut();
    state = const AuthState();
  }

  Future<bool> signUp(String email, String password) async {
    state = state.copyWith(loading: true, error: null);
    try {
      final res = await supabase.auth.signUp(
        email: email,
        password: password,
      );
      state = state.copyWith(user: res.user, loading: false);
      return res.user != null;
    } on AuthException catch (e) {
      state = state.copyWith(loading: false, error: e.message);
      return false;
    }
  }
}

final supabaseAuthProvider =
    StateNotifierProvider<SupabaseAuthController, AuthState>(
  (_) => SupabaseAuthController(),
);
