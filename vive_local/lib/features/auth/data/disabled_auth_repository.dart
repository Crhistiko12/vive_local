import '../../../core/errors/app_failure.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

class DisabledAuthRepository implements AuthRepository {
  const DisabledAuthRepository();

  @override
  Stream<AuthUser?> authStateChanges() => Stream<AuthUser?>.value(null);

  @override
  AuthUser? get currentUser => null;

  @override
  Future<AuthUser> signInWithGoogle() async =>
      throw const AppFailure(FailureCode.firebaseNotConfigured);

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async => throw const AppFailure(FailureCode.firebaseNotConfigured);

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async => throw const AppFailure(FailureCode.firebaseNotConfigured);

  @override
  Future<void> signOut() async {}
}
