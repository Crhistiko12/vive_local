import '../../../core/errors/app_failure.dart';
import '../domain/place_photo_storage.dart';

class UnavailablePlacePhotoStorage implements PlacePhotoStorage {
  const UnavailablePlacePhotoStorage();

  @override
  Future<String> uploadPlacePhoto({
    required String filePath,
    String? contentType,
  }) async {
    throw const AppFailure(FailureCode.firebaseNotConfigured);
  }

  @override
  Future<void> deletePlacePhoto(String downloadUrl) async {}
}
