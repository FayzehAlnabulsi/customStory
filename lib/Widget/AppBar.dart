import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../components/AppColor.dart';
import '../components/AppIcons.dart';
import '../components/AppSize.dart';
import 'AppText.dart';

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
  const AppBarWidget({
    super.key,
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
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      surfaceTintColor: AppColor.noColor,
      color: AppColor.noColor,
      elevation: elevation ?? 0,
      child: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(
            color: AppColor.white,
            size: 25.r,
          ),
          centerTitle: centerTitle ?? false,
          surfaceTintColor: AppColor.white,
          backgroundColor: (backgroundColor ?? AppColor.noColor),
          title: Padding(
            padding: EdgeInsets.only(top: 2.h),
            child: AppText(
              text: text,
              fontSize: fontSize ?? AppSize.appBarTextSize,
              color: textColor ?? AppColor.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: leading,
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
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(55.spMin
      //kToolbarHeight
      );
}
