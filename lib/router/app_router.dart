import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../core/theme/app_theme.dart';
import '../data/local/school_database.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/dashboard/presentation/dashboard_screen.dart';
import '../features/expenses/presentation/expenses_screen.dart';
import '../features/exams/presentation/exams_screen.dart';
import '../features/fees/presentation/fees_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/reports/presentation/reports_screen.dart';
import '../features/academics/presentation/academics_screen.dart';
import '../features/tools/presentation/ocr_screen.dart';
import '../features/tools/presentation/scanner_screen.dart';
import '../features/staff/presentation/staff_screen.dart';
import '../features/staff/presentation/voice_attendance_screen.dart';
import '../features/students/presentation/add_student_screen.dart';
import '../features/students/presentation/students_screen.dart';
import '../features/students/presentation/student_attendance_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/students', builder: (_, __) => const StudentsScreen()),
        GoRoute(path: '/students/add', builder: (_, state) => AddStudentScreen(student: state.extra is Student ? state.extra as Student : null)),
        GoRoute(path: '/fees', builder: (_, __) => const FeesScreen()),
        GoRoute(path: '/exams', builder: (_, __) => const ExamsScreen()),
        GoRoute(path: '/staff', builder: (_, __) => const StaffScreen()),
        GoRoute(path: '/expenses', builder: (_, __) => const ExpensesScreen()),
        GoRoute(path: '/expenses/add', builder: (_, __) => const ExpensesScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
        GoRoute(path: '/voice-attendance', builder: (_, __) => const VoiceAttendanceScreen()),
        GoRoute(path: '/student-attendance', builder: (_, __) => const StudentAttendanceScreen()),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
        GoRoute(path: '/academics', builder: (_, __) => const AcademicsScreen()),
        GoRoute(path: '/ocr', builder: (_, __) => const OcrScreen()),
        GoRoute(path: '/scanner', builder: (_, __) => const ScannerScreen()),
      ],
    ),
  ],
);

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});
  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  static const _destinations = [
    (icon: Icons.dashboard_rounded, label: 'Dashboard', path: '/dashboard'),
    (icon: Icons.school_rounded, label: 'Students', path: '/students'),
    (icon: Icons.payments_rounded, label: 'Fees', path: '/fees'),
    (icon: Icons.badge_rounded, label: 'Staff', path: '/staff'),
    (icon: Icons.settings_rounded, label: 'Settings', path: '/settings'),
  ];

  void _onNavTap(int index) {
    setState(() => _currentIndex = index);
    context.go(_destinations[index].path);
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    final activeIndex = _destinations.indexWhere((d) => location.startsWith(d.path));
    if (activeIndex >= 0 && activeIndex != _currentIndex) {
      _currentIndex = activeIndex;
    }

    return Scaffold(
      body: widget.child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex.clamp(0, _destinations.length - 1),
        onDestinationSelected: _onNavTap,
        destinations: _destinations.map((d) => NavigationDestination(icon: Icon(d.icon), label: d.label)).toList(),
      ),
    );
  }
}
