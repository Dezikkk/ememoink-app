import 'package:flutter/material.dart';

import 'package:ememoink/ui/main/view_model/main_view_model.dart';

Widget buildNavigation(BuildContext context, MainViewModel viewModel) {
  return NavigationBar(
    selectedIndex: viewModel.currentPageIndex,
    onDestinationSelected: viewModel.setPageIndex,
    destinations: const [
      NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Badge(child: Icon(Icons.calendar_month_rounded)),
        label: 'Calendar',
      ),
      NavigationDestination(
        icon: Badge(child: Icon(Icons.color_lens)),
        label: 'Color scheme',
      ),
      NavigationDestination(
        icon: Badge(label: Text('test'), child: Icon(Icons.settings)),
        label: 'Settings',
      ),
    ],
  );
}
