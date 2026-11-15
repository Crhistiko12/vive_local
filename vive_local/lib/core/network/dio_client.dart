import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/data/auth_token_store.dart';
import 'auth_interceptor.dart';

part 'dio_client.g.dart';

@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final client = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
    ),
  );

  final tokenStore = ref.watch(authTokenStoreProvider);
  client.interceptors.add(AuthInterceptor(tokenStore.read));
  client.interceptors.add(ErrorLoggingInterceptor());

  return client;
}
