import 'package:flutter/material.dart';

Widget buildSnuTiles(BuildContext context) {
  return Column(
    children: [
      SwitchListTile(
        title: const Text("Auto-update"),
        secondary: const Icon(Icons.autorenew_rounded),
        value: false, // TODO: Podepnij pod odpowiedni stan
        onChanged: (bool value) {
          // TODO: viewModel.toggleAutoUpdate(value);
        },
      ),
      ListTile(
        title: const Text("Check for updates"),
        leading: const Icon(Icons.system_update_rounded),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          // TODO: implement this
        },
      ),
      ListTile(
        title: const Text("Restart Device"),
        leading: const Icon(Icons.restart_alt_rounded),
        onTap: () {
          // TODO: Show confirmation dialog
        },
      ),

      ListTile(
        title: const Text("Factory Reset", style: TextStyle(color: Colors.red)),
        leading: const Icon(Icons.delete_forever_rounded, color: Colors.red),
        onTap: () {
          // TODO: Show scary confirmation dialog
        },
      ),
      const Divider(height: 40),
    ],
  );
}
