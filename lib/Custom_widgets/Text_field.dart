// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String? hinttext;
  final IconData? icon;
  final TextStyle? textstyle;
  bool obscureText;
  final TextEditingController? controller;

  TextFields(
      {super.key,
      required this.obscureText,
      required this.hinttext,
      this.icon,
      this.textstyle,
      this.controller});

  @override
  Widget build(BuildContext context) {
    final mqH = MediaQuery.sizeOf(context).height;
    final mqW = MediaQuery.sizeOf(context).width;

    return Container(
      height: mqH * 0.08,
      width: mqW * 0.9,
      alignment: Alignment.center,
      child: TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        obscureText: obscureText,
        style: textstyle,
        decoration: InputDecoration(
            // border: OutlineInputBorder(
            //   borderSide: BorderSide(width: 2, color: Colors.black),
            //   borderRadius: BorderRadius.circular(50.0),
            // ),
            // enabledBorder: OutlineInputBorder(
            //   borderSide: BorderSide(width: 2, color: Colors.black),
            //   borderRadius: BorderRadius.circular(50.0),
            // ),
            hintText: hinttext,
            hintStyle: textstyle,
            prefixIcon: Icon(icon)),
      ),
    );
  }
}
