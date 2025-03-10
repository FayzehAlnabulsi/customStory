import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/provider_class.dart';
import '../../Widget/AppText.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LearntMorals extends StatefulWidget {
  const LearntMorals({super.key});

  @override
  State<StatefulWidget> createState() => _LearntMoralsState();
}

//
class _LearntMoralsState extends State<LearntMorals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: AppLocalizations.of(context)!.benefits,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(AppIcons.backArrow)),
          textColor: Colors.white,
          centerTitle: true,
          showActions: false,
          backgroundColor: AppColor.brown),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: AppColor.yellow.withOpacity(.2),
        ),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 30.h, left: 20.w),
                  child: LottieBuilder.asset(
                    Assets.benefitsAnimation,
                    height: 250.h,
                  ),
                )),
            ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 20.h),
              itemCount: Provider.of<StoryProviderClass>(context, listen: false)
                          .story
                          .data!
                          .moral!
                          .length >
                      4
                  ? 4
                  : Provider.of<StoryProviderClass>(context, listen: false)
                      .story
                      .data!
                      .moral!
                      .length,
              itemBuilder: (context, i) => Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(Assets.learntPoints,
                        height: 25.h, width: 30.w),
                    SizedBox(
                      width: 8.w,
                    ),
                    Flexible(
                      child: AppText(
                          text: Provider.of<StoryProviderClass>(context,
                                  listen: false)
                              .story
                              .data!
                              .moral![i],
                          align: TextAlign.start,
                          overflow: TextOverflow.visible,
                          fontSize: AppSize.titleSize),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
