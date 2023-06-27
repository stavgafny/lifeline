import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeModeProvider = StateNotifierProvider<ThemeModeController, ThemeMode>(
  // final brightness = MediaQuery.of(context).platformBrightness;
  // final isDarkMode = brightness == Brightness.dark;
  (ref) => ThemeModeController(ThemeMode.system),
);

class ThemeModeController extends StateNotifier<ThemeMode> {
  ThemeModeController(super._state);

  void setMode(ThemeMode mode) {
    state = mode;
  }

  void toggleMode() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}
