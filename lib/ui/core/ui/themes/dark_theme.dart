import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: .fromSeed(
      seedColor: const Color.fromARGB(255, 115, 63, 199),
      contrastLevel: 0,
      brightness: Brightness.dark,
    ),
  );
}
