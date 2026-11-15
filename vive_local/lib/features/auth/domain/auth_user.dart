class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.photoUrl,
    this.isAnonymous = false,
  });

  final String id;
  final String email;
  final String? displayName;
  final String? photoUrl;
  final bool isAnonymous;

  String get initials {
    final source = (displayName?.trim().isNotEmpty ?? false)
        ? displayName!.trim()
        : email.trim();
    if (source.isEmpty) {
      return '?';
    }
    final parts = source.split(RegExp(r'\s+'));
    if (parts.length == 1) {
      return parts.first.substring(0, 1).toUpperCase();
    }
    return '${parts.first.substring(0, 1)}${parts.last.substring(0, 1)}'
        .toUpperCase();
  }
}
