import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'router/app_router.dart';
import 'services/supabase/supabase_service.dart';
import 'services/supabase/supabase_sync_service.dart';
import 'services/sync/sync_worker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try { await initSupabase(); } catch (_) {}
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.surface,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  try { await initSyncWorker(); } catch (_) {}

  runApp(const ProviderScope(child: HubSchoolApp()));
}

class HubSchoolApp extends ConsumerStatefulWidget {
  const HubSchoolApp({super.key});
  @override
  ConsumerState<HubSchoolApp> createState() => _HubSchoolAppState();
}

class _HubSchoolAppState extends ConsumerState<HubSchoolApp> {
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((results) {
      if (!results.contains(ConnectivityResult.none)) {
        try { ref.read(supabaseSyncProvider).syncAll(); } catch (_) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HubSchool Pro',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: appRouter,
    );
  }
}
