import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/features/map/data/demo_places_repository.dart';
import 'package:vive_local/features/map/domain/place.dart';

void main() {
  group('Place', () {
    test('hasPhoto is false when photoUrl is empty or null', () {
      const withoutPhoto = Place(
        id: 'a',
        name: 'A',
        latitude: 0,
        longitude: 0,
      );
      const emptyPhoto = Place(
        id: 'b',
        name: 'B',
        latitude: 0,
        longitude: 0,
        photoUrl: '',
      );

      expect(withoutPhoto.hasPhoto, isFalse);
      expect(emptyPhoto.hasPhoto, isFalse);
    });

    test('hasPhoto is true when photoUrl has content', () {
      const place = Place(
        id: 'a',
        name: 'A',
        latitude: 0,
        longitude: 0,
        photoUrl: 'https://example.com/photo.jpg',
      );

      expect(place.hasPhoto, isTrue);
    });
  });

  group('DemoPlacesRepository', () {
    const repository = DemoPlacesRepository();

    test('returns demo places', () async {
      final places = await repository.watchPlaces().first;

      expect(places, isNotEmpty);
      expect(places.every((place) => place.name.isNotEmpty), isTrue);
    });

    test('finds a place by id', () async {
      final place = await repository.getPlaceById('plaza-14-de-septiembre');

      expect(place, isNotNull);
      expect(place!.name, 'Plaza 14 de Septiembre');
    });

    test('contains the main Cochabamba landmarks', () async {
      final places = await repository.watchPlaces().first;
      final names = places.map((place) => place.name).toSet();

      expect(names, contains('Cristo de la Concordia'));
      expect(names, contains('Aeropuerto Internacional Jorge Wilstermann'));
      expect(names, contains('Terminal de Buses de Cochabamba'));
      expect(names, contains('Plaza 14 de Septiembre'));
      expect(names, contains('Palacio Portales'));
      expect(names, contains('Teleférico al Cristo (base)'));
    });

    test('returns null for an unknown id', () async {
      final place = await repository.getPlaceById('does-not-exist');

      expect(place, isNull);
    });
  });
}
