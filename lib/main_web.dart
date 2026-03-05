// Web-only entry point. Use: flutter build web -t lib/main_web.dart
// Avoids pulling in Drift/SQLite (dart:ffi) which is not available on web.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/supabase/supabase_service.dart';
import 'web_app/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await initSupabase();
  } catch (_) {}
  runApp(const ProviderScope(child: WebApp()));
}
