import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/screens/Home/choose_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppRoutes.dart';
import 'Intro/introduction.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2)).then((v) {
      checkIntroduction().then((intro) {
        if (intro == true) {
          AppRoutes.pushReplacementTo(context, const Introduction());
        } else {
          AppRoutes.pushReplacementTo(context, const ChooseType());
        }
      });
    });
    super.initState();
  }

  Future checkIntroduction() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('intro') == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        color: AppColor.white,
        child: Image.asset(
          Assets.logo,
          height: 200.h,
          width: 200.w,
        ),
      ),
    );
  }
}
