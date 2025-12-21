import 'package:flutter/material.dart';

Widget buildFooter(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top:0,bottom: 20),
    child: Center(
      child: TextButton.icon(
        onPressed: () {
          // TODO: Show About Dialog
        },
        icon: const Icon(Icons.info_outline, size: 16, color: Colors.grey),
        label: const Text(
          "About App v1.0.0",
          style: TextStyle(color: Colors.grey),
        ),
      ),
    ),
  );
}
