import 'auth_user.dart';

abstract interface class AuthRepository {
  Stream<AuthUser?> authStateChanges();

  AuthUser? get currentUser;

  Future<AuthUser> signInWithGoogle();

  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  });

  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  Future<void> signOut();
}
