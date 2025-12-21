import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';
import 'package:ememoink/ui/onboarding/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildFirstPageContent extends StatelessWidget {
  const BuildFirstPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Spacer(flex: 4),
        _buildTextContent(context),
        const Spacer(flex: 1),
        buildContinueButton(context: context, viewModel: viewModel),
      ],
    );
  }
}

Widget _buildTextContent(BuildContext context) {
  ThemeData theme = Theme.of(context);

  return Column(
    children: [
      Text(
        'Welcome to eMemo.ink app!',
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Connect your device to Google Calendar.\nOne-time setup, automatic sync, zero maintenance.',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),
    ],
  );
}
