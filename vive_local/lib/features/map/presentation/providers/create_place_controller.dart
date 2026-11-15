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
    String? photoPath,
    String? photoContentType,
  }) async {
    state = const AsyncLoading();
    final photoStorage = ref.read(placePhotoStorageProvider);
    String? photoUrl;
    try {
      if (photoPath != null && photoPath.isNotEmpty) {
        photoUrl = await photoStorage.uploadPlacePhoto(
          filePath: photoPath,
          contentType: photoContentType,
        );
      }
      await ref
          .read(placesRepositoryProvider)
          .createPlace(
            name: name,
            category: category,
            latitude: latitude,
            longitude: longitude,
            photoUrl: photoUrl,
          );
      ref.invalidate(placesProvider);
      state = const AsyncData(null);
      return true;
    } catch (error, stackTrace) {
      if (photoUrl != null) {
        try {
          await photoStorage.deletePlacePhoto(photoUrl);
        } catch (_) {}
      }
      state = AsyncError(error, stackTrace);
      return false;
    }
  }
}
