// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserLocationController)
final userLocationControllerProvider = UserLocationControllerProvider._();

final class UserLocationControllerProvider
    extends
        $NotifierProvider<
          UserLocationController,
          ({double latitude, double longitude})?
        > {
  UserLocationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocationControllerHash();

  @$internal
  @override
  UserLocationController create() => UserLocationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(({double latitude, double longitude})? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<({double latitude, double longitude})?>(value),
    );
  }
}

String _$userLocationControllerHash() =>
    r'e5ec87513a55b318ddfd5bf6f3db6617a05a35a7';

abstract class _$UserLocationController
    extends $Notifier<({double latitude, double longitude})?> {
  ({double latitude, double longitude})? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<
              ({double latitude, double longitude})?,
              ({double latitude, double longitude})?
            >;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                ({double latitude, double longitude})?,
                ({double latitude, double longitude})?
              >,
              ({double latitude, double longitude})?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
