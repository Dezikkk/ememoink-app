import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/onboarding/view_model/onboarding_view_model.dart';

import 'package:ememoink/ui/onboarding/pages/first_page.dart';
import 'package:ememoink/ui/onboarding/pages/second_page.dart';
import 'package:ememoink/ui/onboarding/pages/third_page.dart';

import 'package:ememoink/ui/core/ui/shared_widgets/logo.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: const OnboardingScreenContent(),
    );
  }
}

class OnboardingScreenContent extends StatelessWidget {
  const OnboardingScreenContent({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OnboardingViewModel>();
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: PageView(
                controller: viewModel.controller,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  BuildFirstPageContent(),
                  BuildSecondPageContent(),
                  BuildThirdPageContent(),
                ],
              ),
            ),

            // if (viewModel.currentPage < 2)
            AnimatedAlign(
              duration: Duration(milliseconds: viewModel.animDuration),
              curve: Curves.easeInOut,
              alignment: viewModel.currentPage == 0
                  ? Alignment(0.0, -0.45)
                  : Alignment.topLeft,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                margin: EdgeInsets.all(20),
                width: viewModel.currentPage == 0 ? size.width * 0.6 : 60,
                height: viewModel.currentPage == 0 ? size.width * 0.6 : 60,
                child: buildLogo(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
