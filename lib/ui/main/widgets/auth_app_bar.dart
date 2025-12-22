import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/ui/core/ui/shared_widgets/user_menu.dart';
import 'package:ememoink/ui/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AuthAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vm = context.watch<GoogleAuthRepository>();

    return AppBar(
      titleSpacing: 16,
      forceMaterialTransparency: true,
      // surfaceTintColor: theme.colorScheme.onSurface,
      // scrolledUnderElevation: 4.0,
      // shadowColor: theme.colorScheme.shadow,
      title: vm.isSignedIn
          ? GestureDetector(
              onTap: () => showUserMenu(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircleAvatar(
                    backgroundImage: vm.userPhotoUrl != null
                        ? NetworkImage(vm.userPhotoUrl!)
                        : null,
                    child: vm.userPhotoUrl == null
                        ? Text(vm.userName?.substring(0, 1) ?? 'U')
                        : null,
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Text(
                      vm.userName ?? 'User',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.arrow_drop_down,
                    size: 24,
                    color: theme.colorScheme.onPrimaryContainer,
                  ),
                ],
              ),
            )
          : TextButton.icon(
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text(
                'Sign in',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              },
            ),

      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: IconButton(
            onPressed: () {},
            icon: Icon(Icons.bluetooth_disabled),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
