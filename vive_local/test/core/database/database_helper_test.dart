import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/core/database/database_helper.dart';

void main() {
  group('DatabaseHelper', () {
    test('defines the required schema and table name', () {
      expect(DatabaseHelper.tableName, 'lugar_fotos');
      expect(DatabaseHelper.databaseName, 'vive_local_fotos.db');
      expect(DatabaseHelper.databaseVersion, 1);
    });

    test('configures default tourist photos for Cochabamba landmarks', () {
      final defaultPhotos = DatabaseHelper.defaultTouristPhotos;

      expect(defaultPhotos.containsKey('plaza-14-de-septiembre'), isTrue);
      expect(defaultPhotos.containsKey('cristo-de-la-concordia'), isTrue);
      expect(defaultPhotos.containsKey('aeropuerto-jorge-wilstermann'), isTrue);
      expect(defaultPhotos.containsKey('terminal-de-buses-cochabamba'), isTrue);
      expect(defaultPhotos.containsKey('palacio-portales'), isTrue);
      expect(defaultPhotos.containsKey('teleferico-al-cristo'), isTrue);

      for (final urls in defaultPhotos.values) {
        expect(urls, isNotEmpty);
        for (final url in urls) {
          expect(url.startsWith('https://'), isTrue);
        }
      }
    });
  });
}
