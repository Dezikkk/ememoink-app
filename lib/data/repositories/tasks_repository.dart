import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/tasks/v1.dart';

class TasksRepository {
  final GoogleAuthRepository _authRepo;

  TasksRepository({GoogleAuthRepository? authRepo})
    : _authRepo = authRepo ?? getIt<GoogleAuthRepository>();

  Future<TasksApi?> _getTasksClient() async {
    final client = await _authRepo.getAuthorizedClient();
    if (client == null) {
      debugPrint('No authorized client, used is not signed in');
      return null;
    }
    return TasksApi(client);
  }

  Future<List<TaskList>> getTaskLists() async {
    try {
      final client = await _getTasksClient();
      if (client == null) return [];

      final taskLists = await client.tasklists.list();
      return taskLists.items ?? [];
    } catch (e) {
      debugPrint('Failed fetching task lists: $e');
      return [];
    }
  }

  Future<List<Task>> getTasks({
    String list = '@default',
    int maxResults = 10,
    bool showCompleted = true,
    bool showHidden = false,
  }) async {
    try {
      final client = await _getTasksClient();
      if (client == null) return [];

      final tasks = await client.tasks.list(
        list,
        maxResults: maxResults,
        showCompleted: showCompleted,
        showHidden: showHidden,
      );

      return tasks.items ?? [];
    } catch (e) {
      debugPrint('Failed fetching tasks: $e');
      return [];
    }
  }

  Future<bool> addTask(
    String title, {
    String? notes,
    String taskList = '@default',
  }) async {
    // TODO: mozna dodac date i starowanie taskow
    if (title.length > 1024) return false;

    try {
      final client = await _getTasksClient();
      if (client == null) return false;

      final newTask = Task(title: title, notes: notes);

      final createdTask = await client.tasks.insert(newTask, taskList);
      debugPrint('Task with ID "${createdTask.id}" was created.');

      return true;
    } catch (e) {
      debugPrint('Failed adding task: $e');
      return false;
    }
  }
}
