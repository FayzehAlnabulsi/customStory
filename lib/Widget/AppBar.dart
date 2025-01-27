import 'package:custom_story/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../components/AppColor.dart';
import '../components/AppIcons.dart';
import '../components/AppSize.dart';
import 'AppText.dart';
import 'package:custom_story/main.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String text;
  final List<Widget>? actions;
  final bool? showActions;
  final bool? centerTitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Widget? leading;
  final Color? actionColor;
  final double? leadingWidth;
  final double? fontSize;
  final double? elevation;
  final TextDirection? directionality;
  const AppBarWidget(
      {super.key,
      required this.text,
      this.actions,
      this.showActions,
      this.backgroundColor,
      this.textColor,
      this.centerTitle,
      this.leading,
      this.actionColor,
      this.leadingWidth,
      this.fontSize,
      this.elevation,
      this.directionality});

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: AppColor.noColor,
      color: AppColor.noColor,
      elevation: elevation ?? 0,
      child: Directionality(
        textDirection: directionality != null
            ? directionality!
            : MyApp.locale == const Locale('en')
                ? TextDirection.ltr
                : TextDirection.rtl,
        child: AppBar(
            automaticallyImplyLeading: false,
            iconTheme: IconThemeData(
                color: AppColor.white, size: AppSize.appBarIconsSize),
            centerTitle: centerTitle ?? false,
            surfaceTintColor: AppColor.white,
            backgroundColor: (backgroundColor ?? AppColor.noColor),
            title: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: AppText(
                text: text,
                fontSize: fontSize ?? AppSize.appBarTextSize,
                color: textColor ?? AppColor.black,
                align: TextAlign.center,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: Padding(
              padding: EdgeInsets.only(top: 5.h, left: 10.w, right: 10.w),
              child: leading,
            ),
            leadingWidth: leadingWidth,
            actions: actions ??
                [
                  showActions == false
                      ? const SizedBox.shrink()
                      : IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            AppIcons.forwardArrow,
                            color: actionColor ?? AppColor.black,
                            size: AppSize.appBarIconsSize + 5,
                          ))
                ]),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(45.h
      //kToolbarHeight
      );
}
