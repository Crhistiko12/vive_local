import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/auth_user.dart';
import 'auth_providers.dart';

part 'sign_in_controller.g.dart';

@riverpod
class SignInController extends _$SignInController {
  @override
  Future<void> build() async {}

  Future<void> signInWithGoogle() => _run(
    () => ref.read(authRepositoryProvider).signInWithGoogle(),
  );

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) => _run(
    () => ref
        .read(authRepositoryProvider)
        .signInWithEmail(email: email, password: password),
  );

  Future<void> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) => _run(
    () => ref
        .read(authRepositoryProvider)
        .registerWithEmail(
          email: email,
          password: password,
          displayName: displayName,
        ),
  );

  Future<void> signOut() => _run(
    () async {
      await ref.read(authRepositoryProvider).signOut();
      return const AuthUser(id: '', email: '');
    },
  );

  Future<void> _run(Future<AuthUser> Function() action) async {
    state = const AsyncLoading();
    try {
      await action();
      state = const AsyncData(null);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }
}
