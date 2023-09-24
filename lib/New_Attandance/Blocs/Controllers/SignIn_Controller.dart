import 'dart:developer';
import 'package:attendance_app/New_Attandance/Blocs/SignIN_bloc/sign_in_bloc.dart';
import 'package:attendance_app/New_Attandance/Screens/Home_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../old_attandance/Models/User_model.dart';
import '../../UiHelper/Ui.Helper.dart';

class SignUpController {
  final BuildContext context;
  SignUpController({required this.context});
  signUp() async {
    final state = context.read<SignInBloc>().state;
    String email = state.email;
    String password = state.password;
    String phonenumber = state.phone;
    if (email == "" && password == "" && phonenumber == "") {
      UiHelper.CustomSnackBar("Enter Required Fields", context);
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
      } on FirebaseAuthException catch (ex) {
        UiHelper.CustomSnackBar(ex.code.toString(), context);
      }
      if (usercredential != null) {
        String uid = await usercredential.user!.uid;
        UserModel newuser = UserModel(
          id: uid,
          email: email,
          password: password,
          username: usercredential.user!.email.toString(),
          phone: phonenumber,
        );
        FirebaseFirestore.instance
            .collection("New Users")
            .doc(email)
            .set(newuser.toMap())
            .then((value) {
          log("User Created!!");
          UiHelper.CustomSnackBar("Welcome $email", context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home_Screen()));
        });
      }
    }
  }
}
