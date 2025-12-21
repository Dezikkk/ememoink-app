import 'package:ememoink/ui/core/view_model/theme_view_model.dart';
import 'package:flutter/material.dart';

Widget buildAsTiles(BuildContext context, ThemeViewModel themeViewModel) {
  final brightness = Theme.of(context).brightness;
  final isCurrentlyDark = brightness == Brightness.dark;

  return Column(
    children: [
      ListTile(
        title: const Text("Language"),
        leading: const Icon(Icons.translate_rounded),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: Navigate to Language selection
        },
      ),
      SwitchListTile(
        title: const Text("Dark Mode"),
        secondary: const Icon(Icons.dark_mode_rounded),
        subtitle: Text(
          themeViewModel.isSystemMode
              ? 'Using system settings'
              : themeViewModel.isDarkMode
              ? 'Dark theme active'
              : 'Light theme active',
        ),
        value: isCurrentlyDark,
        onChanged: (value) {
          themeViewModel.toggleTheme(value);
        },
      ),
    ],
  );
}
