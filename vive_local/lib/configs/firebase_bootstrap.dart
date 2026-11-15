import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';

import '../core/logging/app_logger.dart';
import '../firebase_options.dart';

abstract final class FirebaseBootstrap {
  static Future<bool> initialize() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Firebase is not configured. Running in demo mode.',
        error,
        stackTrace,
      );
      return false;
    }

    AppLogger.info('Firebase initialized');

    try {
      FlutterError.onError = (details) {
        FlutterError.presentError(details);
        FirebaseCrashlytics.instance.recordFlutterFatalError(details);
      };

      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      await FirebaseAnalytics.instance.logAppOpen();
    } catch (error, stackTrace) {
      AppLogger.warning(
        'Firebase telemetry could not be initialized.',
        error,
        stackTrace,
      );
    }

    return true;
  }
}
