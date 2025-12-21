import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/tasks/v1.dart';
import 'package:provider/provider.dart';

enum DashboardSectionType { tasks, events }

class DashboardSection extends StatelessWidget {
  final String title;
  final DashboardSectionType sectionType;
  final int maxItems;

  const DashboardSection({
    super.key,
    required this.title,
    required this.sectionType,
    required this.maxItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<DashboardViewModel>(
      builder: (context, vm, _) {
        final items = _getItems(vm);
        final error = _getError(vm);

        //loading state
        if (vm.isLoading) {
          return SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // error i empty state

        // succes state
        final displayedItems = items.take(maxItems).toList();

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          sliver: DecoratedSliver(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
            ),
            sliver: SliverList.separated(
              itemCount: items.isEmpty ? 2 : items.take(maxItems).length + 1,
              itemBuilder: (context, index) {
                // title tile
                if (index == 0) {
                  return _buildHeader(theme);
                }

                if (items.isEmpty) {
                  if (error != null) {
                    return _buildErrorItem(theme, error);
                  }
                  return _buildEmptyItem(theme);
                }
                // see more tile
                // TODO: zdecyduj czy to zostawic czy wywalic(chyba wywalic)
                if (index == displayedItems.length + 1) {
                  return Text('See more');
                }

                // tasks
                final itemIndex = index - 1;
                return _buildItem(theme, displayedItems[itemIndex]);
              },
              separatorBuilder: (_, index) {
                if (index == 0 || index == displayedItems.length + 1) {
                  return Divider(height: 0.0);
                }

                return const Divider(
                  height: 0.0,
                  thickness: 0.0,
                  indent: 20.0,
                  endIndent: 20.0,
                );
              },
            ),
          ),
        );
      },
    );
  }

  List<dynamic> _getItems(DashboardViewModel vm) {
    return sectionType == DashboardSectionType.tasks ? vm.tasks : vm.events;
  }

  String? _getError(DashboardViewModel vm) {
    return sectionType == DashboardSectionType.tasks
        ? vm.tasksError
        : vm.eventsError;
  }

  Widget _buildHeader(ThemeData theme) {
    return GestureDetector(
      onTap: () => {},
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Icon(Icons.chevron_right, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(ThemeData theme, dynamic item) {
    switch (sectionType) {
      case DashboardSectionType.tasks:
        //Tasks
        final task = item as Task;

        return ListTile(
          minTileHeight: 72,
          leading: const Icon(Icons.task_alt),
          title: Text(task.title ?? 'Untitled task'),
          subtitle: task.notes?.isNotEmpty == true ? Text(task.notes!) : null,
          // onTap: () {},
        );

      case DashboardSectionType.events:
        final event = item as Event;

        return ListTile(
          minTileHeight: 72,
          leading: const Icon(Icons.event),
          title: Text(event.summary ?? 'Untitled event'),
          // onTap: () {},
        );
    }
  }

  Widget _buildEmptyItem(ThemeData theme) {
    return ListTile(
      minTileHeight: 72,
      leading: const Icon(Icons.error),
      title: Text(switch (sectionType) {
        DashboardSectionType.tasks => 'No tasks',
        DashboardSectionType.events => 'No events',
      }),
    );
  }

  Widget _buildErrorItem(ThemeData theme, String error) {
    return ListTile(
      minTileHeight: 72,
      leading: const Icon(Icons.error),
      title: Text(switch (sectionType) {
        DashboardSectionType.tasks => 'Error: $error',
        DashboardSectionType.events => 'Error: $error',
      }),
    );
  }
}
