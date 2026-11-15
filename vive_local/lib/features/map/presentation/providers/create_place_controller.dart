import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'places_providers.dart';

part 'create_place_controller.g.dart';

@riverpod
class CreatePlaceController extends _$CreatePlaceController {
  @override
  Future<void> build() async {}

  Future<bool> create({
    required String name,
    required String category,
    required double latitude,
    required double longitude,
  }) async {
    state = const AsyncLoading();
    try {
      await ref
          .read(placesRepositoryProvider)
          .createPlace(
            name: name,
            category: category,
            latitude: latitude,
            longitude: longitude,
          );
      ref.invalidate(placesProvider);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
