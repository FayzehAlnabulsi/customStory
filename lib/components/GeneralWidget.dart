import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'AppColor.dart';

class GeneralWidget {
  //borderStyle===============================================================================================
  static outlineInBorderStyle(
      {bool? isFocus,
      Color? borderColor,
      double? borderThickness,
      double? borderRadius}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5.r),
      borderSide: BorderSide(
        color: isFocus == true
            ? AppColor.purple
            : (borderColor ?? AppColor.lightGrey),
        width: borderThickness ?? 0.3,
      ),
    );
  }
}
