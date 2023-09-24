import 'package:attendance_app/New_Attandance/Blocs/Controllers/Login_Controller.dart';
import 'package:attendance_app/New_Attandance/Blocs/Login_bloc/LogIn_Bloc.dart';
import 'package:attendance_app/New_Attandance/Screens/Signin_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Blocs/Login_bloc/LogIn_Events.dart';
import '../UiHelper/Ui.Helper.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 270.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                          radius: 50.sp,
                          child:
                              Icon(Icons.person, size: 50.sp, color: Colors.green)),
                      SizedBox(height: 40.h),
                      Text('LogIn',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ))),
              SizedBox(height: 20.h),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'Email Here',
                  func: (value) {
                    context.read<LogIn_bloc>().add(EmailEvent(value));
                  }),
              SizedBox(height: 15.h),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'Password Here',
                  func: (value) {
                    context.read<LogIn_bloc>().add(PasswordEvent(value));
                  }),
              SizedBox(height: 25.h),
              UiHelper.CustomButton(() {
                LoginController(context: context).login();
              }, 'LogIN'),
              SizedBox(height: 5.h),
              UiHelper.CustomButton(() {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Signin_Screen()));
              }, 'Sign In')
            ],
          ),
        ),
      ),
    );
  }
}
