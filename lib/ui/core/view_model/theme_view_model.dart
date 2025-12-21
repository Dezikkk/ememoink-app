import 'package:ememoink/config/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeViewModel extends ChangeNotifier {
  final SharedPreferences _prefs;

  static const String _themeKey = 'theme_mode';

  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isLightMode => _themeMode == ThemeMode.light;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  ThemeViewModel({SharedPreferences? prefs})
    : _prefs = prefs ?? getIt<SharedPreferences>() {
    _loadFromPreferences();
  }

  void _loadFromPreferences() {
    final savedMode = _prefs.getString(_themeKey);

    switch (savedMode) {
      case 'dark':
        _themeMode = ThemeMode.dark;
        break;
      case 'light':
        _themeMode = ThemeMode.light;
        break;
      default:
        _themeMode = ThemeMode.system;
    }

    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();

    String modeString;
    switch (mode) {
      case ThemeMode.dark:
        modeString = 'dark';
        break;
      case ThemeMode.light:
        modeString = 'light';
        break;
      case ThemeMode.system:
        modeString = 'system';
        break;
    }

    await _prefs.setString(_themeKey, modeString);
  }

  Future<void> toggleTheme(bool isDark) async {
    await setThemeMode(isDark ? ThemeMode.dark : ThemeMode.light);
  }

  Future<void> useDarkMode() async {
    await setThemeMode(ThemeMode.dark);
  }

  Future<void> useLightMode() async {
    await setThemeMode(ThemeMode.light);
  }

  Future<void> useSystemMode() async {
    await setThemeMode(ThemeMode.system);
  }
}
