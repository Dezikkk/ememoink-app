import 'package:ememoink/config/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier {
  // ignore: unused_field
  final SharedPreferences _prefs;

  SettingsViewModel({SharedPreferences? prefs})
    : _prefs = prefs ?? getIt<SharedPreferences>();

}
