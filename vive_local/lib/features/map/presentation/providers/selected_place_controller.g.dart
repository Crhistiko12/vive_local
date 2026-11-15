// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'selected_place_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPlaceController)
final selectedPlaceControllerProvider = SelectedPlaceControllerProvider._();

final class SelectedPlaceControllerProvider
    extends $NotifierProvider<SelectedPlaceController, String?> {
  SelectedPlaceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPlaceControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPlaceControllerHash();

  @$internal
  @override
  SelectedPlaceController create() => SelectedPlaceController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedPlaceControllerHash() =>
    r'374f2358ba91209e738c9111bbed7e9431f9089e';

abstract class _$SelectedPlaceController extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
