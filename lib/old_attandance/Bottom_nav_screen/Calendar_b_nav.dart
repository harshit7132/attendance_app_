// // ignore_for_file: prefer_const_constructors, camel_case_types, no_leading_underscores_for_local_identifiers, file_names
//
// import 'package:attendance_app/calander/Meeting_data.dart';
// import 'package:attendance_app/calander/mettings.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:syncfusion_flutter_calendar/calendar.dart';
//
// class Calendar_B_Nav extends StatefulWidget {
//   const Calendar_B_Nav({super.key});
//   @override
//   State<Calendar_B_Nav> createState() => _Calendar_B_NavState();
// }
//
// class _Calendar_B_NavState extends State<Calendar_B_Nav> {
//   @override
//   Widget build(BuildContext context) {
//     List<Mettings> _getDataSource() {
//       final List<Mettings> meetings = <Mettings>[];
//       final DateTime today = DateTime.now();
//       final DateTime startTime =
//           DateTime(today.year, today.month, today.day, 9, 0, 0);
//       final DateTime endTime = startTime.add(Duration(hours: 2));
//       meetings
//           .add(Mettings('Birthday', startTime, endTime, Colors.black, false));
//       return meetings;
//     }
//
//     CalendarView calendarView = CalendarView.month;
//     CalendarController controller = CalendarController();
//     return Scaffold(
//         body: Column(
//       children: [
//         SizedBox(height: 50.h),
//         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   calendarView = CalendarView.month;
//                   controller.view = calendarView;
//                 });
//               },
//               child: Text('Month View')),
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   calendarView = CalendarView.week;
//                   controller.view = calendarView;
//                 });
//               },
//               child: Text('Week View')),
//           TextButton(
//               onPressed: () {
//                 setState(() {
//                   calendarView = CalendarView.day;
//                   controller.view = calendarView;
//                 });
//               },
//               child: Text('Day View'))
//         ]),
//         SizedBox(height: 50.h),
//         Expanded(
//           child: SfCalendar(
//             controller: controller,
//             view: calendarView,
//             cellBorderColor: Colors.transparent,
//             dataSource: MeetingData(_getDataSource()),
//             selectionDecoration: BoxDecoration(
//                 color: Colors.transparent,
//                 border: Border.all(color: Colors.red, width: 2),
//                 borderRadius: BorderRadius.all(Radius.circular(10)),
//                 shape: BoxShape.rectangle),
//             monthViewSettings: MonthViewSettings(
//                 appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
//                 showAgenda: true),
//           ),
//         ),
//       ],
//     ));
//   }
// }
