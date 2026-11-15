// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_place_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CreatePlaceController)
final createPlaceControllerProvider = CreatePlaceControllerProvider._();

final class CreatePlaceControllerProvider
    extends $AsyncNotifierProvider<CreatePlaceController, void> {
  CreatePlaceControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'createPlaceControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$createPlaceControllerHash();

  @$internal
  @override
  CreatePlaceController create() => CreatePlaceController();
}

String _$createPlaceControllerHash() =>
    r'd26eaf75f185d888522a09e7660e7c095acaa223';

abstract class _$CreatePlaceController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
