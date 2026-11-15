import 'package:local_auth/local_auth.dart';

import '../../../core/errors/app_failure.dart';
import '../../../core/logging/app_logger.dart';

class BiometricService {
  BiometricService({LocalAuthentication? localAuth})
    : _localAuth = localAuth ?? LocalAuthentication();

  final LocalAuthentication _localAuth;

  Future<bool> isAvailable() async {
    try {
      final supported = await _localAuth.isDeviceSupported();
      final canCheck = await _localAuth.canCheckBiometrics;
      return supported && canCheck;
    } catch (error, stackTrace) {
      AppLogger.warning('Biometrics unavailable', error, stackTrace);
      return false;
    }
  }

  Future<bool> authenticate(String reason) async {
    try {
      if (!await isAvailable()) {
        return false;
      }
      return await _localAuth.authenticate(
        localizedReason: reason,
        biometricOnly: true,
        persistAcrossBackgrounding: true,
      );
    } catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.authFailed,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }
}
