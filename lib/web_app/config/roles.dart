/// Role names – must match Supabase `users.role` or auth user_metadata.
enum AppRole {
  admin,
  teacher,
  operator,
  parent,
}

extension AppRoleExt on AppRole {
  String get value {
    switch (this) {
      case AppRole.admin:
        return 'admin';
      case AppRole.teacher:
        return 'teacher';
      case AppRole.operator:
        return 'operator';
      case AppRole.parent:
        return 'parent';
    }
  }

  String get dashboardPath {
    switch (this) {
      case AppRole.admin:
        return '/admin';
      case AppRole.teacher:
        return '/teacher';
      case AppRole.operator:
        return '/operator';
      case AppRole.parent:
        return '/parent';
    }
  }
}

AppRole? roleFromString(String? v) {
  if (v == null) return null;
  switch (v.toLowerCase()) {
    case 'admin':
      return AppRole.admin;
    case 'teacher':
      return AppRole.teacher;
    case 'operator':
      return AppRole.operator;
    case 'parent':
      return AppRole.parent;
    default:
      return null;
  }
}
