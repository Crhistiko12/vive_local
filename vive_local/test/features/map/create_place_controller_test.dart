import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vive_local/features/map/domain/place.dart';
import 'package:vive_local/features/map/domain/places_repository.dart';
import 'package:vive_local/features/map/presentation/providers/create_place_controller.dart';
import 'package:vive_local/features/map/presentation/providers/places_providers.dart';

typedef CreatedPlace = ({
  String name,
  String category,
  double latitude,
  double longitude,
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
  }) async {
    if (error != null) {
      throw error!;
    }
    created.add((
      name: name,
      category: category,
      latitude: latitude,
      longitude: longitude,
    ));
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
    expect(container.read(createPlaceControllerProvider), isA<AsyncData<void>>());
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
}
