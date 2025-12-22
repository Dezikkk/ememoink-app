import 'package:carousel_slider/carousel_controller.dart';
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

  int _currentPage = 0;
  int get currentPage => _currentPage;
  set currentPage(int value) {
    if (_currentPage != value) {
      _currentPage = value;
      notifyListeners();
    }
  }

  final CarouselSliderController carouselController =
      CarouselSliderController();

  bool _isLoadingTasks = false;
  bool _isLoadingEvents = false;
  bool get isLoading => _isLoadingTasks || _isLoadingEvents;

  List<Task> tasks = [];
  List<Event> events = [];

  String? _tasksError;
  String? _eventsError;
  String? get tasksError =>
      _tasksError?.split('message: ').last.replaceAll(RegExp(r'.$'), '');
  String? get eventsError =>
      _eventsError?.split('message: ').last.replaceAll(RegExp(r'.$'), '');

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
    _tasksError = null;
    notifyListeners();

    try {
      final result = await _tasksRepo.getTasks();
      if (_disposed) return;
      tasks = result;
    } catch (e) {
      if (_disposed) return;
      tasks = [];
      _tasksError = '$e';
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
    _eventsError = null;
    notifyListeners();

    try {
      final result = await _calendarRepo.getUpcomingEvents();
      if (_disposed) return;
      events = result;
    } catch (e) {
      events = [];
      if (_disposed) return;
      _eventsError = '$e';
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
