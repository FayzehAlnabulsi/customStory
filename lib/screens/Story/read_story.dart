import 'package:custom_story/BackEnd/provider_instance.dart';
import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../Widget/AppText.dart';
import 'llevels_main.dart';

class ReadStory extends StatefulWidget {
  const ReadStory({super.key});

  @override
  State<StatefulWidget> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  ScrollController scrollController = ScrollController();

  int fromIndex = 0;
  int intTo = 85;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cc != null ? Navigator.pop(cc!) : null;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(
            vertical: 55.h,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: Image.asset(
                  Assets.storyBackground,
                ).image),
          ),
          child: ProviderScope.containerOf(context)
                      .read(storyProvider)
                      .story
                      .data ==
                  null
              ? const SizedBox()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: MyApp.locale == const Locale('ar') ? 35.w : 0,
                        left: 35.w,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: Icon(
                              AppIcons.backArrow,
                              size: AppSize.appBarIconsSize + 3,
                              color: AppColor.darkGray.withOpacity(.7),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              AppIcons.favorite,
                              size: AppSize.appBarIconsSize + 5,
                              color: AppColor.favorite,
                            ),
                            onPressed: () {
                             // Navigator.pop(context);
                            },
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MyApp.locale == const Locale('ar') ? 5.w : 0,
                            left: MyApp.locale == const Locale('ar') ? 0 : 5.w),
                        child: RawScrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            thumbColor: AppColor.pink,
                            radius: Radius.circular(10.r),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: MyApp.locale == const Locale('ar')
                                        ? 13.w
                                        : 0,
                                    right: MyApp.locale == const Locale('ar')
                                        ? 0
                                        : 13.w),
                                child: SizedBox(
                                  width: 260.w,
                                  child: Column(
                                    children: [
                                      AppText(
                                        text: ProviderScope.containerOf(context)
                                                .read(storyProvider)
                                                .story
                                                .data!
                                                .title ??
                                            '',
                                        fontSize: AppSize.titleSize + 1,
                                        align: TextAlign.center,
                                        textHeight: 2.5,
                                        color:
                                            AppColor.darkGray.withOpacity(0.9),
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.visible,
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      AppText(
                                        text: ProviderScope.containerOf(context)
                                                .read(storyProvider)
                                                .story
                                                .data!
                                                .story ??
                                            '',
                                        fontSize: AppSize.textSize + 3,
                                        align: TextAlign.justify,
                                        textHeight: 2.4,
                                        overflow: TextOverflow.visible,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ],
                )),
    );
  }
}
