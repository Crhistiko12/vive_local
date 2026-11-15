import '../domain/favorite_place.dart';

abstract interface class FavoritesRepository {
  Stream<List<FavoritePlace>> watchFavorites();

  Stream<bool> watchIsFavorite(String placeId);

  Future<void> toggleFavorite({
    required String placeId,
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  });
}
