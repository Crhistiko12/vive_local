import 'package:dio/dio.dart';

import '../logging/app_logger.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._readToken);

  final Future<String?> Function() _readToken;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['requiresAuth'] != true) {
      handler.next(options);
      return;
    }

    final token = await _readToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

class ErrorLoggingInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.warning(
      'HTTP ${err.response?.statusCode ?? '-'} '
      '${err.requestOptions.method} ${err.requestOptions.path}',
      err.message,
    );
    handler.next(err);
  }
}
