import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnName;
  final Icon? icon;
  final Color? bgColor;
  final TextStyle? textstyle;
  final VoidCallback? callBack;
  final Alignment? alignment;

  Button(
      { required this.btnName,
        this.icon,
        this.bgColor,
        this.textstyle,
        this.callBack,
        this.alignment});

  @override
  Widget build(BuildContext context) {
    final mqH = MediaQuery.sizeOf(context).height;
    final mqW = MediaQuery.sizeOf(context).width;

    return SizedBox(
      height: mqH * 0.05,
      width: mqW * 0.28,
      child: ElevatedButton(
        onPressed: () {
          callBack!();
        },
        child: Text(
          btnName,
          style: textstyle,
        ),
      ),
    );
  }
}
