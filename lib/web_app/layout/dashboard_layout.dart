import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../config/roles.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

class _DashboardLayoutState extends State<DashboardLayout> {
  bool _sidebarCollapsed = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  static const double _breakpoint = 720;

  @override
  Widget build(BuildContext context) {
    final role = _getRole();
    final isNarrow = MediaQuery.of(context).size.width < _breakpoint;
    final path = GoRouterState.of(context).uri.path;
    return Scaffold(
      key: _scaffoldKey,
      appBar: _AppBar(
        onLogout: _logout,
        onMenuTap: isNarrow ? () => _scaffoldKey.currentState?.openDrawer() : null,
      ),
      drawer: isNarrow
          ? Drawer(
              child: _Sidebar(
                collapsed: false,
                role: role,
                onToggle: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: Row(
        children: [
          if (!isNarrow)
            _Sidebar(
              collapsed: _sidebarCollapsed,
              role: role,
              onToggle: () => setState(() => _sidebarCollapsed = !_sidebarCollapsed),
            ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width < 600 ? 12 : 24,
                          vertical: MediaQuery.of(context).size.width < 600 ? 8 : 16,
                        ),
                        child: widget.child,
                      ),
                    ),
                  ),
                ),
                if (isNarrow && role == AppRole.admin) _BottomNav(path: path, onMoreTap: () => _scaffoldKey.currentState?.openDrawer()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  AppRole? _getRole() {
    final role = Supabase.instance.client.auth.currentSession?.user.userMetadata?['role'] as String?;
    return roleFromString(role);
  }

  void _logout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) context.go('/login');
  }
}

class _Sidebar extends StatelessWidget {
  final bool collapsed;
  final AppRole? role;
  final VoidCallback onToggle;

  const _Sidebar({
    required this.collapsed,
    required this.role,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final navItems = _navItemsForRole(role);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: collapsed ? 72 : 260,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: Border(
          right: BorderSide(color: Theme.of(context).dividerColor.withOpacity(0.5)),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          IconButton(
            onPressed: onToggle,
            icon: Icon(collapsed ? Icons.menu_rounded : Icons.menu_open_rounded),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: navItems.length,
              itemBuilder: (context, i) {
                final e = navItems[i];
                return _NavTile(label: e.label, icon: e.icon, path: e.path, collapsed: collapsed);
              },
            ),
          ),
          if (!collapsed)
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                _roleLabel(role),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
        ],
      ),
    );
  }

  String _roleLabel(AppRole? r) {
    if (r == null) return 'User';
    switch (r) {
      case AppRole.admin:
        return 'Admin Panel';
      case AppRole.teacher:
        return 'Teacher Panel';
      case AppRole.operator:
        return 'Operator Panel';
      case AppRole.parent:
        return 'Parent Panel';
    }
  }

  List<({String label, IconData icon, String path})> _navItemsForRole(AppRole? r) {
    switch (r) {
      case AppRole.admin:
        return [
          (label: 'Dashboard', icon: Icons.dashboard_rounded, path: '/admin'),
          (label: 'Students', icon: Icons.school_rounded, path: '/admin/students'),
          (label: 'Teachers', icon: Icons.badge_rounded, path: '/admin/teachers'),
          (label: 'Classes', icon: Icons.class_rounded, path: '/admin/classes'),
          (label: 'Subjects', icon: Icons.menu_book_rounded, path: '/admin/subjects'),
          (label: 'Exams', icon: Icons.assignment_rounded, path: '/admin/exams'),
          (label: 'Fees', icon: Icons.payments_rounded, path: '/admin/fees'),
          (label: 'Fee Heads', icon: Icons.list_alt_rounded, path: '/admin/fee-heads'),
          (label: 'Expenses', icon: Icons.receipt_long_rounded, path: '/admin/expenses'),
          (label: 'Staff Attendance', icon: Icons.how_to_reg_rounded, path: '/admin/staff-attendance'),
          (label: 'Student Attendance', icon: Icons.people_rounded, path: '/admin/student-attendance'),
          (label: 'Reports', icon: Icons.assessment_rounded, path: '/admin/reports'),
          (label: 'Blog & News', icon: Icons.article_rounded, path: '/admin/blog'),
          (label: 'Announcements', icon: Icons.campaign_rounded, path: '/admin/announcements'),
          (label: 'User Management', icon: Icons.people_rounded, path: '/admin/users'),
          (label: 'Settings', icon: Icons.settings_rounded, path: '/admin/settings'),
        ];
      case AppRole.teacher:
        return [
          (label: 'Dashboard', icon: Icons.dashboard_rounded, path: '/teacher'),
          (label: 'My Classes', icon: Icons.class_rounded, path: '/teacher/classes'),
          (label: 'Attendance', icon: Icons.how_to_reg_rounded, path: '/teacher/attendance'),
          (label: 'Exam Marks', icon: Icons.edit_note_rounded, path: '/teacher/marks'),
        ];
      case AppRole.operator:
        return [
          (label: 'Dashboard', icon: Icons.dashboard_rounded, path: '/operator'),
          (label: 'Students', icon: Icons.school_rounded, path: '/operator/students'),
          (label: 'ID Cards', icon: Icons.badge_rounded, path: '/operator/id-cards'),
          (label: 'Fee Slips', icon: Icons.receipt_rounded, path: '/operator/fee-slips'),
        ];
      case AppRole.parent:
        return [
          (label: 'Dashboard', icon: Icons.dashboard_rounded, path: '/parent'),
          (label: 'My Child', icon: Icons.person_rounded, path: '/parent/child'),
          (label: 'Attendance', icon: Icons.how_to_reg_rounded, path: '/parent/attendance'),
          (label: 'Results', icon: Icons.assignment_rounded, path: '/parent/results'),
          (label: 'Fee Status', icon: Icons.payments_rounded, path: '/parent/fees'),
          (label: 'News', icon: Icons.article_rounded, path: '/parent/news'),
        ];
      default:
        return [
          (label: 'Dashboard', icon: Icons.dashboard_rounded, path: '/admin'),
        ];
    }
  }
}

class _NavTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final String path;
  final bool collapsed;

  const _NavTile({
    required this.label,
    required this.icon,
    required this.path,
    required this.collapsed,
  });

  @override
  Widget build(BuildContext context) {
    final active = GoRouterState.of(context).uri.path == path ||
        (path != '/admin' && path != '/teacher' && path != '/operator' && path != '/parent' &&
            GoRouterState.of(context).uri.path.startsWith(path));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: ListTile(
        leading: Icon(icon, size: 22),
        title: collapsed ? null : Text(label, style: const TextStyle(fontSize: 14)),
        selected: active,
        onTap: () => context.go(path),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  final String path;
  final VoidCallback? onMoreTap;

  const _BottomNav({required this.path, this.onMoreTap});

  @override
  Widget build(BuildContext context) {
    int selected = 0;
    if (path.startsWith('/admin/students')) selected = 1;
    else if (path.startsWith('/admin/fees')) selected = 2;
    else if (path.startsWith('/admin/exams')) selected = 3;
    else if (path == '/admin') selected = 0;
    return NavigationBar(
      selectedIndex: selected,
      onDestinationSelected: (i) {
        switch (i) {
          case 0: context.go('/admin'); break;
          case 1: context.go('/admin/students'); break;
          case 2: context.go('/admin/fees'); break;
          case 3: context.go('/admin/exams'); break;
          case 4: onMoreTap?.call(); break;
        }
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.school_rounded), label: 'Students'),
        NavigationDestination(icon: Icon(Icons.payments_rounded), label: 'Fees'),
        NavigationDestination(icon: Icon(Icons.assignment_rounded), label: 'Exams'),
        NavigationDestination(icon: Icon(Icons.menu_rounded), label: 'More'),
      ],
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onLogout;
  final VoidCallback? onMenuTap;

  const _AppBar({required this.onLogout, this.onMenuTap});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: onMenuTap != null
          ? IconButton(icon: const Icon(Icons.menu_rounded), onPressed: onMenuTap)
          : null,
      title: Text(
        'HubSchool Pro',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
      ),
      actions: [
        IconButton(icon: const Icon(Icons.dark_mode_rounded), onPressed: () {}),
        IconButton(icon: const Icon(Icons.logout_rounded), onPressed: onLogout),
      ],
    );
  }
}
