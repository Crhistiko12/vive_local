import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/features/map/domain/place.dart';
import 'package:vive_local/features/map/domain/place_photo_storage.dart';
import 'package:vive_local/features/map/domain/places_repository.dart';
import 'package:vive_local/features/map/presentation/providers/create_place_controller.dart';
import 'package:vive_local/features/map/presentation/providers/places_providers.dart';

typedef CreatedPlace = ({
  String name,
  String category,
  double latitude,
  double longitude,
  String? photoUrl,
});

class _FakePlacesRepository implements PlacesRepository {
  _FakePlacesRepository({this.error});

  final Object? error;
  final List<CreatedPlace> created = [];

  @override
  Stream<List<Place>> watchPlaces() => Stream<List<Place>>.empty();

  @override
  Future<Place?> getPlaceById(String id) async => null;

  @override
  Future<void> createPlace({
    required String name,
    required String category,
    required double latitude,
    required double longitude,
    String? photoUrl,
  }) async {
    if (error != null) {
      throw error!;
    }
    created.add((
      name: name,
      category: category,
      latitude: latitude,
      longitude: longitude,
      photoUrl: photoUrl,
    ));
  }
}

class _FakePlacePhotoStorage implements PlacePhotoStorage {
  _FakePlacePhotoStorage({
    this.uploadedUrl = 'https://storage.example/photo.jpg',
    this.error,
  });

  final String uploadedUrl;
  final Object? error;
  final List<String> uploadedPaths = [];
  final List<String?> uploadedContentTypes = [];
  final List<String> deletedUrls = [];

  @override
  Future<String> uploadPlacePhoto({
    required String filePath,
    String? contentType,
  }) async {
    if (error != null) {
      throw error!;
    }
    uploadedPaths.add(filePath);
    uploadedContentTypes.add(contentType);
    return uploadedUrl;
  }

  @override
  Future<void> deletePlacePhoto(String downloadUrl) async {
    deletedUrls.add(downloadUrl);
  }
}

void main() {
  test('create() persists the place and exposes a data state', () async {
    final repository = _FakePlacesRepository();
    final container = ProviderContainer(
      overrides: [placesRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      createPlaceControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    final created = await container
        .read(createPlaceControllerProvider.notifier)
        .create(
          name: 'Café Central',
          category: 'Café',
          latitude: -17.3938,
          longitude: -66.1569,
        );

    expect(created, isTrue);
    expect(repository.created, hasLength(1));
    expect(repository.created.single.name, 'Café Central');
    expect(repository.created.single.category, 'Café');
    expect(repository.created.single.latitude, -17.3938);
    expect(repository.created.single.longitude, -66.1569);
    expect(repository.created.single.photoUrl, isNull);
    expect(
      container.read(createPlaceControllerProvider),
      isA<AsyncData<void>>(),
    );
  });

  test('create() uploads the photo and persists its URL', () async {
    final repository = _FakePlacesRepository();
    final photoStorage = _FakePlacePhotoStorage(
      uploadedUrl: 'https://storage.example/lugares/foto.jpg',
    );
    final container = ProviderContainer(
      overrides: [
        placesRepositoryProvider.overrideWithValue(repository),
        placePhotoStorageProvider.overrideWithValue(photoStorage),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      createPlaceControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    final created = await container
        .read(createPlaceControllerProvider.notifier)
        .create(
          name: 'Café Central',
          category: 'Café',
          latitude: -17.3938,
          longitude: -66.1569,
          photoPath: '/tmp/foto.jpg',
          photoContentType: 'image/jpeg',
        );

    expect(created, isTrue);
    expect(photoStorage.uploadedPaths, ['/tmp/foto.jpg']);
    expect(photoStorage.uploadedContentTypes, ['image/jpeg']);
    expect(photoStorage.deletedUrls, isEmpty);
    expect(
      repository.created.single.photoUrl,
      'https://storage.example/lugares/foto.jpg',
    );
  });

  test('create() returns false and exposes the error when it fails', () async {
    final repository = _FakePlacesRepository(error: StateError('boom'));
    final container = ProviderContainer(
      overrides: [placesRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      createPlaceControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    final created = await container
        .read(createPlaceControllerProvider.notifier)
        .create(
          name: 'Café Central',
          category: 'Café',
          latitude: -17.3938,
          longitude: -66.1569,
        );

    expect(created, isFalse);
    expect(repository.created, isEmpty);
    expect(container.read(createPlaceControllerProvider).hasError, isTrue);
  });

  test(
    'create() does not persist the place when the photo upload fails',
    () async {
      final repository = _FakePlacesRepository();
      final photoStorage = _FakePlacePhotoStorage(
        error: StateError('upload failed'),
      );
      final container = ProviderContainer(
        overrides: [
          placesRepositoryProvider.overrideWithValue(repository),
          placePhotoStorageProvider.overrideWithValue(photoStorage),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        createPlaceControllerProvider,
        (_, _) {},
      );
      addTearDown(subscription.close);

      final created = await container
          .read(createPlaceControllerProvider.notifier)
          .create(
            name: 'Café Central',
            category: 'Café',
            latitude: -17.3938,
            longitude: -66.1569,
            photoPath: '/tmp/foto.jpg',
          );

      expect(created, isFalse);
      expect(repository.created, isEmpty);
      expect(photoStorage.deletedUrls, isEmpty);
      expect(container.read(createPlaceControllerProvider).hasError, isTrue);
    },
  );

  test('create() deletes the uploaded photo when Firestore fails', () async {
    final repository = _FakePlacesRepository(error: StateError('boom'));
    final photoStorage = _FakePlacePhotoStorage(
      uploadedUrl: 'https://storage.example/lugares/foto.jpg',
    );
    final container = ProviderContainer(
      overrides: [
        placesRepositoryProvider.overrideWithValue(repository),
        placePhotoStorageProvider.overrideWithValue(photoStorage),
      ],
    );
    addTearDown(container.dispose);
    final subscription = container.listen(
      createPlaceControllerProvider,
      (_, _) {},
    );
    addTearDown(subscription.close);

    final created = await container
        .read(createPlaceControllerProvider.notifier)
        .create(
          name: 'Café Central',
          category: 'Café',
          latitude: -17.3938,
          longitude: -66.1569,
          photoPath: '/tmp/foto.jpg',
        );

    expect(created, isFalse);
    expect(photoStorage.deletedUrls, [
      'https://storage.example/lugares/foto.jpg',
    ]);
    expect(container.read(createPlaceControllerProvider).hasError, isTrue);
  });
}
