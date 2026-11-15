import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../configs/providers.dart';
import '../../data/auth_token_store.dart';
import '../../data/disabled_auth_repository.dart';
import '../../data/firebase_auth_repository.dart';
import '../../data/google_sign_in_data_source.dart';
import '../../domain/auth_repository.dart';
import '../../domain/auth_user.dart';

part 'auth_providers.g.dart';

@Riverpod(keepAlive: true)
GoogleSignInDataSource googleSignInDataSource(Ref ref) =>
    GoogleSignInDataSource();

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  if (!ref.watch(firebaseReadyProvider)) {
    return const DisabledAuthRepository();
  }
  return FirebaseAuthRepository(
    FirebaseAuth.instance,
    ref.watch(googleSignInDataSourceProvider),
    ref.watch(authTokenStoreProvider),
  );
}

@Riverpod(keepAlive: true)
Stream<AuthUser?> authStateChanges(Ref ref) =>
    ref.watch(authRepositoryProvider).authStateChanges();
