import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/AppRoutes.dart';
import 'Home/choose_type.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static Locale locale = const Locale('en');

  @override
  void initState() {
    setLang();
    Future.delayed(const Duration(seconds: 2)).then((v) {
      AppRoutes.pushReplacementTo(context, const ChooseType());
    });
    super.initState();
  }

  setLang() async {
    await setLocalization(code: 'ar');
    await getLocalization();
  }

  static Future<String?> getLocalization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    locale = Locale(prefs.getString('locale') ?? 'en');
    return prefs.getString('locale');
  }

  static setLocalization({required String code}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('locale', code);
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
