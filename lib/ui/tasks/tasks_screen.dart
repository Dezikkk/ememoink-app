import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:ememoink/ui/tasks/view_model/tasks_view_model.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksViewModel(),
      child: const _TasksScreenContent(),
    );
  }
}

class _TasksScreenContent extends StatelessWidget {
  const _TasksScreenContent();

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
