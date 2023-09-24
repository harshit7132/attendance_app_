// ignore_for_file: non_constant_identifier_names, camel_case_types, use_build_context_synchronously, unused_local_variable, avoid_print, prefer_const_constructors
import 'package:attendance_app/Home_page/Home_page.dart';
import 'package:attendance_app/Models/User_model.dart';
import 'package:attendance_app/Screens/LOgin_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Custom_widgets/Text_field.dart';

final user = FirebaseAuth.instance.currentUser!.email.toString();

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

    void SignUp()  {
      String Email = emailController.text.trim();
      String Pass = passController.text.trim();
      String Cpass = CpassController.text.trim();
      String Name = nameController.text.trim();
setState(() async{

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
            MaterialPageRoute(builder: (context) => Home_page()));
      });
    }
  }
});
    }

    return Scaffold( backgroundColor: Colors.grey.shade200,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            //gradient
            Container(
              height: 340.h,
              decoration:  BoxDecoration(
                  gradient: LinearGradient(
                      end: Alignment.topCenter,
                      begin: Alignment.bottomCenter,
                      colors: [Colors.blue.shade600,Colors.blue.shade600,Colors.lightBlue,Colors.lightBlue,]
                  )
              ),
              width: double.infinity,
            ),

            //text field container
            Padding(
              padding:  EdgeInsets.only(left: 20.w),
              child: Column(
                children: [
                  SizedBox(
                    height: 200.h,
                  ),
                  Container(
                    height: 370.h,
                    width: 320.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          bottomLeft:  Radius.circular(20),
                          bottomRight:  Radius.circular(20),
                          topRight:  Radius.circular(20)
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('SIGN UP',style:GoogleFonts.acme(
                              color: Colors.black,
                              fontSize: 22.sp),),
                          TextFields(
                            controller: nameController,
                            hinttext: 'USER NAME',
                            obscureText: false,
                            textstyle:
                            GoogleFonts.acme(
                                color: Colors.black45,
                                fontSize: 18.sp),
                          ),
                          TextFields(
                            controller: emailController,
                            hinttext: 'E-mail',
                            obscureText: false,
                            textstyle:
                            GoogleFonts.acme(
                                color: Colors.black45,
                                fontSize: 18.sp),
                          ),
                          TextFields(
                              obscureText: true,
                              controller: passController,
                              hinttext: 'Password',
                              textstyle:GoogleFonts.acme(
                                  color: Colors.black45,
                                  fontSize:18.sp)),
                          TextFields(
                            controller: CpassController,
                            hinttext: 'Confirm Password',
                            obscureText: false,
                            textstyle:
                            GoogleFonts.acme(
                                color: Colors.black45,
                                fontSize: 18.sp),
                          ),
                          SizedBox(height: 10.h)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),

            //Circle avatar
            Positioned(
                top: mqh * 0.11,
                left: mqw * 0.37,
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 45.h,
                  child: Icon(
                    Icons.person,
                    size: 55.sp,
                    color: Colors.blue.shade800,
                  ),
                )),

            //already
            Padding(
                padding: EdgeInsets.only(top: 605.h,left: 58.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login_screen()));
                    }, child: Text('ALREADY HAVE AN ACCOUNT?',style: GoogleFonts.acme(fontSize: 16.sp,color: Colors.green))),
                    TextButton(onPressed: (){
                      signInwithGoogle(context: context);
                    }, child: Text('SIGN IN WITH GOOGLE!',style: GoogleFonts.acme(fontSize: 16.sp,color: Colors.green))),
                  ],
                )),

            //pop
            Positioned(top: 50.h,left: 10.w,
                child: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
               icon: Icon(Icons.arrow_back_ios,color: Colors.white),
            )),

            //elevated button
            Padding(
              padding: EdgeInsets.only(top: 550.h,left: 65.w),
              child: Container(
                height: 50.h,
                width: 200.h,
                child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: (){
                      SignUp();
                    },
                    child: Text('SIGNUP',style: GoogleFonts.acme(
                        fontSize: 20.sp,color: Colors.
                    white
                    ),)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  createUser({String? username, String? email, String? password, String? uid}) {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .set({'E-mail': email, 'Password': password,'UserName':username});

    UserModel newUser = UserModel(
        id: uid, email: email, password: password, username: username);
  }
}

//google signin
Future<UserCredential?>signInwithGoogle( {required BuildContext context}) async
{
    GoogleSignInAccount? googleuser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleuser?.authentication;
  AuthCredential credential =  GoogleAuthProvider.credential(accessToken: googleAuth?.accessToken,idToken: googleAuth?.idToken);
   UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

   if(userCredential.user != null){
     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Home_page()));
   }
   return null;
}
