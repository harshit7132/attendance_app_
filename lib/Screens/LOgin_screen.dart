// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison, unused_local_variable

import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/SlashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_widgets/Text_field.dart';
import '../Custom_widgets/elevated.dart';
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
    void Login() async {
      String Email = emailController.text.trim();
      String Pass = passController.text.trim();

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
    }

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.black
            //     gradient: LinearGradient(colors: [
            //   Colors.deepOrangeAccent,
            //   Colors.deepOrangeAccent,
            //   Colors.purple
            // ], begin: Alignment.topCenter, end: Alignment.bottomCenter)
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 274.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5.w),
                  height: mqh * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(70),
                        ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(mqw * 0.04),
                    child: Column(
                      children: [
                        SizedBox(
                          height: mqh * 0.1,
                        ),
                        TextFields(
                          controller: emailController,
                          hinttext: 'E-mail',
                          obscureText: false,
                          textstyle:
                          GoogleFonts.acme(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp),
                        ),
                        SizedBox(
                          height: mqh * 0.07,
                        ),
                        TextFields(
                            obscureText: true,
                            controller: passController,
                            hinttext: 'Password',
                            textstyle:GoogleFonts.acme(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:20.sp)),
                        SizedBox(height: mqh * 0.13),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: mqw * 0.4,
                              alignment: Alignment.center,
                              child: Button(
                                  btnName: 'LogIN',
                                  bgColor: Colors.black,
                                  textstyle: GoogleFonts.acme(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.sp),
                                  callBack: () {
                                    Login();
                                  }),
                            ),
                            Container(
                              width: mqw * 0.4,
                              alignment: Alignment.center,
                              child: Button(
                                bgColor: Colors.black,
                                btnName: 'SignUp',
                                textstyle: GoogleFonts.acme(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.sp),
                                callBack: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const SignUp_screen()));
                                },
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: mqh * 0.15,
              left: mqw * 0.4,
              child: Column(
                children: [
                  Text('LOG IN',
                      style: GoogleFonts.acme(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25.sp)),
                  SizedBox(height: 20.h),
                  Icon(
                    Icons.person,
                    size: 90.sp,
                    color: Colors.white,
                  )
                ],
              ))
        ],
      ),
    );
  }
}
