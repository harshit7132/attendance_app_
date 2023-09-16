// ignore_for_file: prefer_const_constructors_in_immutables, must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
    return SizedBox(
      height: 70.h,
      width: 500.w,
      child: TextField(
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        controller: controller,
        obscureText: obscureText,
        style: textstyle,
        decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(width: 0),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(35.w),right: Radius.circular(35.w))
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(width: 0),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(35.w),right: Radius.circular(35.w))
          ),
            label: Text('$hinttext'),
            labelStyle: textstyle,
            prefixIcon: Icon(icon)),
      ),
    );
  }
}
