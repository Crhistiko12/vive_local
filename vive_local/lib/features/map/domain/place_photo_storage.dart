abstract interface class PlacePhotoStorage {
  Future<String> uploadPlacePhoto({
    required String filePath,
    String? contentType,
  });

  Future<void> deletePlacePhoto(String downloadUrl);
}
