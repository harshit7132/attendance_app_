import 'dart:async';
import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});
  @override
  State<Splash_screen> createState() => Splash_screenState();
}

class Splash_screenState extends State<Splash_screen> {
  static String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();
    wheretogo();
  }

  void wheretogo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(Duration(seconds: 5), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Home_page()));
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Login_screen()));
        }
      } else {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login_screen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Splash')));
  }
}
