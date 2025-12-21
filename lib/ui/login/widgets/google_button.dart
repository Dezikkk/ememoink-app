import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/ui/main/main_screen.dart';
import 'package:flutter/material.dart';

Widget buildGoogleButton(BuildContext context, GoogleAuthRepository authRepo) {
  const String iconPath = 'assets/google/android_light_rd_na@1x.png';

  return Column(
    children: [
      FilledButton(
        onPressed: () {
          authRepo.isLoading ? null : _handleSignIn(context, authRepo);
        },
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: authRepo.isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(iconPath, height: 24),
                  ),
                  const SizedBox(width: 12),
                  const Text(
                    "Sign in with Google",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
      ),
      const SizedBox(height: 20),
    ],
  );
}

Future<void> _handleSignIn(
  BuildContext context,
  GoogleAuthRepository authRepo,
) async {
  if (!authRepo.isSignedIn) {
    final success = await authRepo.signIn();

    if (success && context.mounted) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
    }
  } else {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (_) => const MainScreen()));
  }
}
