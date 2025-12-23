import 'package:flutter/material.dart';
import 'package:ememoink/config/di.dart';

import 'package:ememoink/data/repositories/tasks_repository.dart';
import 'package:googleapis/tasks/v1.dart';

class TasksViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepo;

  bool _disposed = false;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Task> tasks = [];
  String? _error;
  String? get error =>
      _error?.split('message: ').last.replaceAll(RegExp(r'.$'), '');

  Set<String> selectedTaskIds = {};
  int get selectedCount => selectedTaskIds.length;

  TasksViewModel({TasksRepository? tasksRepository})
    : _tasksRepo = tasksRepository ?? getIt<TasksRepository>();

  Future<void> loadTasks() async {
    if (_disposed) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      final result = await _tasksRepo.getTasks(maxResults: 100);
      if (_disposed) return;
      tasks = result;
    } catch (e) {
      if (_disposed) return;
      tasks = [];
      _error = '$e';
    } finally {
      if (!_disposed) {
        _isLoading = false;
        notifyListeners();
      }
    }
  }

  Future<void> deleteTask(String taskId) async {
    if (_disposed) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await _tasksRepo.deleteTask(taskId: taskId);
    } catch (e) {
      if (_disposed) return;
      await loadTasks();
      _error = '$e';
    } finally {
      if (!_disposed) {
        _isLoading = false;
        await loadTasks();
        notifyListeners();
      }
    }
  }

  Future<void> deleteTasksById() async {
    if (_disposed) return;
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.wait(
        selectedTaskIds.map((taskId) => _tasksRepo.deleteTask(taskId: taskId)),
      );
    } catch (e) {
      if (_disposed) return;
      await loadTasks();
      _error = '$e';
    } finally {
      if (!_disposed) {
        _isLoading = false;
        clearSelection();
        await loadTasks();
        notifyListeners();
      }
    }
  }

  bool isTaskSelected(String taskId) {
    return selectedTaskIds.contains(taskId);
  }

  void toggleTaskSelection(String taskId) {
    if (selectedTaskIds.contains(taskId)) {
      selectedTaskIds.remove(taskId);
    } else {
      selectedTaskIds.add(taskId);
    }
    notifyListeners();
  }

  void clearSelection() {
    selectedTaskIds.clear();
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
