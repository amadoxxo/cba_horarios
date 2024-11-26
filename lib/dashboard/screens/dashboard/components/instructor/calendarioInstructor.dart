// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:horarios_cba/dashboard/calendar/meeting.dart';
import 'package:horarios_cba/dashboard/calendar/meeting_data_source.dart';
import 'package:horarios_cba/constantsDesign.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarioInstructor extends StatefulWidget {
  const CalendarioInstructor({super.key});

  @override
  State<CalendarioInstructor> createState() => _CalendarioInstructorState();
}

class _CalendarioInstructorState extends State<CalendarioInstructor> {
  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(Meeting(
        'Conference 1', startTime, endTime, const Color(0xFF0F8644), false));
    meetings.add(Meeting(
        'Conference 2', startTime, endTime, const Color(0xFF0F8649), false));
    meetings.add(Meeting(
        'Conference 3', startTime, endTime, const Color(0xFF0F8644), false));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Horario",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontFamily: 'Calibri-Bold'),
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        SizedBox(
          width: double.infinity,
          height: 600,
          child: SfCalendar(
            headerStyle: const CalendarHeaderStyle(
                textAlign: TextAlign.center,
                backgroundColor: primaryColor,
                textStyle: TextStyle(
                    fontSize: 25,
                    fontStyle: FontStyle.normal,
                    letterSpacing: 5,
                    color: Colors.white,
                    fontWeight: FontWeight.w500)),
            view: CalendarView.month,
            todayHighlightColor: primaryColor,
            initialSelectedDate: DateTime.now(),
            cellBorderColor: Colors.transparent,
            dataSource: MeetingDataSource(_getDataSource()),
            selectionDecoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: primaryColor, width: 2),
              borderRadius: const BorderRadius.all(Radius.circular(4)),
              shape: BoxShape.rectangle,
            ),
            monthViewSettings: const MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                showAgenda: true),
            blackoutDates: [
              DateTime.now().subtract(const Duration(hours: 48)),
              DateTime.now().subtract(const Duration(hours: 24)),
            ],
            timeZone: 'America/Bogota',
          ),
        ),
      ],
    );
  }
}
