import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/screens/Home/story_type/cutom_story_type.dart';
import 'package:custom_story/screens/Story/llevels_main.dart';
import 'package:custom_story/screens/quotes/random_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          text: AppLocalizations.of(context)!.customStory,
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  AppIcons.globe,
                  color: Colors.white,
                  size: AppSize.appBarIconsSize,
                ))
          ],
          textColor: Colors.white,
          centerTitle: true,
          showActions: false,
          backgroundColor: AppColor.brown),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                              text: AppLocalizations.of(context)!.mainTitle,
                              fontSize: AppSize.titleSize,
                              overflow: TextOverflow.visible,
                              color: AppColor.darkGray.withOpacity(.8),
                              align: TextAlign.center,
                            ),
                            SizedBox(
                              height: 35.h,
                            ),
                            AppButtons(
                              onPressed: () {
                                AppRoutes.pushTo(context, const LevelsMain());
                              },
                              text: AppLocalizations.of(context)!.levels,
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
                              text: AppLocalizations.of(context)!.customStory,
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
                              text: AppLocalizations.of(context)!
                                  .encouragementMessage,
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
