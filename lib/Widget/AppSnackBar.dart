import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../components/AppColor.dart';
import '../components/AppIcons.dart';
import '../components/AppSize.dart';
import 'AppText.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
  }

  static showInSnackBar(
      {required context,
      required String message,
      required bool isSuccessful,
      Duration? duration,
      double? bottomPadding}) {
    var snackBar = SnackBar(
      content: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 10.w, top: 5.h),
              child: Image.asset(
                height: 45.h,
                width: 50.w,
                'assets/images/snackBarImage.png',
                color: isSuccessful
                    ? AppColor.green.withOpacity(0.3)
                    : AppColor.pink.withOpacity(0.3),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 15.w, bottom: 15.w, right: 8.w),
            decoration: BoxDecoration(
                color: isSuccessful
                    ? AppColor.green.withOpacity(0.08)
                    : AppColor.pink.withOpacity(0.08),
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  width: 1,
                  color: isSuccessful
                      ? AppColor.green
                      : AppColor.pink,
                )),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: isSuccessful
                      ? AppColor.green
                      : AppColor.pink,
                  radius: 13.r,
                  child: Icon(
                    isSuccessful ? AppIcons.success : AppIcons.fail,
                    size: AppSize.iconsSize - 2,
                    color: AppColor.white,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SizedBox(
                  width: 260.w,
                  child: AppText(
                    text: message,
                    fontSize: AppSize.snackBarTextSize,
                    color:
                        isSuccessful ? AppColor.green : AppColor.pink,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: bottomPadding ?? 20.h, right: 20.w, left: 20.w),
      padding: EdgeInsets.zero,
      backgroundColor: AppColor.white,
      elevation: 20,
      duration: duration ?? const Duration(seconds: 2),
    );
    // Step 3

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
