enum FailureCode {
  firebaseNotConfigured,
  authCancelled,
  authFailed,
  invalidCredentials,
  locationPermissionDenied,
  locationServicesDisabled,
  locationUnavailable,
  network,
  weatherNotConfigured,
  weatherUnavailable,
  placeNotFound,
  unknown,
}

class AppFailure implements Exception {
  const AppFailure(this.code, {this.cause, this.stackTrace});

  final FailureCode code;
  final Object? cause;
  final StackTrace? stackTrace;

  @override
  String toString() => 'AppFailure(code: $code)';
}
