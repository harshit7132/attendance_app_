import 'package:flutter/material.dart';

class TextFields extends StatelessWidget {
  final String? hinttext;
  final Icon? icon;
  final TextStyle? textstyle;
  final TextEditingController? controller;

  TextFields({super.key, required this.hinttext, this.icon, this.textstyle,required this.controller});

  @override
  Widget build(BuildContext context) {
    final mqH = MediaQuery.sizeOf(context).height;
    final mqW = MediaQuery.sizeOf(context).width;

    return Container(
      height: mqH * 0.06,
      width: mqW * 0.9,
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: textstyle,
        decoration: InputDecoration(
            hintText: hinttext, hintStyle: textstyle, prefixIcon: icon),
      ),
    );
  }
}
