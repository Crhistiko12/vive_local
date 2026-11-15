// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherRepository)
final weatherRepositoryProvider = WeatherRepositoryProvider._();

final class WeatherRepositoryProvider
    extends
        $FunctionalProvider<
          WeatherRepository,
          WeatherRepository,
          WeatherRepository
        >
    with $Provider<WeatherRepository> {
  WeatherRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherRepositoryHash();

  @$internal
  @override
  $ProviderElement<WeatherRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  WeatherRepository create(Ref ref) {
    return weatherRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeatherRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeatherRepository>(value),
    );
  }
}

String _$weatherRepositoryHash() => r'cced434af131f3336cbba18ed2cfecc9d36b6ab7';

@ProviderFor(placeWeather)
final placeWeatherProvider = PlaceWeatherFamily._();

final class PlaceWeatherProvider
    extends $FunctionalProvider<AsyncValue<Weather>, Weather, FutureOr<Weather>>
    with $FutureModifier<Weather>, $FutureProvider<Weather> {
  PlaceWeatherProvider._({
    required PlaceWeatherFamily super.from,
    required ({double latitude, double longitude}) super.argument,
  }) : super(
         retry: null,
         name: r'placeWeatherProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$placeWeatherHash();

  @override
  String toString() {
    return r'placeWeatherProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Weather> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Weather> create(Ref ref) {
    final argument = this.argument as ({double latitude, double longitude});
    return placeWeather(
      ref,
      latitude: argument.latitude,
      longitude: argument.longitude,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PlaceWeatherProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$placeWeatherHash() => r'4aeb707836e4f2ffb58a6637f4f7c7d5f1100b55';

final class PlaceWeatherFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Weather>,
          ({double latitude, double longitude})
        > {
  PlaceWeatherFamily._()
    : super(
        retry: null,
        name: r'placeWeatherProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PlaceWeatherProvider call({
    required double latitude,
    required double longitude,
  }) => PlaceWeatherProvider._(
    argument: (latitude: latitude, longitude: longitude),
    from: this,
  );

  @override
  String toString() => r'placeWeatherProvider';
}
