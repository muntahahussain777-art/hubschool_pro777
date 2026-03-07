import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/web_router.dart';
import 'theme/web_theme.dart';
import 'theme_provider.dart';

/// VIP Web Application – loads only on web platform.
/// Role-based panels: Admin, Teacher, Computer Operator, Parents.
/// Public school website: Home, About, Admissions, Contact, News, Blog.
class WebApp extends ConsumerWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    return MaterialApp.router(
      title: 'HubSchool Pro',
      debugShowCheckedModeBanner: false,
      theme: WebTheme.light,
      darkTheme: WebTheme.dark,
      themeMode: themeMode,
      routerConfig: webRouter,
    );
  }
}
