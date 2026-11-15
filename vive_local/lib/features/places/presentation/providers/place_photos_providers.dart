import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/database/database_helper.dart';
import '../../data/place_photos_repository.dart';
import '../../domain/lugar_foto.dart';

final databaseHelperProvider = Provider<DatabaseHelper>((ref) {
  return DatabaseHelper.instance;
});

final placePhotosRepositoryProvider = Provider<PlacePhotosRepository>((ref) {
  return PlacePhotosRepository(
    databaseHelper: ref.watch(databaseHelperProvider),
  );
});

final placePhotosProvider =
    FutureProvider.family<List<LugarFoto>, String>((ref, lugarId) {
  final repository = ref.watch(placePhotosRepositoryProvider);
  return repository.getPhotosForPlace(lugarId);
});
