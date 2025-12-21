import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showUserMenu(BuildContext context) {
  final authRepo = context.read<GoogleAuthRepository>();

  showModalBottomSheet(
    context: context,
    builder: (context) => Container(
      padding: EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<GoogleAuthRepository>(
            builder: (context, auth, _) {
              return Column(
                children: [
                  if (auth.userPhotoUrl != null)
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(auth.userPhotoUrl!),
                    ),
                  SizedBox(height: 16),
                  Text(
                    auth.userName ?? 'User',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    auth.userEmail ?? '',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              );
            },
          ),

          Divider(height: 32),

          // ListTile(
          //   leading: Icon(Icons.person),
          //   title: Text('Profile'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, '/profile');
          //   },
          // ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () {
          //     Navigator.pop(context);
          //     Navigator.pushNamed(context, '/settings');
          //   },
          // ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.red),
            title: Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () async {
              await authRepo.signOut();
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
    ),
  );
}
