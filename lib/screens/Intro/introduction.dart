import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<StatefulWidget> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: AppColor.pink),
          child: Stack(
            children: [
              Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                height: 340.h,
                decoration: BoxDecoration(
                    color: AppColor.white.withOpacity(0.3),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(1000.r))),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  AnimatedTextKit(
                      animatedTexts: [
                        ScaleAnimatedText(
                          'Enhance kids Morals and behaviors by fun stories!',
                          textStyle: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),scalingFactor: 1
                         // speed: const Duration(milliseconds: 2000),
                        ),
                      ],
isRepeatingAnimation: false,

                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 20.w),
                  //   child: AppText(
                  //     text: 'Enhance kids Morals and behaviors by fun stories',
                  //     fontSize: AppSize.titleSize,
                  //     overflow: TextOverflow.visible,
                  //     align: TextAlign.center,
                  //     color: AppColor.darkGray.withOpacity(0.7),
                  //   ),
                  // ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: LottieBuilder.asset(
                        //   height: 200.spMin,
                        width: 350.h,
                        'assets/lottie/intro1.json'),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
