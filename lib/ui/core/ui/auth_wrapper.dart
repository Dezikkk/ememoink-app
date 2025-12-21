import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/config/di.dart';

import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/data/services/onboarding_service.dart';

import 'package:ememoink/ui/login/login_screen.dart';
import 'package:ememoink/ui/main/main_screen.dart';
import 'package:ememoink/ui/onboarding/onboarding_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final onboardingService = getIt<OnboardingService>();

    return Consumer<GoogleAuthRepository>(
      builder: (context, authRepo, _) {
        if (authRepo.isLoading) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        }

        if (!onboardingService.isCompleted) {
          return const OnboardingScreen();
        }

        if (!authRepo.isSignedIn) {
          return const LoginScreen();
        }

        return const MainScreen();
      },
    );
  }
}
