import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_controller.g.dart';

@Riverpod(keepAlive: true)
class UserLocationController extends _$UserLocationController {
  @override
  ({double latitude, double longitude})? build() => null;

  void setPosition({required double latitude, required double longitude}) {
    state = (latitude: latitude, longitude: longitude);
  }

  void clear() => state = null;
}
