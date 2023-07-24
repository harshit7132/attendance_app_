// ignore_for_file: camel_case_types, non_constant_identifier_names, use_build_context_synchronously, unnecessary_null_comparison

import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Screens/SlashScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(title: const Text("Log In"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFields(
                controller: emailController,
                hinttext: 'E-mail',
                textstyle: const TextStyle(color: Colors.blue),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFields(
                  controller: passController,
                  hinttext: 'Password',
                  textstyle: const TextStyle(color: Colors.blue)),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Button(
                      btnName: 'LogIN',
                      callBack: () {
                        Login();
                      }),
                  Button(
                    btnName: 'SignUp',
                    callBack: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp_screen()));
                    },
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
