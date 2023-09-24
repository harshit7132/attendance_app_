// ignore_for_file: prefer_const_constructors, unused_local_variable, file_names, use_build_context_synchronously, unrelated_type_equality_checks

import 'dart:developer';
import 'dart:io';
import 'package:attendance_app/New_Attandance/UiHelper/Ui.Helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../Screens/LOgin_screen.dart';

final user = FirebaseAuth.instance.currentUser;

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? pickedImage;

  _uploadImage() async {
    UploadTask uploadTask =
        FirebaseStorage.instance.ref("Profile Pictures").putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imgurl = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.email.toString())
        .collection("User Image")
        .doc(user!.email.toString())
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
                  ));
            });
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
                  Text(user!.email.toString(),
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  UiHelper.CustomButton(() {}, 'Account'),
                  UiHelper.CustomButton(() {
                    //subscription page
                  }, 'Subscriptions'),
                  UiHelper.CustomButton(() {}, 'Help'),
                  UiHelper.CustomButton(() async {
                    if (user == GoogleSignInAccount) {
                      await GoogleSignIn().signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_Screen()));
                    } else {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Login_Screen()));
                    }
                  }, 'LogOut'),
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
