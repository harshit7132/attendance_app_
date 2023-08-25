// ignore_for_file: non_constant_identifier_names, camel_case_types, use_build_context_synchronously, unused_local_variable, avoid_print, prefer_const_constructors
import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Models/User_model.dart';
import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:attendance_app/authentications/phone_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Custom_widgets/Text_field.dart';
import '../Custom_widgets/elevated.dart';

final user = FirebaseAuth.instance.currentUser;

class SignUp_screen extends StatefulWidget {
  const SignUp_screen({super.key});
  @override
  State<SignUp_screen> createState() => SignUp_screenState();
}

class SignUp_screenState extends State<SignUp_screen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController CpassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;

    void SignUp() async {
      String Email = emailController.text.trim();
      String Pass = passController.text.trim();
      String Cpass = CpassController.text.trim();
      String Name = nameController.text.trim();

      if (Email == "" || Pass == "" || Cpass == "" || Name == "") {
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
        UserCredential? userCredential;
        try {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: Email, password: Pass);
        } on FirebaseAuthException catch (e) {
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
              });
        }
        if (userCredential != null) {
          String uid = userCredential.user!.uid;
          UserModel newuser = UserModel(
            email: Email,
            password: Pass,
            username: Name,
            id: uid,
          );
          FirebaseFirestore.instance
              .collection("Users")
              .doc(Email)
              .set(newuser.toMap())
              .then((value) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Login_screen()));
          });
        }
      }
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: mqh,
              decoration: BoxDecoration(
                color: Colors.black
              ),
              child: Column(
                children: [
                  SizedBox(height: 137.h),
                  Container(
                    margin: EdgeInsets.only(left: 7),
                    height: mqh*0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(70))
                    ),
                    child: Padding(
                      padding:  EdgeInsets.only(top: 50,left: 10,right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextFields(
                              obscureText: false,
                              controller: nameController,
                              hinttext: 'UserName',
                            textstyle:GoogleFonts.acme(fontSize: 23.sp,color: Colors.black)
                          ),
                             SizedBox(
                            height: mqh * 0.02,
                          ),
                          TextFields(
                            obscureText: false,
                            controller: emailController,
                            hinttext: 'E-mail',
                            textstyle: GoogleFonts.acme(fontSize: 23.sp,color: Colors.black)),
                          SizedBox(
                            height: mqh * 0.030,
                          ),
                          TextFields(
                              obscureText: true,
                              controller: passController,
                              hinttext: 'Password',
                              textstyle: GoogleFonts.acme(fontSize:  23.sp,color: Colors.black)),
                          SizedBox(
                            height: mqh * 0.030,
                          ),
                          TextFields(
                              obscureText: true,
                              controller: CpassController,
                              hinttext: 'Conform Password',
                              textstyle: GoogleFonts.acme(fontSize:  23.sp,color: Colors.black,)),
                          SizedBox(height: mqh * 0.06),
                          Button(
                            btnName: 'LOG IN',

                            bgColor: Colors.black,
                            textstyle: GoogleFonts.acme(fontSize:  22.sp,color: Colors.white),
                            callBack: () {
                              SignUp();
                            },
                          ),
                          SizedBox(height: mqh * 0.04),
                          Text('___________   Or Login With  ___________',style: GoogleFonts.acme(fontSize:  20.sp),),
                          SizedBox(height: mqh * 0.05),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Button(
                                  bgColor: Colors.black,
                                btnName: 'Google',textstyle: GoogleFonts.acme(fontSize:  22.sp,color: Colors.white),
                                callBack: (){
                                  signInwithGoogle(context: context);
                                }
                              ),
                              Button(
                                btnName: 'Phone',
                                bgColor: Colors.black,
                                textstyle:  GoogleFonts.acme(fontSize:  22.sp,color: Colors.white),
                                //  icon: Icon(FontAwesomeIcons.phone)
                                callBack: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => MyPhone()));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: mqh * 0.03),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
                top:mqh*0.09,
                left: mqw*0.4,
                child: Text('SIGN UP',style: GoogleFonts.acme(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25.sp))),
            Positioned(
                top:mqh*0.08,
                left: 0,
                child: IconButton(onPressed: (){
                  Navigator.pop(context);
                }, icon:Icon(Icons.chevron_left,size: 30.sp,color: Colors.white,)))
          ],
        ),
      ),
    );
  }

  createUser({String? username, String? email, String? password, String? uid}) {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set({'E-mail': email, 'Password': password});

    UserModel newUser = UserModel(
        id: uid, email: email, password: password, username: username);
  }
}

Future<UserCredential?>signInwithGoogle( {required BuildContext context}) async{

    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;
  AuthCredential credential =  GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

   if(userCredential.user != null){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_page()));
   }
}
