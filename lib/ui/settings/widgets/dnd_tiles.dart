import 'package:flutter/material.dart';

class SettingsDndTiles extends StatelessWidget {
  const SettingsDndTiles({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: const Text("Wake Up Interval"),
          subtitle: const Text("Every 1 hour"),
          leading: const Icon(Icons.timer_outlined),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () {
            // TODO: Open interval picker
          },
        ),
        SwitchListTile(
          title: const Text("Invert Colors"),
          secondary: const Icon(Icons.invert_colors_rounded),
          value: false, // TODO: Podepnij pod viewModel.isInverted
          onChanged: (bool value) {
            // TODO: viewModel.toggleInvert(value);
          },
        ),
        ListTile(
          title: const Text("Refresh Screen"),
          subtitle: const Text("Clear ghosting"),
          leading: const Icon(Icons.cleaning_services_rounded),
          onTap: () {
            // TODO: Send refresh command
          },
        ),
      ],
    );
  }
}
