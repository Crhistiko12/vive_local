import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'locale_controller.g.dart';

@Riverpod(keepAlive: true)
class LocaleController extends _$LocaleController {
  @override
  Locale? build() => null;

  void setLanguageCode(String? code) {
    state = code == null ? null : Locale(code);
  }
}
