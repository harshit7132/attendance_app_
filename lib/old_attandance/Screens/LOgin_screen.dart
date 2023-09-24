// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, camel_case_types

import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/Forgot_password.dart';
import 'package:attendance_app/Screens/SlashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_widgets/Text_field.dart';
import 'Sign_Screen.dart';

class Login_screen extends StatefulWidget {
  const Login_screen({super.key});
  @override
  State<Login_screen> createState() => _Login_screenState();
}

class _Login_screenState extends State<Login_screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;

    //Login using firebase
    void Login() {
      String Email = emailController.text.trim();
      String Pass = passController.text.trim();
      setState(() async {
        if (Email.isEmpty || Pass.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(' Enter Valid Details'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'),
                  ),
                ],
              );
            },
          );
        } else {
          try {
            UserCredential userCredential = await FirebaseAuth.instance
                .signInWithEmailAndPassword(email: Email, password: Pass);
            if (userCredential != null) {
              var sharedPref = await SharedPreferences.getInstance();
              sharedPref.setBool(Splash_screenState.KEYLOGIN, true);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home_page()),
              );
            }
          } on FirebaseAuthException catch (ex) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(ex.code.toString()),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            );
          }
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 340.h,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [
                    Colors.blue.shade600,
                    Colors.blue.shade600,
                    Colors.lightBlue,
                    Colors.lightBlue,
                  ])),
              width: double.infinity,
            ),

            //circle avatar
            Positioned(
                top: mqh * 0.15,
                left: mqw * 0.4,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45.h,
                  child: Icon(
                    Icons.person,
                    size: 55.sp,
                    color: Colors.blue.shade800,
                  ),
                )),

            //text field container
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 230.h,
                  ),
                  Container(
                    height: 310.h,
                    width: 320.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                          topRight: Radius.circular(20)),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('LOGIN',
                              style: GoogleFonts.acme(
                                  color: Colors.black, fontSize: 22.sp)),
                          SizedBox(height: 20.h),
                          TextFields(
                            controller: emailController,
                            hinttext: 'E-mail',
                            obscureText: false,
                            textstyle: GoogleFonts.acme(
                                color: Colors.black45, fontSize: 18.sp),
                          ),
                          TextFields(
                              obscureText: true,
                              controller: passController,
                              hinttext: 'Password',
                              textstyle: GoogleFonts.acme(
                                  color: Colors.black45, fontSize: 18.sp)),
                          SizedBox(
                            height: 50.h,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            //elevated button
            Padding(
              padding: EdgeInsets.only(top: 510.h, left: 70.w),
              child: SizedBox(
                height: 50.h,
                width: 190.h,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () {
                      Login();
                    },
                    child: Text(
                      'LOGIN',
                      style: GoogleFonts.acme(
                          fontSize: 20.sp, color: Colors.white),
                    )),
              ),
            ),

            //Forgot Password
            Padding(
                padding: EdgeInsets.only(top: 570.h, left: 70.w),
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const forgotPassword()));
                        },
                        child: Text('FORGOT PASSWORD?',
                            style: GoogleFonts.acme(
                                fontSize: 16.sp, color: Colors.red))),
                    Text('OR', style: GoogleFonts.acme(fontSize: 16.sp)),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUp_screen()));
                        },
                        child: Text('DON`T HAVE AN ACCOUNT!',
                            style: GoogleFonts.acme(
                                fontSize: 16.sp, color: Colors.blue))),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
