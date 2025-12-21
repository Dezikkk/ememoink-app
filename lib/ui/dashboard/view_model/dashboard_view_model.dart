import 'package:flutter/material.dart';
import 'package:ememoink/config/di.dart';

import 'package:ememoink/data/repositories/calendar_repository.dart';
import 'package:ememoink/data/repositories/tasks_repository.dart';

import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis/tasks/v1.dart';

class DashboardViewModel extends ChangeNotifier {
  final TasksRepository _tasksRepo;
  final CalendarRepository _calendarRepo;
  bool _disposed = false;

  bool _isLoadingTasks = false;
  bool _isLoadingEvents = false;
  bool get isLoading => _isLoadingTasks || _isLoadingEvents;

  List<Task> tasks = [];
  List<Event> events = [];

  String? tasksError;
  String? eventsError;

  DashboardViewModel({
    TasksRepository? tasksRepository,
    CalendarRepository? calendarRepository,
  }) : _tasksRepo = tasksRepository ?? getIt<TasksRepository>(),
       _calendarRepo = calendarRepository ?? getIt<CalendarRepository>();

  Future<void> loadAll() async {
    await Future.wait([_loadTasks(), _loadEvents()]);
  }

  Future<void> _loadTasks() async {
    if (_disposed) return;
    _isLoadingTasks = true;
    tasksError = null;
    notifyListeners();

    try {
      final result = await _tasksRepo.getTasks();
      if (_disposed) return;
      tasks = result;
    } catch (e) {
      if (_disposed) return;
      tasksError = 'Failed loading tasks: $e';
      debugPrint('Failed loading tasks: $e');
    } finally {
      if (!_disposed) {
        _isLoadingTasks = false;
        notifyListeners();
      }
    }
  }

  Future<void> _loadEvents() async {
    if (_disposed) return;
    _isLoadingEvents = true;
    eventsError = null;
    notifyListeners();

    try {
      final result = await _calendarRepo.getUpcomingEvents();
      if (_disposed) return;
      events = result;
    } catch (e) {
      if (_disposed) return;
      eventsError = 'Failed loading events: $e';
      debugPrint('Failed loading events: $e');
    } finally {
      if (!_disposed) {
        _isLoadingEvents = false;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
