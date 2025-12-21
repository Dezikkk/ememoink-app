import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    colorScheme: .fromSeed(
      seedColor: const Color(0xFF733FC7),
      brightness: Brightness.light,
    ),
  );
}

