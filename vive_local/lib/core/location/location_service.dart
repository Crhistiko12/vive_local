import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../errors/app_failure.dart';

class GeoPosition {
  const GeoPosition({
    required this.latitude,
    required this.longitude,
    this.accuracy = 0,
  });

  final double latitude;
  final double longitude;
  final double accuracy;
}

abstract interface class LocationService {
  Future<GeoPosition> currentPosition();
  Stream<GeoPosition> positionStream();
}

class GeolocatorLocationService implements LocationService {
  const GeolocatorLocationService();

  @override
  Future<GeoPosition> currentPosition() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const AppFailure(FailureCode.locationServicesDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const AppFailure(FailureCode.locationPermissionDenied);
    }

    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );
      return GeoPosition(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
      );
    } catch (error, stackTrace) {
      throw AppFailure(
        FailureCode.locationUnavailable,
        cause: error,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Stream<GeoPosition> positionStream() {
    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 25,
    );

    return Geolocator.getPositionStream(locationSettings: settings).map(
      (position) => GeoPosition(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
      ),
    );
  }
}

final locationServiceProvider = Provider<LocationService>(
  (ref) => const GeolocatorLocationService(),
);
