import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../config/supabase_config.dart';

/// Call once inside main() before runApp
Future<void> initSupabase() async {
  await Supabase.initialize(
    url: SupabaseConfig.url,
    anonKey: SupabaseConfig.anonKey,
    debug: false,
  );
}

/// Global Supabase client
SupabaseClient get supabase => Supabase.instance.client;

/// Riverpod provider
final supabaseClientProvider = Provider<SupabaseClient>((_) => supabase);
