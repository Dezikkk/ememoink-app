import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';
import 'package:ememoink/ui/onboarding/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildSecondPageContent extends StatelessWidget {
  const BuildSecondPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'open source project, no collecting data',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        buildContinueButton(
          context: context,
          viewModel: viewModel,
        ),
      ],
    );
  }
}
