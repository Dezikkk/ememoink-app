import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/tasks/v1.dart';

class TasksRepository {
  final GoogleAuthRepository _authRepo;

  TasksRepository({GoogleAuthRepository? authRepo})
    : _authRepo = authRepo ?? getIt<GoogleAuthRepository>();

  Future<TasksApi> _getTasksClient() async {
    final client = await _authRepo.getAuthorizedClient();
    if (client == null) {
      debugPrint('No authorized client, used is not signed in');
      throw Exception('User not signed in');
    }
    return TasksApi(client);
  }

  Future<List<TaskList>> getTaskLists() async {
    try {
      final client = await _getTasksClient();

      final taskLists = await client.tasklists.list();
      return taskLists.items ?? [];
    } catch (e) {
      debugPrint('Failed fetching task lists: $e');
      throw Exception(e);
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

      final tasks = await client.tasks.list(
        list,
        maxResults: maxResults,
        showCompleted: showCompleted,
        showHidden: showHidden,
      );

      return tasks.items ?? [];
    } catch (e) {
      debugPrint('Failed fetching tasks: $e');
      throw Exception(e);
    }
  }

  Future<void> addTask(
    String title, {
    String? notes,
    String taskList = '@default',
  }) async {
    // TODO: mozna dodac date i starowanie taskow
    if (title.isEmpty) {
      throw ArgumentError('Title cannot be empty');
    }
    if (title.length > 1024) {
      throw ArgumentError('Title too long (max 1024 characters)');
    }

    try {
      final client = await _getTasksClient();
      final newTask = Task(title: title, notes: notes);
      final createdTask = await client.tasks.insert(newTask, taskList);
      debugPrint('Task with ID "${createdTask.id}" was created.');
    } catch (e) {
      debugPrint('Failed adding task: $e');
      throw Exception(e);
    }
  }
}
