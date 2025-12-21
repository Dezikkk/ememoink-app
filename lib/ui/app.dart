import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:ememoink/ui/core/ui/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/config/di.dart';
import 'package:ememoink/ui/core/ui/themes/light_theme.dart';
import 'package:ememoink/ui/core/ui/themes/dark_theme.dart';
import 'package:ememoink/ui/core/view_model/theme_view_model.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
        ChangeNotifierProvider.value(value: getIt<GoogleAuthRepository>()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            title: 'eMemo.ink',
            themeMode: themeViewModel.themeMode,
            debugShowCheckedModeBanner: false,
            home: const AuthWrapper(),
            theme: lightTheme(),
            darkTheme: darkTheme(),
          );
        },
      ),
    );
  }
}
