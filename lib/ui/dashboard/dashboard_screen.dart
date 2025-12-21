import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/dashboard/widgets/dashboard_section.dart';

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
          DashboardSection(
            title: 'Task list',
            sectionType: DashboardSectionType.tasks,
            maxItems: 4,
          ),
          DashboardSection(
            title: 'Events list',
            sectionType: DashboardSectionType.events,
            maxItems: 4,
          ),
        ],
      ),
    );
  }
}
