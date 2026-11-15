import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_token_store.g.dart';

class AuthTokenStore {
  AuthTokenStore(this._storage);

  static const _tokenKey = 'vivelocal.auth.jwt';

  final FlutterSecureStorage _storage;

  Future<String?> read() => _storage.read(key: _tokenKey);

  Future<void> write(String token) => _storage.write(
    key: _tokenKey,
    value: token,
  );

  Future<void> clear() => _storage.delete(key: _tokenKey);
}

@Riverpod(keepAlive: true)
AuthTokenStore authTokenStore(Ref ref) =>
    AuthTokenStore(const FlutterSecureStorage());
