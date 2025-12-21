import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/ui/core/ui/shared_widgets/logo.dart';
import 'package:ememoink/ui/login/view_model/login_view_model.dart';
import 'package:ememoink/ui/login/widgets/google_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const _LoginScreenContent(),
    );
  }
}

class _LoginScreenContent extends StatelessWidget {
  const _LoginScreenContent();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Align(
              alignment: Alignment(0.0, -0.45),
              child: Container(
                margin: const EdgeInsets.all(20),
                width: screenWidth * 0.6,
                height: screenWidth * 0.6,
                child: buildLogo(context),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(flex: 4),
                  _buildTextContent(context),
                  const Spacer(flex: 1),
                  buildGoogleButton(context, getIt<GoogleAuthRepository>()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildTextContent(BuildContext context) {
  ThemeData theme = Theme.of(context);

  return Column(
    children: [
      Text(
        'Sign in to eMemo.ink app!',
        textAlign: TextAlign.center,
        style: theme.textTheme.headlineSmall?.copyWith(
          color: theme.colorScheme.primary,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
      const SizedBox(height: 16),
      Text(
        'Sign in with your Google account to continue and access all your memories in one place',
        textAlign: TextAlign.center,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          height: 1.5,
        ),
      ),
    ],
  );
}
