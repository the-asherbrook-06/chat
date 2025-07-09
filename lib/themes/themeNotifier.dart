// packages
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';

class ThemeNotifier extends ChangeNotifier {
  final Box settingsBox = Hive.box('settings');
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  ThemeNotifier() {
    String? storedTheme = settingsBox.get('themeMode');
    if (storedTheme != null) {
      _themeMode = _stringToThemeMode(storedTheme);
    }
  }

  void setTheme(ThemeMode mode) {
    _themeMode = mode;
    settingsBox.put('themeMode', _themeMode.name);
    notifyListeners();
  }

  ThemeMode _stringToThemeMode(String mode) {
    switch (mode) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
