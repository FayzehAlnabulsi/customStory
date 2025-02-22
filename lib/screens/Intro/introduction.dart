import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/screens/Home/choose_type.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Widget/AppText.dart';
import '../../components/AppSize.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<StatefulWidget> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  PageController pc = PageController();
  Map<int, dynamic> intro = {};

  @override
  void initState() {
    intro.putIfAbsent(
        0,
        () => {
              "title": "Enhance kids Morals and behaviors by fun stories",
              "animation": 'assets/lottie/intro1.json',
              "color": AppColor.pink
            });
    intro.putIfAbsent(
        1,
        () => {
              "title": "Your kid is the hero of the story",
              "animation": 'assets/lottie/intro2.json',
              "color": AppColor.blue
            });
    intro.putIfAbsent(
        2,
        () => {
              "title": "Encourage kids today to become idols tomorrow",
              "animation": 'assets/lottie/intro3.json',
              "color": AppColor.green
            });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Directionality(
      textDirection: TextDirection.rtl,
      child: PageView.builder(
          itemCount: intro.length,
          controller: pc,
          itemBuilder: (_, i) => Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(color: intro[i]['color']),
              child: Stack(
                children: [
                  Container(
                    alignment: Alignment.topRight,
                    width: double.infinity,
                    height: 300.h,
                    decoration: BoxDecoration(
                        color: AppColor.white.withOpacity(0.3),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(1000.r))),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: InkWell(
                            onTap: () async {
                              AppRoutes.pushReplacementTo(
                                  context, const ChooseType());
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setString('intro', 'done');
                            },
                            child: Padding(
                              padding: EdgeInsets.only(top: 50.h, left: 20.w),
                              child: AppText(
                                text: i == 2 ? 'Start' : '',
                                fontSize: AppSize.subTitle,
                                fontWeight: FontWeight.bold,
                                color: AppColor.darkGray.withOpacity(.6),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: 15.w, right: 15.w, top: 0.spMin),
                          child: AppText(
                            text: intro[i]['title'],
                            fontSize: AppSize.titleSize + 7,
                            overflow: TextOverflow.visible,
                            align: TextAlign.center,
                            color: AppColor.darkGray.withOpacity(0.8),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: LottieBuilder.asset(
                              //   height: 200.spMin,
                              width: double.infinity,
                              intro[i]['animation']),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.h),
                    height: 50.h,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: DotsIndicator(
                        dotsCount: 3,
                        position: i.toDouble(),
                        decorator: DotsDecorator(
                            color: AppColor.brown.withOpacity(.3),
                            activeColor: AppColor.darkGray),
                      ),
                    ),
                  ),
                ],
              ))),
    ));
  }
}
