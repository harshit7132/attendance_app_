import 'package:attendance_app/New_Attandance/Blocs/Login_bloc/LogIn_Bloc.dart';
import 'package:attendance_app/New_Attandance/Screens/Home_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../UiHelper/Ui.Helper.dart';


class LoginController{
  final BuildContext context;
  LoginController({required this.context});
  login()async{
    final state=context.read<LogIn_bloc>().state;
    String email=state.email;
    String password=state.password;
    if(email==""|| password==""){
      UiHelper.CustomSnackBar("Enter Required Fields", context);
    }
    else{
      UserCredential? usercredential;
      try{
        usercredential=await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value){
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => Home_Screen()));
        });
      }
      on FirebaseAuthException catch(ex){
        UiHelper.CustomSnackBar(ex.code.toString(), context);
      }
    }
  }

}