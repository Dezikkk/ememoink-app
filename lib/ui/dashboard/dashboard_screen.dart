import 'package:ememoink/ui/core/ui/shared_widgets/section_header.dart';
import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/dashboard/widgets/list_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DashboardViewModel(),
      child: const _DashboardContent(),
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<DashboardViewModel>(
      builder: (context, vm, _) {
        // Loading
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TODO: dodac karuzelke z tasks completed i upcomming events this week/month czy jakies gowno

              // events section
              // Moze sectionheader w liscie?? jak np w fit app na ios, tylko przerobic pozniej w settingsach
              buildSectionHeader(context: context, title: 'TODOs'),
              buildListContainer(
                theme: theme,
                itemCount: 3,
                itemBuilder: (index) => ListTile(
                  leading: const Icon(Icons.star),
                  title: Text('Recent Item $index'),
                  subtitle: Text('Description for item $index'),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('See more'),
                ),
              ),

              // todos section
              buildSectionHeader(context: context, title: 'Upcoming events'),
              buildListContainer(
                theme: theme,
                itemCount: 2,
                itemBuilder: (index) => ListTile(
                  leading: const Icon(Icons.trending_up),
                  title: Text('Popular Item $index'),
                  subtitle: Text('Trending now'),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('See more'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
