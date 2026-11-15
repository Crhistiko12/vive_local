import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/features/places/domain/lugar_foto.dart';

void main() {
  group('LugarFoto', () {
    test('serializes to map and deserializes from map correctly', () {
      const foto = LugarFoto(
        id: 1,
        lugarId: 'cristo-de-la-concordia',
        imagePath: '/path/to/local/photo.jpg',
        esLocal: true,
      );

      final map = foto.toMap();
      expect(map['id'], 1);
      expect(map['lugar_id'], 'cristo-de-la-concordia');
      expect(map['image_path'], '/path/to/local/photo.jpg');
      expect(map['es_local'], 1);

      final fromMap = LugarFoto.fromMap(map);
      expect(fromMap, equals(foto));
      expect(fromMap.id, 1);
      expect(fromMap.lugarId, 'cristo-de-la-concordia');
      expect(fromMap.imagePath, '/path/to/local/photo.jpg');
      expect(fromMap.esLocal, isTrue);
    });

    test('serializes web photo with esLocal = false correctly', () {
      const foto = LugarFoto(
        id: 2,
        lugarId: 'plaza-14-de-septiembre',
        imagePath: 'https://example.com/plaza.jpg',
        esLocal: false,
      );

      final map = foto.toMap();
      expect(map['es_local'], 0);

      final fromMap = LugarFoto.fromMap(map);
      expect(fromMap.esLocal, isFalse);
    });

    test('copyWith updates fields correctly', () {
      const original = LugarFoto(
        id: 1,
        lugarId: 'place-1',
        imagePath: '/old/path.jpg',
        esLocal: true,
      );

      final updated = original.copyWith(
        id: 5,
        imagePath: '/new/path.jpg',
      );

      expect(updated.id, 5);
      expect(updated.lugarId, 'place-1');
      expect(updated.imagePath, '/new/path.jpg');
      expect(updated.esLocal, isTrue);
    });
  });
}
