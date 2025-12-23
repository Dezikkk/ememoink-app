import 'package:ememoink/ui/onboarding/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class BuildThirdPageContent extends StatelessWidget {
  const BuildThirdPageContent({super.key});

  @override
  Widget build(BuildContext context) {
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
        buildContinueButton(context),
      ],
    );
  }
}
