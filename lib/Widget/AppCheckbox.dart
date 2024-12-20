import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/AppColor.dart';
import '../components/AppSize.dart';
import 'AppText.dart';

class AppCheckBox extends StatelessWidget {
  final String label;
  final bool value;
  final Color? activeColor;
  final Color? sideColor;
  final Color? textColor;
  final double? textSize;
  final void Function(bool?) onChanged;
  const AppCheckBox(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged,
      this.activeColor,
      this.sideColor,
      this.textColor,
      this.textSize});

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(10.w, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: activeColor ?? AppColor.pink.withOpacity(0.8),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3.r)),
          ),
          AppText(
            text: label,
            color: textColor ?? AppColor.black,
            fontSize: textSize?.spMin ?? AppSize.smallSubText,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
