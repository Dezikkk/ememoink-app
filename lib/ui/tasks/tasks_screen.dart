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
      onRefresh: () => context.read<TasksViewModel>().loadTasks(),
      child: Consumer<TasksViewModel>(
        builder: (context, vm, _) {
          return CustomScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
              SliverPadding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
                sliver: SliverFixedExtentList(
                  itemExtent: 60.0,
                  delegate: SliverChildBuilderDelegate(
                    childCount: vm.tasks.length*3,
                    (BuildContext context, int index) {
                      return Container(
                        alignment: Alignment.center,
                        color: Colors.lightBlue[100 * (index % 9)],
                        child: Text('list item $index'),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
