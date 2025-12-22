import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/dashboard/widgets/dashboard_section.dart';
import 'package:ememoink/ui/dashboard/widgets/dashboard_carousel_indicator.dart';
import 'package:ememoink/ui/dashboard/widgets/dashboard_carousel_view.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel()..loadAll(),
      child: const _DashboardContent(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<DashboardViewModel>().loadAll(),
      child: CustomScrollView(
        slivers: [
          DashboardCarouselView(),
          DashboardCarouselIndicator(),
          DashboardSection(
            sectionType: DashboardSectionType.tasks,
            maxItems: 4,
          ),
          DashboardSection(
            sectionType: DashboardSectionType.events,
            maxItems: 4,
          ),
        ],
      ),
    );
  }
}

enum DashboardSectionType {
  tasks(title: 'Task list', icon: Icon(Icons.task_alt)),
  events(title: 'Events list', icon: Icon(Icons.event));

  const DashboardSectionType({required this.title, required this.icon});
  final String title;
  final Icon icon;
}

enum CarouselCardInfo {
  tasks(
    title: 'Tasks Today',
    subtitle: '5 tasks pending',
    icon: Icons.task_alt,
  ),
  events(
    title: 'Upcoming Events',
    subtitle: '3 events this week',
    icon: Icons.event,
  ),
  deviceinfo(
    title: 'Device info',
    subtitle: 'battery 4%',
    icon: Icons.event,
  );

  const CarouselCardInfo({
    required this.title,
    required this.subtitle,
    required this.icon,

  });

  final String title;
  final String subtitle;
  final IconData icon;

  Color getColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (this) {
      CarouselCardInfo.tasks => colorScheme.primary,
      CarouselCardInfo.events => colorScheme.secondary,
      CarouselCardInfo.deviceinfo => colorScheme.tertiary,
    };
  }

  Color getBackgroundColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return switch (this) {
      CarouselCardInfo.tasks => colorScheme.primaryContainer,
      CarouselCardInfo.events => colorScheme.secondaryContainer,
      CarouselCardInfo.deviceinfo => colorScheme.tertiaryContainer,
    };
  }
}