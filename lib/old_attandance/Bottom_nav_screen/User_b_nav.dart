// ignore_for_file: prefer_const_constructors, unused_local_variable, file_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';
import 'dart:io';
import 'package:attendance_app/Screens/Sign_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Custom_widgets/elevated.dart';
import '../Screens/LOgin_screen.dart';
import '../Screens/SlashScreen.dart';
import 'In_App_Purchase/in_app_purchase.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? pickedImage;

  _uploadImage() async{
      UploadTask uploadTask = FirebaseStorage.instance
          .ref("Profile Pictures")
          .putFile(pickedImage!);
      TaskSnapshot taskSnapshot = await uploadTask;
      String imgurl = await taskSnapshot.ref.getDownloadURL();

      FirebaseFirestore.instance
          .collection("Users")
          .doc(user)
          .collection("User Image")
          .doc(user)
          .set({"Image": imgurl}).then((value) {
        log("Data Uploaded");
      });
  }

  _customModelBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.height * 0.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("Pick Image From"),
                  ListTile(
                    onTap: () {
                      imgPicker(ImageSource.camera);
                    },
                    leading: Icon(Icons.camera_alt),
                    title: Text("Camera"),
                  ),
                  ListTile(
                    onTap: () {
                      imgPicker(ImageSource.gallery);
                    },
                    leading: Icon(Icons.image),
                    title: Text("Gallery"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _uploadImage();
                        Navigator.pop(context);
                      },
                      child: Text('Upload'))
                ],
              )
            );
          }
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Stack(
        children: [
          Container(
            height: 400.h,
            width: mqw,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(25))),
          ),
          Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('User Profile',
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  GestureDetector(
                    onTap: () {
                      _customModelBottomSheet();
                    },
                    child: pickedImage != null
                        ? CircleAvatar(
                            radius: 55,
                            backgroundImage: FileImage(pickedImage!),
                          )
                        : CircleAvatar(
                            radius: 55,
                            backgroundImage: NetworkImage(
                                "https://cdn.leonardo.ai/users/30e9683b-4b17-4bc9-bfd0-1b9164822f75/generations/e05c0adb-c431-4ee6-a076-55cc9e7cb404/variations/Default_create_a_logo_of_a_tiger_face_roaring_black_and_grey_a_0_e05c0adb-c431-4ee6-a076-55cc9e7cb404_1.jpg"),
                          ),
                  ),
                  Text(user.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  Button(
                    btnName: "Account",
                    bgColor: Colors.white,
                    textstyle: TextStyle(fontSize: 18.sp, color: Colors.black),
                    icon: FontAwesomeIcons.accusoft,
                  ),
                  Button(
                    btnName: "Subscriptions",
                    callBack: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SubscriptionPage()));
                    },
                    bgColor: Colors.white,
                    icon: FontAwesomeIcons.bell,
                    textstyle: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                  Button(
                    btnName: "Help",
                    bgColor: Colors.white,
                    icon: FontAwesomeIcons.helicopter,
                    textstyle: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                  Button(
                    btnName: "LogOut",
                    bgColor: Colors.white,
                    callBack: () {
                      setState(() async {
                        if (user == GoogleSignInAccount) {
                          await GoogleSignIn().signOut();
                          var sharedPref = await SharedPreferences.getInstance();
                          sharedPref.setBool(Splash_screenState.KEYLOGIN, false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login_screen()));
                        } else {
                          await FirebaseAuth.instance.signOut();
                          var sharedPref = await SharedPreferences.getInstance();
                          sharedPref.setBool(Splash_screenState.KEYLOGIN, false);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Login_screen()));
                        }
                      });
                    },
                    icon: FontAwesomeIcons.arrowRight,
                    textstyle: TextStyle(fontSize: 18.sp, color: Colors.black),
                  ),
                ]),
          ),
        ],
      ),
    );
  }

  imgPicker(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image == null) return;
      final tempImage = File(image.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      log(ex.toString());
    }
  }
}
