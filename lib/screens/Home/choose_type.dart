import 'package:custom_story/BackEnd/provider_instance.dart';
import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/Widget/AppTextFields.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/components/GeneralWidget.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/screens/Home/story_type/cutom_story_type.dart';
import 'package:custom_story/screens/quotes/random_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../Story/read_story.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  TextEditingController about = TextEditingController();
  ProviderContainer? provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: 'قصة مخصصة',
          actions: [],
          textColor: Colors.white,
          centerTitle: true,
          showActions: false,
          backgroundColor: AppColor.brown),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal:15.w),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  Assets.backgroundMain,
                ).image),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: LottieBuilder.asset(
                 //   height: 200.spMin,
                    width: 350.h,
                    'assets/lottie/HN2PHOXYZO.json'),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: Stack(
                    children: [
                      Container(
                        height: 370.h,
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.r),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            AppText(
                              text:
                                  'لنغرس القيم الاخلاقية والاداب من خلال القصص الممتعة',
                              fontSize: AppSize.titleSize,
                              overflow: TextOverflow.visible,
                              align: TextAlign.center,
                            ),
                            SizedBox(
                              height: 45.h,
                            ),
                            AppButtons(
                              onPressed: () {},
                              text: 'مراحل',
                              width: double.infinity,
                              backgroundColor: AppColor.pink,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppButtons(
                              onPressed: () {
                                AppRoutes.pushTo(context, const CustomStory());
                              },
                              text: 'قصة مخصصة',
                              width: double.infinity,
                              backgroundColor: AppColor.blue,
                            ),
                            SizedBox(
                              height: 15.h,
                            ),
                            AppButtons(
                              onPressed: () {
                                AppRoutes.pushTo(context, const RandomQuote());
                              },
                              text: 'العبارة التشجيعية لليوم',
                              width: double.infinity,
                              backgroundColor: AppColor.green,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
