import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';
import 'package:ememoink/ui/onboarding/widgets/continue_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildThirdPageContent extends StatelessWidget {
  const BuildThirdPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();

    return Column(
      children: [
        Expanded(
          child: Center(
            child: Text(
              'connect with google calendar and keep everything organized',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Spacer(flex: 1),
        buildContinueButton(context: context, viewModel: viewModel),
      ],
    );
  }
}
