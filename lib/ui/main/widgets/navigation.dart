import 'package:flutter/material.dart';

import 'package:ememoink/ui/main/view_model/main_view_model.dart';
import 'package:provider/provider.dart';

Widget buildNavigation(BuildContext context) {
  final vm = context.read<MainViewModel>();

  return NavigationBar(
    selectedIndex: vm.currentPageIndex,
    onDestinationSelected: vm.setPageIndex,
    destinations: const [
      NavigationDestination(
        selectedIcon: Icon(Icons.home),
        icon: Icon(Icons.home_outlined),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Badge(child: Icon(Icons.task_alt)),
        label: 'Tasks',
      ),
      NavigationDestination(
        icon: Badge(child: Icon(Icons.calendar_month_rounded)),
        label: 'Calendar',
      ),
      // NavigationDestination(
      //   icon: Badge(child: Icon(Icons.color_lens)),
      //   label: 'Color scheme',
      // ),
      NavigationDestination(
        icon: Badge(label: Text('test'), child: Icon(Icons.settings)),
        label: 'Settings',
      ),
    ],
  );
}
