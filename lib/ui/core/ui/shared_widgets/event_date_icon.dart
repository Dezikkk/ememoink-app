import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

class EventDateIcon extends StatelessWidget {
  final Event event;

  const EventDateIcon({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    final start = event.start?.dateTime ?? event.start?.date;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (start != null) ...[
            Text(
              '${start.day}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              _getMonthName(start.month),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        ],
      ),
    );
  }

  static String _getMonthName(int month) {
    const months = [
      'JAN',
      'FEB',
      'MAR',
      'APR',
      'MAY',
      'JUN',
      'JUL',
      'AUG',
      'SEP',
      'OCT',
      'NOV',
      'DEC',
    ];

    return months[month - 1];
  }
}
