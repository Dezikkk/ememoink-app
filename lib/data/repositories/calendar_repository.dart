import 'package:ememoink/config/di.dart';
import 'package:ememoink/data/repositories/auth_repository.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:flutter/foundation.dart';

class CalendarRepository {
  final GoogleAuthRepository _authRepo;

  CalendarRepository({GoogleAuthRepository? authRepo})
    : _authRepo = authRepo ?? getIt<GoogleAuthRepository>();

  Future<CalendarApi> _getCalendarClient() async {
    final client = await _authRepo.getAuthorizedClient();
    if (client == null) {
      debugPrint('No authorized client, used is not signed in');
      throw Exception('User not signed in');
    }
    return CalendarApi(client);
  }

  Future<List<Event>> getUpcomingEvents({
    DateTime? dateTime,
    int maxResults = 10,
  }) async {
    final client = await _getCalendarClient();

    try {
      final events = await client.events.list(
        'primary',
        timeMin: dateTime ?? DateTime.now().toUtc(),
        singleEvents: true,
        orderBy: 'startTime',
        maxResults: maxResults,
      );
      return events.items ?? [];
    } catch (e) {
      debugPrint('Failed fetching events: $e');
      throw Exception(e);
    }
  }

  Future<void> addEvent({
    required String title,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    final client = await _getCalendarClient();

    final event = Event(
      summary: title,
      start: EventDateTime(dateTime: startTime.toUtc()),
      end: EventDateTime(dateTime: endTime.toUtc()),
    );

    try {
      await client.events.insert(event, 'primary');
    } catch (e) {
      debugPrint('Failed adding event: $e');
      throw Exception(e);
    }
  }
}
