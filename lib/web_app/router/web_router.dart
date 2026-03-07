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
import '../features/public/blog_article_page.dart';
import '../features/public/admissions_page.dart';
import '../features/admin/admin_dashboard_page.dart';
import '../features/admin/students_list_page.dart';
import '../features/admin/student_form_page.dart';
import '../features/admin/classrooms_list_page.dart';
import '../features/admin/classroom_form_page.dart';
import '../features/admin/staff_list_page.dart';
import '../features/admin/staff_form_page.dart';
import '../features/admin/subjects_list_page.dart';
import '../features/admin/subject_form_page.dart';
import '../features/admin/fee_heads_list_page.dart';
import '../features/admin/fee_head_form_page.dart';
import '../features/admin/expenses_list_page.dart';
import '../features/admin/expense_form_page.dart';
import '../features/admin/fee_invoices_list_page.dart';
import '../features/admin/fee_invoice_add_page.dart';
import '../features/admin/fee_invoice_detail_page.dart';
import '../features/admin/exams_list_page.dart';
import '../features/admin/exam_form_page.dart';
import '../features/admin/exam_marks_page.dart';
import '../features/admin/exam_components_page.dart';
import '../features/admin/reports_page.dart';
import '../features/admin/staff_attendance_page.dart';
import '../features/admin/student_attendance_page.dart';
import '../features/admin/news_list_page.dart';
import '../features/admin/news_form_page.dart';
import '../features/admin/blog_list_page.dart';
import '../features/admin/blog_form_page.dart';
import '../features/admin/announcements_list_page.dart';
import '../features/admin/announcement_form_page.dart';
import '../features/admin/settings_page.dart';
import '../features/admin/user_management_page.dart';
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
    GoRoute(path: '/blog/:slug', builder: (_, state) => BlogArticlePage(slug: state.pathParameters['slug'] ?? '')),
    GoRoute(path: '/login', builder: (_, __) => const LoginPage()),

    // Role-based dashboard shells (sub-routes show same dashboard for now)
    ShellRoute(
      builder: (_, __, child) => DashboardLayout(child: child),
      routes: [
        GoRoute(path: '/admin', builder: (_, __) => const AdminDashboardPage()),
        GoRoute(path: '/admin/students', builder: (_, __) => const StudentsListPage()),
        GoRoute(path: '/admin/students/add', builder: (_, __) => const StudentFormPage()),
        GoRoute(path: '/admin/students/edit/:id', builder: (_, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0;
          return StudentFormPage(studentId: id > 0 ? id : null);
        }),
        GoRoute(path: '/admin/teachers', builder: (_, __) => const StaffListPage()),
        GoRoute(path: '/admin/teachers/add', builder: (_, __) => const StaffFormPage()),
        GoRoute(path: '/admin/teachers/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return StaffFormPage(id: id); }),
        GoRoute(path: '/admin/classes', builder: (_, __) => const ClassroomsListPage()),
        GoRoute(path: '/admin/classes/add', builder: (_, __) => const ClassroomFormPage()),
        GoRoute(path: '/admin/classes/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return ClassroomFormPage(id: id); }),
        GoRoute(path: '/admin/subjects', builder: (_, __) => const SubjectsListPage()),
        GoRoute(path: '/admin/subjects/add', builder: (_, __) => const SubjectFormPage()),
        GoRoute(path: '/admin/subjects/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return SubjectFormPage(id: id); }),
        GoRoute(path: '/admin/fee-heads', builder: (_, __) => const FeeHeadsListPage()),
        GoRoute(path: '/admin/fee-heads/add', builder: (_, __) => const FeeHeadFormPage()),
        GoRoute(path: '/admin/fee-heads/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return FeeHeadFormPage(id: id); }),
        GoRoute(path: '/admin/expenses', builder: (_, __) => const ExpensesListPage()),
        GoRoute(path: '/admin/expenses/add', builder: (_, __) => const ExpenseFormPage()),
        GoRoute(path: '/admin/expenses/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return ExpenseFormPage(id: id != null && id > 0 ? id : null); }),
        GoRoute(path: '/admin/fees', builder: (_, __) => const FeeInvoicesListPage()),
        GoRoute(path: '/admin/fees/add', builder: (_, __) => const FeeInvoiceAddPage()),
        GoRoute(path: '/admin/fees/invoice/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0; return FeeInvoiceDetailPage(invoiceId: id); }),
        GoRoute(path: '/admin/exams', builder: (_, __) => const ExamsListPage()),
        GoRoute(path: '/admin/exams/add', builder: (_, __) => const ExamFormPage()),
        GoRoute(path: '/admin/exams/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return ExamFormPage(id: id); }),
        GoRoute(path: '/admin/exams/:id/components', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0; return ExamComponentsPage(examId: id); }),
        GoRoute(path: '/admin/exams/:id/marks', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? '') ?? 0; return ExamMarksPage(examId: id); }),
        GoRoute(path: '/admin/reports', builder: (_, __) => const ReportsPage()),
        GoRoute(path: '/admin/staff-attendance', builder: (_, __) => const StaffAttendancePage()),
        GoRoute(path: '/admin/student-attendance', builder: (_, __) => const StudentAttendancePage()),
        GoRoute(path: '/admin/news', builder: (_, __) => const NewsListPage()),
        GoRoute(path: '/admin/news/add', builder: (_, __) => const NewsFormPage()),
        GoRoute(path: '/admin/news/edit/:id', builder: (_, state) { final id = int.tryParse(state.pathParameters['id'] ?? ''); return NewsFormPage(id: id != null && id > 0 ? id : null); }),
        GoRoute(path: '/admin/blog', builder: (_, __) => const BlogListPage()),
        GoRoute(path: '/admin/blog/new', builder: (_, __) => const BlogFormPage()),
        GoRoute(path: '/admin/blog/edit/:id', builder: (_, state) => BlogFormPage(id: state.pathParameters['id'])),
        GoRoute(path: '/admin/announcements', builder: (_, __) => const AnnouncementsListPage()),
        GoRoute(path: '/admin/announcements/new', builder: (_, __) => const AnnouncementFormPage()),
        GoRoute(path: '/admin/announcements/edit/:id', builder: (_, state) => AnnouncementFormPage(id: state.pathParameters['id'])),
        GoRoute(path: '/admin/users', builder: (_, __) => const UserManagementPage()),
        GoRoute(path: '/admin/settings', builder: (_, __) => const SettingsPage()),
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
