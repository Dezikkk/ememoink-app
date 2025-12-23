import 'package:ememoink/ui/core/ui/shared_widgets/selection_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/tasks/view_model/tasks_view_model.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksViewModel()..loadTasks(),
      child: const _TasksScreenContent(),
    );
  }
}

class _TasksScreenContent extends StatelessWidget {
  const _TasksScreenContent();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        final vm = context.read<TasksViewModel>();
        vm.clearSelection();
        return vm.loadTasks();
      },
      child: Consumer<TasksViewModel>(
        builder: (context, vm, _) {
          if (vm.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return Scaffold(
            body: CustomScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // TODO:
                // ADD INDICATORS(REMAINING TASKS, COMPLETED TASKS, OVERDUE TASKS)
                // flutter pub add percent_indicator
                // round icons with add task and some more
                // add panel priority tasks ad recently added
                _buildRecentTasksList(context),
              ],
            ),

            //bottom
            bottomNavigationBar: SelectionBottomBar(
              viewModel: vm,
              menuItems: _menuItems,
              onCancel: vm.clearSelection,
              onDelete: vm.deleteTasksById,
            ),
          );
        },
      ),
    );
  }

  // get so hot reload can work :D
  static List<MenuItem> get _menuItems => [
    MenuItem(
      icon: Icons.check_circle_outline,
      label: 'Mark Complete',
      onPressed: () => debugPrint('Mark Complete'),
    ),
    MenuItem.separator(),
    MenuItem(
      icon: Icons.star_outline,
      label: 'Star',
      onPressed: () => debugPrint('Star'),
    ),
    MenuItem.separator(),
    MenuItem(
      icon: Icons.link,
      label: 'Get Link',
      onPressed: () => debugPrint('Get Link'),
    ),
    MenuItem.separator(),
    MenuItem(
      icon: Icons.share_outlined,
      label: 'Share',
      onPressed: () => debugPrint('Share'),
    ),
    MenuItem.separator(),
  ];

  Widget _buildRecentTasksList(BuildContext context) {
    final vm = context.read<TasksViewModel>();
    final theme = Theme.of(context);

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      sliver: DecoratedSliver(
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
        ),
        sliver: SliverList.separated(
          itemCount: vm.tasks.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              return _buildHeader(context, 'Recently added');
            }

            int taskIndex = index - 1;
            final taskId = vm.tasks[taskIndex].id;

            return ListTile(
              leading: taskId == null
                  ? Checkbox(value: false, onChanged: (value) {})
                  : Checkbox(
                      value: vm.isTaskSelected(taskId),
                      onChanged: (bool? value) =>
                          vm.toggleTaskSelection(taskId),
                    ),
              title: Text(vm.tasks[taskIndex].title ?? 'Untitled task'),
              subtitle: vm.tasks[taskIndex].notes?.isNotEmpty == true
                  ? Text(vm.tasks[taskIndex].notes!)
                  : null,
            );
          },
          separatorBuilder: (_, index) {
            if (index == 0 || index == vm.tasks.length + 1) {
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
  }

  Widget _buildHeader(BuildContext context, String title) {
    final theme = Theme.of(context);

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
            Icon(Icons.add, color: theme.colorScheme.primary),
          ],
        ),
      ),
    );
  }
}
