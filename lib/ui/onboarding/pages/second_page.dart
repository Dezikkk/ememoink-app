import 'package:ememoink/ui/onboarding/widgets/continue_button.dart';
import 'package:flutter/material.dart';

class BuildSecondPageContent extends StatelessWidget {
  const BuildSecondPageContent({super.key});

  @override
  Widget build(BuildContext context) {
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
        buildContinueButton(context),
      ],
    );
  }
}
