// ignore_for_file: prefer_const_constructors, unused_import
import 'package:attendance_app/Bottom_nav_screen/route.dart';
import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:attendance_app/Screens/Sign_Screen.dart';
import 'package:attendance_app/Screens/SlashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'Flutter_flow/first.dart';
import 'bloc/bottom_nav_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavBloc(),
      child: ScreenUtilInit(
        builder: (context, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          initialRoute: '/',
          onGenerateRoute: RouteGen().generateRoute,
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if(snapshot.hasError){
                return Text(snapshot.error.toString());
              }
              if (snapshot.connectionState==ConnectionState.active){
                if(snapshot.data==null){
                  return Login_screen();
                }
                else {
                  return Home_page();
                }
              }
              return CircularProgressIndicator();
            },
          )
        ),
      ),
    );
  }
}
