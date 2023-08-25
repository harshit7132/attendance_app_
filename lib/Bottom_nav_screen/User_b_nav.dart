// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:developer';
import 'dart:io';
import 'package:attendance_app/Custom_widgets/Text_field.dart';
import 'package:attendance_app/Screens/Sign_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import '../Custom_widgets/elevated.dart';
import '../Screens/LOgin_screen.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  File? pickedImage;

  _uploadImage() async {
    final user = FirebaseAuth.instance.currentUser;
    UploadTask uploadTask =
        FirebaseStorage.instance.ref("Profile Pictures").putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String imgurl = await taskSnapshot.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("Users")
        .doc(user!.email)
        .set({"Image": imgurl}).then((value) {
      log("Data Uploaded");
    });
  }

  _customModelBottomSheet() {
    return showModalBottomSheet(
      context: context,
      builder: (context) {
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
                  Navigator.pop(context);
                },
                leading: Icon(Icons.camera_alt),
                title: Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  imgPicker(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: Icon(Icons.image),
                title: Text("Gallery"),
              ),
              TextFields(
                hinttext: 'Name Here',
                obscureText: false,
                //controller: SearchController,
              ),
              TextFields(
                hinttext: user!.email.toString(),
                // controller: SearchController,
                obscureText: false,
              ),
              ElevatedButton(
                  onPressed: () {
                    _uploadImage();
                  },
                  child: Text('Upload'))
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Profile"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    _customModelBottomSheet();
                  },
                  child: pickedImage != null
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage: FileImage(pickedImage!),
                        )
                      : CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              "https://cdn.leonardo.ai/users/30e9683b-4b17-4bc9-bfd0-1b9164822f75/generations/e05c0adb-c431-4ee6-a076-55cc9e7cb404/variations/Default_create_a_logo_of_a_tiger_face_roaring_black_and_grey_a_0_e05c0adb-c431-4ee6-a076-55cc9e7cb404_1.jpg"),
                        ),
                ),
                SizedBox(height: mqh * 0.04),
                Text(user!.email.toString(),
                    style: TextStyle(
                        fontSize: mqh * 0.03, fontWeight: FontWeight.bold)),
                SizedBox(
                  height: mqh * 0.05,
                ),
                Button(
                  btnName: "Account",
                  textstyle: TextStyle(fontSize: mqh * 0.02),
                  icon: FontAwesomeIcons.accusoft,
                ),
                SizedBox(
                  height: mqh * 0.05,
                ),
                Button(
                  btnName: "Notify",
                  icon: FontAwesomeIcons.bell,
                  textstyle: TextStyle(fontSize: mqh * 0.02),
                ),
                SizedBox(
                  height: mqh * 0.05,
                ),
                Button(
                  btnName: "Help",
                  icon: FontAwesomeIcons.helicopter,
                  textstyle: TextStyle(fontSize: mqh * 0.02),
                ),
                SizedBox(height: mqh * 0.05),
                Button(
                  btnName: "LogOut",
                  callBack: () async {
                    await GoogleSignIn().signOut();
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login_screen()));
                  },
                  icon: FontAwesomeIcons.arrowRight,
                  textstyle: TextStyle(fontSize: mqh * 0.02),
                ),
              ]),
        ),
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
