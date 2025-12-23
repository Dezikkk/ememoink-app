import 'package:ememoink/ui/core/ui/shared_widgets/event_date_icon.dart';
import 'package:ememoink/ui/dashboard/dashboard_screen.dart';
import 'package:ememoink/ui/dashboard/view_model/dashboard_view_model.dart';
import 'package:ememoink/ui/main/view_model/main_view_model.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/tasks/v1.dart';
import 'package:provider/provider.dart';

class DashboardSection extends StatelessWidget {
  final DashboardSectionType sectionType;
  final int maxItems;

  const DashboardSection({
    super.key,
    required this.sectionType,
    required this.maxItems,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<DashboardViewModel>(
      builder: (context, vm, _) {
        final items = _getItems(context);
        final error = _getError(context);

        //loading state
        if (vm.isLoading) return SliverToBoxAdapter();

        // normal state
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
                  return _buildHeader(context, sectionType);
                }

                if (items.isEmpty) {
                  if (error != null) {
                    // error state
                    return _buildErrorItem(error);
                  }
                  // empty state
                  return _buildEmptyItem();
                }
                // see more tile
                // TODO: decide whether to leave it or delete it (probably delete it) (not showing rn)
                if (index == displayedItems.length + 1) {
                  return Text('See more');
                }

                // tasks
                final itemIndex = index - 1;
                return _buildItem(context, displayedItems[itemIndex]);
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

  List<dynamic> _getItems(BuildContext context) {
    final vm = context.read<DashboardViewModel>();

    return sectionType == DashboardSectionType.tasks ? vm.tasks : vm.events;
  }

  String? _getError(BuildContext context) {
    final vm = context.read<DashboardViewModel>();

    return sectionType == DashboardSectionType.tasks
        ? vm.tasksError
        : vm.eventsError;
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');

    if (hour < 10) {
      return '$hour:$minute  ';
    }
    return '$hour:$minute';
  }

  bool _shouldShowEndTime(DateTime? start, DateTime? end) {
    if (start == null || end == null) return false;
    return end.difference(start).inMinutes > 0;
  }

  Widget _buildHeader(BuildContext context, DashboardSectionType sectionType) {
    final theme = Theme.of(context);
    final vm = context.watch<MainViewModel>();

    return GestureDetector(
      onTap: () => sectionType == DashboardSectionType.tasks
          ? vm.setPageIndex(1)
          : vm.setPageIndex(2),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionType.title,
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

  Widget _buildItem(BuildContext context, dynamic item) {
    switch (sectionType) {
      case DashboardSectionType.tasks:
        //Tasks
        final task = item as Task;

        return ListTile(
          minTileHeight: 72,
          leading: sectionType.icon,
          title: Text(task.title ?? 'Untitled task'),
          subtitle: task.notes?.isNotEmpty == true ? Text(task.notes!) : null,
          // onTap: () {},
        );

      case DashboardSectionType.events:
        final event = item as Event;
        final start = event.start?.dateTime ?? event.start?.date;
        final end = event.end?.dateTime ?? event.end?.date;

        return ListTile(
          minTileHeight: 72,
          leading: EventDateIcon(event: event),
          title: Text(event.summary ?? 'Untitled event'),

          trailing: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (start != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.access_time, size: 16),
                    SizedBox(width: 4),
                    Text(
                      _formatTime(start),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
              if (end != null && _shouldShowEndTime(start, end))
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.arrow_forward, size: 16),
                    SizedBox(width: 4),
                    Text(
                      _formatTime(end),
                      style: const TextStyle(
                        fontSize: 14,
                        fontFeatures: [FontFeature.tabularFigures()],
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      // onTap: () {},
    }
  }

  Widget _buildEmptyItem() {
    return ListTile(
      minTileHeight: 72,
      leading: const Icon(Icons.error),
      title: Text(switch (sectionType) {
        DashboardSectionType.tasks => 'No tasks',
        DashboardSectionType.events => 'No events',
      }),
    );
  }

  Widget _buildErrorItem(String error) {
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
