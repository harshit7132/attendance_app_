// ignore_for_file: non_constant_identifier_names, camel_case_types, use_build_context_synchronously, unused_local_variable

import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Custom_widgets/Text_field.dart';
import '../Custom_widgets/elevated.dart';

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});
  @override
  State<SignUp_screen> createState() => SignUp_screenState();
}

class SignUp_screenState extends State<SignUp_screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController CpassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;

    void SignUp() async {
      String Email = emailController.text.trim();
      String Pass = passController.text.trim();
      String Cpass = CpassController.text.trim();

      if (Email == "" || Pass == "" || Cpass == "") {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Enter valid Detailes'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('ok'))
                  ]);
            });
      } else if (Pass != Cpass) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: const Text('Password and Cpassword not match'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('ok'))
                  ]);
            });
      } else {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: Email, password: Pass);
          if (userCredential.user != null) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login_screen()));
          }
        } on FirebaseAuthException catch (e) {
          throw {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(title: Text(e.code.toString()), actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('ok'))
                  ]);
                })
          };
        }
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up"), centerTitle: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
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
                const SizedBox(
                  height: 30,
                ),
                TextFields(
                    controller: CpassController,
                    hinttext: 'Conform Password',
                    textstyle: const TextStyle(color: Colors.blue)),
                const SizedBox(height: 70),
                Button(
                  btnName: 'LogIN',
                  callBack: () {
                    SignUp();
                  },
                ),
                const SizedBox(height: 70),
                const Text(
                    '__________________   Or Login With  _____________________'),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      btnName: 'Google',
                      //  icon: Icon(FontAwesomeIcons.google)
                    ),
                    Button(
                      btnName: 'Phone',
                      //  icon: Icon(FontAwesomeIcons.phone)
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Button(
                      btnName: 'FaceBook',
                      //  icon: Icon(FontAwesomeIcons.google)
                    ),
                    Button(
                      btnName: 'Apple',
                      //  icon: Icon(FontAwesomeIcons.phone)
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
