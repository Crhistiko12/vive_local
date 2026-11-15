import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Whether Firebase was initialized successfully at startup.
///
/// It is overridden in `main.dart` with the result of `FirebaseBootstrap`.
/// When `false`, the app runs in demo mode: local places and disabled auth.
final firebaseReadyProvider = Provider<bool>((ref) => false);
