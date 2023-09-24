import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_Events.dart';
import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_States.dart';
import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_bloc.dart';
import 'package:attendance_app/New_Attandance/Bottom_Nav_Screens/Check_Nav_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Bottom_Nav_Screens/User_Nav_Screen.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({super.key});
  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
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
      UserProfile(),
      AttendanceScreen(),
      UserProfile(),
    ];

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
            backgroundColor: Colors.blue,
            body: Center(child: bottomNavScreen[state.tabIndex]),
            bottomNavigationBar: BottomNavigationBar(
              items: bottomNavIcons,
              currentIndex:
                  BlocProvider.of<BottomNavBloc>(context).state.tabIndex,
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
