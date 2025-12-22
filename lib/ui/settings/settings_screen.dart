import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/config/di.dart';
import 'view_model/settings_view_model.dart';
import 'package:ememoink/data/services/onboarding_service.dart';

import 'package:ememoink/ui/core/ui/shared_widgets/section_header.dart';
import 'package:ememoink/ui/settings/widgets/as_tiles.dart';
import 'package:ememoink/ui/settings/widgets/dnd_tiles.dart';
import 'package:ememoink/ui/settings/widgets/footer.dart';
import 'package:ememoink/ui/settings/widgets/snu_tiles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SettingsViewModel(),
      child: const _SettingsScreenContent(),
    );
  }
}

class _SettingsScreenContent extends StatelessWidget {
  const _SettingsScreenContent();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSectionHeader(context: context, title: 'App Settings'),
            SettingsAsTiles(),

            buildSectionHeader(context: context, title: 'Device & Display'),
            SettingsDndTiles(),

            buildSectionHeader(context: context, title: 'System & Updates'),
            SettingsSnuTiles(),

            SettingsFooter(),

            ElevatedButton(
              onPressed: () async {
                await getIt<OnboardingService>().reset();
              },
              child: Text('onboarding reset(restart the app after use)'),
            ),
          ],
        ),
      ),
    );
  }
}
