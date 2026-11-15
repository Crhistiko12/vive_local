// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(placesRepository)
final placesRepositoryProvider = PlacesRepositoryProvider._();

final class PlacesRepositoryProvider
    extends
        $FunctionalProvider<
          PlacesRepository,
          PlacesRepository,
          PlacesRepository
        >
    with $Provider<PlacesRepository> {
  PlacesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placesRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placesRepositoryHash();

  @$internal
  @override
  $ProviderElement<PlacesRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PlacesRepository create(Ref ref) {
    return placesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlacesRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlacesRepository>(value),
    );
  }
}

String _$placesRepositoryHash() => r'5a2fa0351d9b567f4950b0c6b597c63e5d8d4bae';

@ProviderFor(placePhotoStorage)
final placePhotoStorageProvider = PlacePhotoStorageProvider._();

final class PlacePhotoStorageProvider
    extends
        $FunctionalProvider<
          PlacePhotoStorage,
          PlacePhotoStorage,
          PlacePhotoStorage
        >
    with $Provider<PlacePhotoStorage> {
  PlacePhotoStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placePhotoStorageProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placePhotoStorageHash();

  @$internal
  @override
  $ProviderElement<PlacePhotoStorage> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  PlacePhotoStorage create(Ref ref) {
    return placePhotoStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PlacePhotoStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PlacePhotoStorage>(value),
    );
  }
}

String _$placePhotoStorageHash() => r'e5855583fd5958e4fa3b5ec2e3a964a00178a754';

@ProviderFor(places)
final placesProvider = PlacesProvider._();

final class PlacesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Place>>,
          List<Place>,
          Stream<List<Place>>
        >
    with $FutureModifier<List<Place>>, $StreamProvider<List<Place>> {
  PlacesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'placesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$placesHash();

  @$internal
  @override
  $StreamProviderElement<List<Place>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<List<Place>> create(Ref ref) {
    return places(ref);
  }
}

String _$placesHash() => r'973150e89a5d199412d393e50343aa094cc99545';

@ProviderFor(placeById)
final placeByIdProvider = PlaceByIdFamily._();

final class PlaceByIdProvider
    extends $FunctionalProvider<AsyncValue<Place?>, Place?, FutureOr<Place?>>
    with $FutureModifier<Place?>, $FutureProvider<Place?> {
  PlaceByIdProvider._({
    required PlaceByIdFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'placeByIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeByIdHash();

  @override
  String toString() {
    return r'placeByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Place?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Place?> create(Ref ref) {
    final argument = this.argument as String;
    return placeById(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeByIdHash() => r'74561c81dbcb9d8333c78abdf6786bafc0287df1';

final class PlaceByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Place?>, String> {
  PlaceByIdFamily._()
    : super(
        retry: null,
        name: r'placeByIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaceByIdProvider call(String id) =>
      PlaceByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'placeByIdProvider';
}
