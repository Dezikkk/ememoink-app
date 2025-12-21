import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/ui/core/ui/shared_widgets/user_menu.dart';
import 'package:ememoink/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AuthAppBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final theme = Theme.of(context);

    return AppBar(
      title: Text(title),
      // backgroundColor: theme.colorScheme.inversePrimary,
      actions: [
        Consumer<GoogleAuthRepository>(
          builder: (context, authRepo, _) {
            if (!authRepo.isSignedIn) {
              // Login button
              return TextButton.icon(
                icon: Icon(Icons.login, color: Colors.white),
                label: Text('Sign in', style: TextStyle(color: Colors.white)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
              );
            }

            // User avatar
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () => showUserMenu(context),
                child: CircleAvatar(
                  backgroundImage: authRepo.userPhotoUrl != null
                      ? NetworkImage(authRepo.userPhotoUrl!)
                      : null,
                  child: authRepo.userPhotoUrl == null
                      ? Text(authRepo.userName?.substring(0, 1) ?? 'U')
                      : null,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
