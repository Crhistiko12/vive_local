import 'place.dart';

abstract interface class PlacesRepository {
  Stream<List<Place>> watchPlaces();

  Future<Place?> getPlaceById(String id);

  Future<void> createPlace({
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  });
}
