import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class FavoritePlaces extends Table {
  TextColumn get placeId => text()();
  TextColumn get name => text()();
  TextColumn get category => text().withDefault(const Constant(''))();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  DateTimeColumn get savedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column<Object>> get primaryKey => {placeId};
}

class PlaceReviews extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get placeId => text()();
  IntColumn get rating => integer()();
  TextColumn get comment => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(tables: [FavoritePlaces, PlaceReviews])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor])
    : super(executor ?? driftDatabase(name: 'vive_local'));

  @override
  int get schemaVersion => 1;

  Stream<List<FavoritePlace>> watchFavorites() {
    return (select(
      favoritePlaces,
    )..orderBy([(table) => OrderingTerm.desc(table.savedAt)])).watch();
  }

  Stream<bool> watchIsFavorite(String placeId) {
    return (select(favoritePlaces)
          ..where((table) => table.placeId.equals(placeId)))
        .watch()
        .map((rows) => rows.isNotEmpty);
  }

  Future<bool> isFavorite(String placeId) async {
    final row = await (select(
      favoritePlaces,
    )..where((table) => table.placeId.equals(placeId))).getSingleOrNull();
    return row != null;
  }

  Future<void> addFavorite({
    required String placeId,
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  }) {
    return into(favoritePlaces).insertOnConflictUpdate(
      FavoritePlacesCompanion.insert(
        placeId: placeId,
        name: name,
        category: Value(category),
        latitude: latitude,
        longitude: longitude,
      ),
    );
  }

  Future<void> removeFavorite(String placeId) {
    return (delete(
      favoritePlaces,
    )..where((table) => table.placeId.equals(placeId))).go();
  }
}
