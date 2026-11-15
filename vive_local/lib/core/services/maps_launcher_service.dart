import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class GoogleMapsLaunchException implements Exception {
  const GoogleMapsLaunchException(this.message);

  final String message;

  @override
  String toString() => 'GoogleMapsLaunchException: $message';
}

Uri buildGoogleMapsDirectionsUri({
  required double lat,
  required double lng,
}) {
  return Uri.parse(
    'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving',
  );
}

Future<void> openInGoogleMaps({
  required double lat,
  required double lng,
  required String nombre,
}) async {
  final uri = buildGoogleMapsDirectionsUri(lat: lat, lng: lng);
  debugPrint('GoogleMapsLauncher: opening "$nombre" -> $uri');

  try {
    final launched = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      throw GoogleMapsLaunchException(
        'Could not open Google Maps for "$nombre" ($uri)',
      );
    }
  } on GoogleMapsLaunchException {
    rethrow;
  } catch (error) {
    throw GoogleMapsLaunchException(
      'Could not open Google Maps for "$nombre": $error',
    );
  }
}

typedef GoogleMapsLauncher =
    Future<void> Function({
      required double lat,
      required double lng,
      required String nombre,
    });

final googleMapsLauncherProvider = Provider<GoogleMapsLauncher>(
  (ref) => openInGoogleMaps,
);
