import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';

Widget buildContinueButton({
  required BuildContext context,
  required OnboardingViewModel viewModel,
}) {
  return Column(
    children: [
      Row(
        children: [
          if (!viewModel.isFirstPage && !viewModel.isLastPage) ...[
            FilledButton(
              onPressed: () {
                viewModel.skipToEnd();
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              child: Center(
                child: Text(
                  'Skip',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],

          SizedBox(width: 8),

          Expanded(
            child: FilledButton(
              onPressed: () {
                viewModel.nextPage(context);
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              child: Center(
                child: Text(
                  viewModel.isLastPage ? 'Get Started' : 'Next',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 20),
    ],
  );
}
