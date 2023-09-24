import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UiHelper {
  static CustomTextField({
    String? text,
    IconData? iconData,
    required bool toHide,
    void Function(String value)? func,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Card(
        elevation: 6,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.sp)),
        child: Container(
          height: 40.h,
          width: 300.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: Colors.white10),
          child: TextField(
            onChanged: (value) => func!(value),
            obscureText: toHide,
            decoration: InputDecoration(
                prefixIcon: Icon(
                  iconData,
                  color: Colors.red,
                ),
                hintText: text,
                border: InputBorder.none),
          ),
        ),
      ),
    );
  }

  static CustomContainer(String text, Alignment alignment, double size) {
    return Container(
      padding: EdgeInsets.only(left: size),
      alignment: alignment,
      child: Text(
        text,
        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
      ),
    );
  }

  static CustomButton(VoidCallback callback, String name) {
    return GestureDetector(
      onTap: () {
        callback();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Container(
          height: 40.h,
          width: 310.w,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.green),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),
        ),
      ),
    );
  }

  static CustomSnackBar(String text, BuildContext context) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        text,
        style: TextStyle(fontSize: 12.sp, color: Colors.white),
      ),
      backgroundColor: Colors.red,
    ));
  }

  static CustomSizedBox(double height, double width, Widget widget) {
    return SizedBox(
      height: height,
      width: width,
      child: widget,
    );
  }
}
