import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/calendar_repository.dart';
import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

class CalendarViewModel extends ChangeNotifier {
  final CalendarRepository _repo;

  List<Event> events = [];
  bool isLoading = false;
  String? error;
  bool _disposed = false;

  CalendarViewModel({CalendarRepository? repo})
    : _repo = repo ?? getIt<CalendarRepository>();

  Future<void> loadEvents() async {
    if (_disposed) return;
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final result = await _repo.getUpcomingEvents();
      if (_disposed) return;
      events = result;
    } catch (e) {
      if (_disposed) return;
      error = 'Failed to load events: $e';
      debugPrint('Failed to load events: $e');
    } finally {
      if (!_disposed) {
        isLoading = false;
        notifyListeners();
      }
    }
  }

  void clearError() {
    if (_disposed) return;
    error = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
