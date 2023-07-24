// ignore_for_file: prefer_const_constructors, camel_case_types, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar_B_Nav extends StatefulWidget {
  const Calendar_B_Nav({super.key});
  @override
  State<Calendar_B_Nav> createState() => _Calendar_B_NavState();
}

class _Calendar_B_NavState extends State<Calendar_B_Nav> {
  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    void _onDaySelected(DateTime day, DateTime focusedDay) {
      setState(() {
        today = day;
      });
    }

    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TableCalendar(
            headerStyle:
                HeaderStyle(formatButtonVisible: false, titleCentered: true),
            availableGestures: AvailableGestures.all,
            onDaySelected: _onDaySelected,
            selectedDayPredicate: (day) => isSameDay(day, today),
            focusedDay: today,
            calendarStyle: CalendarStyle(),
            firstDay: DateTime.utc(2001, 1, 1),
            lastDay: DateTime.utc(2050, 12, 1),
          ),
        ],
      ),
    ));
  }
}
