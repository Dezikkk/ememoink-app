import 'package:flutter/material.dart';

Widget buildSectionHeader({
  required BuildContext context,
  required String title,
}) {
  return Padding(
    // padding: const EdgeInsets.symmetric(vertical: 16),
    padding: const EdgeInsets.only(top: 24, bottom: 16),
    child: Text(
      title,
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w700,
        fontSize: 16,
        letterSpacing: 0.5,
      ),
    ),
  );
}
