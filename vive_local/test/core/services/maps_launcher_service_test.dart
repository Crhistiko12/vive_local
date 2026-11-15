import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/core/services/maps_launcher_service.dart';

void main() {
  group('buildGoogleMapsDirectionsUri', () {
    test('builds a Google Maps directions link for driving', () {
      final uri = buildGoogleMapsDirectionsUri(
        lat: -17.3938,
        lng: -66.1569,
      );

      expect(uri.scheme, 'https');
      expect(uri.host, 'www.google.com');
      expect(uri.path, '/maps/dir/');
      expect(uri.queryParameters['api'], '1');
      expect(uri.queryParameters['destination'], '-17.3938,-66.1569');
      expect(uri.queryParameters['travelmode'], 'driving');
    });
  });
}
