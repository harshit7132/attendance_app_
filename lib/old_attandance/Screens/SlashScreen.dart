// ignore_for_file: camel_case_types

import 'dart:async';
import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash_screen extends StatefulWidget {
  const Splash_screen({super.key});
  @override
  State<Splash_screen> createState() => Splash_screenState();
}

class Splash_screenState extends State<Splash_screen> {
  static var KEYLOGIN = "login";

  @override
  void initState() {
    super.initState();
    setState(() {
      wheretogo();
    });
  }

  void wheretogo() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(KEYLOGIN);

    Timer(const Duration(seconds: 8), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  Login_screen()));
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) =>  Home_page()));
        }
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) =>  Login_screen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                      Colors.cyan,
                      Colors.cyan,
                      Colors.cyan,
                      Colors.white
                    ])),
                child: Text('Attendance App',
                    style: GoogleFonts.acme(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple.shade700
                        //gradient text under
                        // foreground: Paint()
                        //   ..shader = LinearGradient(colors: [
                        //     Colors.deepPurpleAccent,
                        //     Colors.deepPurpleAccent,
                        //     Colors.deepPurpleAccent,
                        //     Colors.deepPurpleAccent,
                        //     Colors.deepPurpleAccent,
                        //     Colors.red
                        //   ]).createShader(
                        //       Rect.fromLTWH(0.0, 0.0, 200.0, 100.0))
                    ))),
            Positioned(top:  380.h,left: 80.w,
                child: Lottie.network('https://lottie.host/77977cf9-9d97-4b61-909b-d2ae54293005/446vxajW1B.json',height: 200.h,width: 200.w))
          ],
        ));
  }
}
