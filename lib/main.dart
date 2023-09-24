// ignore_for_file: prefer_const_constructors, unused_import, unnecessary_null_comparison

import 'package:attendance_app/New_Attandance/Blocs/Bottom_Nav_bloc/Bottom_Nav_bloc.dart';
import 'package:attendance_app/New_Attandance/Blocs/Login_bloc/LogIn_Bloc.dart';
import 'package:attendance_app/New_Attandance/Screens/LOgin_screen.dart';
import 'package:attendance_app/New_Attandance/Screens/Signin_Screen.dart';
import 'package:attendance_app/old_attandance/example.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'New_Attandance/Blocs/SignIN_bloc/sign_in_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LogIn_bloc(),
        ),
        BlocProvider(
          create: (context) => SignInBloc(),
        ),
        BlocProvider(
          create: (context) => BottomNavBloc(),
        ),
      ],
      child: ScreenUtilInit(
        builder: (context, child) =>
            MaterialApp
              (
                debugShowCheckedModeBanner: false,
                title: 'Flutter Demo',
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                      seedColor: Colors.deepPurple),
                  useMaterial3: true,
                ),
              home: Login_Screen(),
            ),
      ),
    );
  }
}
