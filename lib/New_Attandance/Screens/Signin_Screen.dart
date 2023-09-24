import 'package:attendance_app/New_Attandance/Blocs/SignIN_bloc/sign_in_bloc.dart';
import 'package:attendance_app/New_Attandance/Blocs/SignIN_bloc/sign_in_event.dart';
import 'package:attendance_app/New_Attandance/UiHelper/Ui.Helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Blocs/Controllers/SignIn_Controller.dart';

class Signin_Screen extends StatefulWidget {
  const Signin_Screen({super.key});

  @override
  State<Signin_Screen> createState() => _Signin_ScreenState();
}

class _Signin_ScreenState extends State<Signin_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 230.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(50))),
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:  EdgeInsets.only(right: 300.w,bottom: 20.h),
                        child: IconButton(
                          icon: Icon(
                        CupertinoIcons.left_chevron,
                        color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      CircleAvatar(
                          radius: 50.sp,
                          child: Icon(Icons.person,
                              size: 50.sp, color: Colors.green)),
                      SizedBox(height: 20.h),
                      Text('Sign In',
                          style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ))),
              SizedBox(height: 10.h),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'Email ',
                  func: (value) {
                    context.read<SignInBloc>().add(EmailEvent(value));
                  }),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'UserName ',
                  func: (value) {
                    context.read<SignInBloc>().add(PasswordEvent(value));
                  }),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'Password ',
                  func: (value) {
                    context.read<SignInBloc>().add(PasswordEvent(value));
                  }),
              UiHelper.CustomTextField(
                  toHide: false,
                  text: 'Phone ',
                  func: (value) {
                    context.read<SignInBloc>().add(PhoneEvent(value));
                  }),
              UiHelper.CustomButton(() {
                SignUpController(context: context).signUp();
              }, 'Sign IN')
            ],
          ),
        ),
      ),
    );
  }
}
