// ignore_for_file: file_names, library_private_types_in_public_api, unused_local_variable, unused_element, non_constant_identifier_names, avoid_print

import 'dart:core';
import 'package:attendance_app/Screens/Sign_Screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

String datetime1 = DateTime.now().toString();
String datetime = DateTime.now().toString();

class CheckInOutScreen extends StatefulWidget {
  const CheckInOutScreen({super.key});
  @override
  _CheckInOutScreenState createState() => _CheckInOutScreenState();
}

class _CheckInOutScreenState extends State<CheckInOutScreen> {
  String checkInTime = "";
  String checkOutTime = "";

  @override
  Widget build(BuildContext context) {
    var mqh = MediaQuery.of(context).size.height;
    var mqw = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Check-In/Check-Out'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text('Checked In : $datetime1.toString()'),
                Text("Checked Out : $datetime.toString()"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      CheckedIn();
                    },
                    child: const Text('Check In')),
                ElevatedButton(
                    onPressed: () {
                      CheckedOut();
                    },
                    child: const Text('Check out')),
              ],
            )
          ],
        ));
  }

  void CheckedOut() {
    FirebaseFirestore.instance
        .collection("Check in & check out")
        .doc(user)
        .collection("Checked Out")
        .doc(FirebaseAuth.instance.currentUser!.displayName.toString())
        .set({"Checkout": datetime}).then((value) {
      print(datetime);
    });
  }

  void CheckedIn() async {
    await FirebaseFirestore.instance
        .collection("Check in & check out")
        .doc(user)
        .set({'Checked In': datetime1}).then((value) {
      print(datetime1);
    });
  }
}