import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selected_place_controller.g.dart';

@Riverpod(keepAlive: true)
class SelectedPlaceController extends _$SelectedPlaceController {
  @override
  String? build() => null;

  void select(String placeId) => state = placeId;

  void clear() => state = null;
}
