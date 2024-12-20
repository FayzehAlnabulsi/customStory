import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../generated/assets.dart';
import '../components/AppColor.dart';

class AppDialog {
  static showLoading({required context}) {
    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            titlePadding: EdgeInsets.zero,
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              alignment: AlignmentDirectional.center,
             // child: const Center(child: CircularProgressIndicator(),)
              //Lottie.asset(Assets.loading),
            ),
          );
        });
  }

  static infoDialogue({context, required Widget child}) {
    return showDialog(
        barrierDismissible: false,
        barrierColor: AppColor.black.withOpacity(0.3),
        context: context,
        builder: (_) {
          return child;
        });
  }
}
