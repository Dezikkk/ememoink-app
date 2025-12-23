import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget buildContinueButton(BuildContext context) {
  final vm = context.read<OnboardingViewModel>();

  return Column(
    children: [
      Row(
        children: [
          if (!vm.isFirstPage && !vm.isLastPage) ...[
            FilledButton(
              onPressed: () {
                vm.skipToEnd();
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
                vm.nextPage(context);
              },
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
              ),
              child: Center(
                child: Text(
                  vm.isLastPage ? 'Get Started' : 'Next',
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
