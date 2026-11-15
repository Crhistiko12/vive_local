import '../../../core/database/app_database.dart' as db;
import '../domain/favorite_place.dart';
import '../domain/favorites_repository.dart';

class DriftFavoritesRepository implements FavoritesRepository {
  DriftFavoritesRepository(this._database);

  final db.AppDatabase _database;

  @override
  Stream<List<FavoritePlace>> watchFavorites() {
    return _database.watchFavorites().map(
      (rows) => rows
          .map(
            (row) => FavoritePlace(
              placeId: row.placeId,
              name: row.name,
              category: row.category,
              latitude: row.latitude,
              longitude: row.longitude,
              savedAt: row.savedAt,
            ),
          )
          .toList(),
    );
  }

  @override
  Stream<bool> watchIsFavorite(String placeId) =>
      _database.watchIsFavorite(placeId);

  @override
  Future<void> toggleFavorite({
    required String placeId,
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  }) async {
    final isFavorite = await _database.isFavorite(placeId);
    if (isFavorite) {
      await _database.removeFavorite(placeId);
      return;
    }
    await _database.addFavorite(
      placeId: placeId,
      name: name,
      category: category,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
