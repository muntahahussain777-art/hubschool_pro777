import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/roles.dart';
import '../features/auth/login_page.dart';
import '../features/public/home_page.dart';
import '../features/public/about_page.dart';
import '../features/public/contact_page.dart';
import '../features/public/news_page.dart';
import '../features/public/blog_page.dart';
import '../features/public/admissions_page.dart';
import '../features/admin/admin_dashboard_page.dart';
import '../features/teacher/teacher_dashboard_page.dart';
import '../features/operator/operator_dashboard_page.dart';
import '../features/parent/parent_dashboard_page.dart';
import '../layout/dashboard_layout.dart';

final webRouter = GoRouter(
  initialLocation: '/',
  refreshListenable: _AuthNotifier(),
  redirect: (BuildContext context, GoRouterState state) {
    final session = Supabase.instance.client.auth.currentSession;
    final isPublic = _isPublicRoute(state.uri.path);
    if (session == null) {
      if (isPublic) return null;
      return '/login';
    }
    if (state.uri.path == '/login') {
      final role = _getRole();
      return role?.dashboardPath ?? '/admin';
    }
    if (_isDashboardRoute(state.uri.path)) {
      final role = _getRole();
      final allowed = _allowedForRole(role, state.uri.path);
      if (!allowed) return role?.dashboardPath ?? '/login';
    }
    return null;
  },
  routes: [
    // Public – School website
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
    GoRoute(path: '/admissions', builder: (_, __) => const AdmissionsPage()),
    GoRoute(path: '/contact', builder: (_, __) => const ContactPage()),
    GoRoute(path: '/news', builder: (_, __) => const NewsPage()),
    GoRoute(path: '/blog', builder: (_, __) => const BlogPage()),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),

    // Role-based dashboard shells (sub-routes show same dashboard for now)
    ShellRoute(
      builder: (_, __, child) => DashboardLayout(child: child),
      routes: [
        GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/students', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/teachers', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/classes', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/exams', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/fees', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/reports', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/news', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/settings', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/teacher', builder: (_, __) => const TeacherDashboardPage()),
        GoRoute(path: '/teacher/classes', builder: (_, __) => const TeacherDashboardPage()),
        GoRoute(path: '/teacher/attendance', builder: (_, __) => const TeacherDashboardPage()),
        GoRoute(path: '/teacher/marks', builder: (_, __) => const TeacherDashboardPage()),
        GoRoute(path: '/operator', builder: (_, __) => const OperatorDashboardPage()),
        GoRoute(path: '/operator/students', builder: (_, __) => const OperatorDashboardPage()),
        GoRoute(path: '/operator/id-cards', builder: (_, __) => const OperatorDashboardPage()),
        GoRoute(path: '/operator/fee-slips', builder: (_, __) => const OperatorDashboardPage()),
        GoRoute(path: '/parent', builder: (_, __) => const ParentDashboardPage()),
        GoRoute(path: '/parent/child', builder: (_, __) => const ParentDashboardPage()),
        GoRoute(path: '/parent/attendance', builder: (_, __) => const ParentDashboardPage()),
        GoRoute(path: '/parent/results', builder: (_, __) => const ParentDashboardPage()),
        GoRoute(path: '/parent/fees', builder: (_, __) => const ParentDashboardPage()),
        GoRoute(path: '/parent/news', builder: (_, __) => const ParentDashboardPage()),
      ],
    ),
  ],
);

bool _isPublicRoute(String path) {
  return path == '/' ||
      path == '/about' ||
      path == '/admissions' ||
      path == '/contact' ||
      path == '/news' ||
      path == '/blog' ||
      path.startsWith('/news/') ||
      path.startsWith('/blog/');
}

bool _isDashboardRoute(String path) {
  return path.startsWith('/admin') ||
      path.startsWith('/teacher') ||
      path.startsWith('/operator') ||
      path.startsWith('/parent');
}

bool _allowedForRole(AppRole? role, String path) {
  if (role == null) return false;
  if (path.startsWith('/admin') && role == AppRole.admin) return true;
  if (path.startsWith('/teacher') && role == AppRole.teacher) return true;
  if (path.startsWith('/operator') && role == AppRole.operator) return true;
  if (path.startsWith('/parent') && role == AppRole.parent) return true;
  return false;
}

AppRole? _getRole() {
  final session = Supabase.instance.client.auth.currentSession;
  final role = session?.user.userMetadata?['role'] as String?;
  return roleFromString(role);
}

class _AuthNotifier extends ChangeNotifier {
  _AuthNotifier() {
    Supabase.instance.client.auth.onAuthStateChange.listen((_) => notifyListeners());
  }
}
