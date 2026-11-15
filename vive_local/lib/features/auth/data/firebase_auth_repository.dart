import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/errors/app_failure.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';
import 'auth_token_store.dart';
import 'google_sign_in_data_source.dart';

class FirebaseAuthRepository implements AuthRepository {
  FirebaseAuthRepository(this._auth, this._googleSignIn, this._tokenStore);

  final FirebaseAuth _auth;
  final GoogleSignInDataSource _googleSignIn;
  final AuthTokenStore _tokenStore;

  @override
  AuthUser? get currentUser {
    final user = _auth.currentUser;
    return user == null ? null : _mapUser(user);
  }

  @override
  Stream<AuthUser?> authStateChanges() {
    return _auth.authStateChanges().asyncMap((user) async {
      await _syncToken();
      return user == null ? null : _mapUser(user);
    });
  }

  @override
  Future<AuthUser> signInWithGoogle() async {
    try {
      final account = await _googleSignIn.authenticate();
      final idToken = account.authentication.idToken;
      if (idToken == null) {
        throw const AppFailure(FailureCode.authFailed);
      }

      final credential = GoogleAuthProvider.credential(idToken: idToken);
      final result = await _auth.signInWithCredential(credential);
      final user = result.user;
      if (user == null) {
        throw const AppFailure(FailureCode.authFailed);
      }

      await _syncToken();
      return _mapUser(user);
    } on GoogleSignInException catch (error, stackTrace) {
      if (error.code == GoogleSignInExceptionCode.canceled) {
        throw AppFailure(
          FailureCode.authCancelled,
          cause: error,
          stackTrace: stackTrace,
        );
      }
      throw AppFailure(
        FailureCode.authFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    } on FirebaseAuthException catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.authFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<AuthUser> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        throw const AppFailure(FailureCode.authFailed);
      }
      await _syncToken();
      return _mapUser(user);
    } on FirebaseAuthException catch (error, stackTrace) {
      if (_isCredentialError(error.code)) {
        throw AppFailure(
          FailureCode.invalidCredentials,
          cause: error,
          stackTrace: stackTrace,
        );
      }
      throw AppFailure(
        FailureCode.authFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<AuthUser> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      if (user == null) {
        throw const AppFailure(FailureCode.authFailed);
      }
      if (displayName != null && displayName.trim().isNotEmpty) {
        await user.updateDisplayName(displayName.trim());
        await user.reload();
      }
      await _syncToken();
      return _mapUser(_auth.currentUser ?? user);
    } on FirebaseAuthException catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.authFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
    await _tokenStore.clear();
  }

  Future<void> _syncToken() async {
    final user = _auth.currentUser;
    if (user == null) {
      await _tokenStore.clear();
      return;
    }
    final token = await user.getIdToken();
    if (token != null && token.isNotEmpty) {
      await _tokenStore.write(token);
    }
  }

  AuthUser _mapUser(User user) => AuthUser(
    id: user.uid,
    email: user.email ?? '',
    displayName: user.displayName,
    photoUrl: user.photoURL,
    isAnonymous: user.isAnonymous,
  );

  bool _isCredentialError(String code) => switch (code) {
    'invalid-credential' ||
    'wrong-password' ||
    'user-not-found' ||
    'invalid-email' => true,
    _ => false,
  };
}
