import 'package:ememoink/ui/calendar/calendar_screen.dart';
import 'package:ememoink/ui/colorscheme_test/colorscheme_test.dart';
import 'package:ememoink/ui/main/widgets/auth_app_bar.dart';
import 'package:ememoink/ui/dashboard/dashboard_screen.dart';
import 'package:ememoink/ui/main/widgets/navigation.dart';
import 'package:ememoink/ui/settings/settings_screen.dart';
import 'package:ememoink/ui/tasks/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/main/view_model/main_view_model.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainViewModel(),
      child: const _MainScreenContent(),
    );
  }
}

class _MainScreenContent extends StatelessWidget {
  const _MainScreenContent();

  static const List<Widget> _pages = [
    DashboardScreen(),
    TasksScreen(),
    CalendarScreen(),
    // ColorSchemeTest(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MainViewModel>();

    return Scaffold(
      appBar: AuthAppBar(),
      body: _pages[viewModel.currentPageIndex],
      bottomNavigationBar: buildNavigation(context, viewModel),
    );
  }
}
