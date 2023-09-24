import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Button extends StatelessWidget {
  final String btnName;
  final IconData? icon;
  final Color? bgColor;
  final TextStyle? textstyle;
  final VoidCallback? callBack;
  final Alignment? alignment;

  const Button(
      {super.key, required this.btnName,
      this.icon,
       this.bgColor,
      this.textstyle,
      this.callBack,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:50.h,
      width: 210.w,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bgColor),
        onPressed: () {
          callBack!();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Icon(icon),
            Text(
              btnName,
              style: textstyle,
            ),
          ],
        ),
      ),
    );
  }
}
