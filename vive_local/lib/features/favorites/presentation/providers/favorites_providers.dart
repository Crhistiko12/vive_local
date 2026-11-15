import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/app_database.dart' as db;
import '../../data/drift_favorites_repository.dart';
import '../../domain/favorite_place.dart';
import '../../domain/favorites_repository.dart';

part 'favorites_providers.g.dart';

@Riverpod(keepAlive: true)
db.AppDatabase appDatabase(Ref ref) {
  final database = db.AppDatabase();
  ref.onDispose(database.close);
  return database;
}

@Riverpod(keepAlive: true)
FavoritesRepository favoritesRepository(Ref ref) =>
    DriftFavoritesRepository(ref.watch(appDatabaseProvider));

@riverpod
Stream<List<FavoritePlace>> favorites(Ref ref) =>
    ref.watch(favoritesRepositoryProvider).watchFavorites();

@riverpod
Stream<bool> isFavorite(Ref ref, String placeId) =>
    ref.watch(favoritesRepositoryProvider).watchIsFavorite(placeId);
