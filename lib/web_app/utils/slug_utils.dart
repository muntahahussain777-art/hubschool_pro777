/// Safe slug for blog/article routes. Prevents full URLs from being used as path segments.
String safeSlugForRoute(String? slugOrUrl) {
  if (slugOrUrl == null || slugOrUrl.isEmpty) return '';
  final s = slugOrUrl.trim();
  // If it looks like a full URL, use only the last path segment or a safe fallback
  if (s.contains('://') || s.toLowerCase().startsWith('http')) {
    try {
      final uri = Uri.parse(s);
      final path = uri.path;
      if (path.isNotEmpty) {
        final segments = path.split('/').where((e) => e.isNotEmpty);
        if (segments.isNotEmpty) {
          final last = segments.last;
          if (last.length < 200) return last;
        }
      }
    } catch (_) {}
    return 'article';
  }
  // Allow only path-safe characters for /blog/:slug
  final safe = s.replaceAll(RegExp(r'[^a-zA-Z0-9\-_]'), '-').replaceAll(RegExp(r'-+'), '-').trim().trimRight();
  if (safe.isEmpty) return 'article';
  return safe.length > 200 ? safe.substring(0, 200) : safe;
}
