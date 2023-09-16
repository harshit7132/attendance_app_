// ignore_for_file: camel_case_types, file_names
import 'package:attendance_app/Bottom_nav_screen/User_b_nav.dart';
import 'package:attendance_app/calander/event_calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../bloc/bottom_nav_bloc.dart';
import '../example1.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});
  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavIcons = <BottomNavigationBarItem>[
      const BottomNavigationBarItem(
          label: 'Calender',
          icon: Icon(
            FontAwesomeIcons.calendar,
          )),
      const BottomNavigationBarItem(
          label: 'Check',
          icon: Icon(
            FontAwesomeIcons.check,
          )),
      const BottomNavigationBarItem(
          label: 'User', icon: Icon(FontAwesomeIcons.user))
    ];

    List<Widget> bottomNavScreen = <Widget>[
      EventCalendarScreen(),
      AttendanceScreen(),
       UserProfile(),
    ];

    return BlocBuilder<BottomNavBloc, BottomNavState>(
    builder: (context, state) {
    return Scaffold(backgroundColor: Colors.blue,
        body: Center(child: bottomNavScreen[state.tabIndex]),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomNavIcons,
          currentIndex: BlocProvider.of<BottomNavBloc>(context).state.tabIndex,
          onTap: (index) {
            setState(() {
              BlocProvider.of<BottomNavBloc>(context)
                  .add(Tabchange(tabIndex: index));
            });
          },
          selectedItemColor: Colors.red,
        ));
  },
);
  }
}