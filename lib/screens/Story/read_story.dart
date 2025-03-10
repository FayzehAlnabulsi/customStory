import 'dart:async';

import 'package:custom_story/BackEnd/provider_class.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/class_models.dart';
import '../../Widget/AppText.dart';
import 'llevels_main.dart';

class ReadStory extends StatefulWidget {
  const ReadStory({super.key});

  @override
  State<StatefulWidget> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  ScrollController scrollController = ScrollController();

  bool isRecording = false;
  bool pause = false;

  int fromIndex = 0;
  int intTo = 85;

  Timer? timer;
  int hours = 0, minutes = 0, seconds = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cc != null ? Navigator.pop(cc!) : null;
    });
    super.initState();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (v) {
      if (pause == false) {
        setState(() {
          seconds++;
          if (seconds == 60) {
            seconds = 0;
            minutes++;
          }
          if (minutes == 60) {
            minutes = 0;
            hours++;
          }
        });
      }
    });
  }

  stopTimer() {
    timer = null;
    seconds = 0;
    minutes = 0;
    hours = 0;
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
          child: Provider.of<StoryProviderClass>(context, listen: false)
                      .story
                      .data ==
                  null
              ? const SizedBox()
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          right:
                              MyApp.locale == const Locale('ar') ? 35.w : 35.w,
                          left: 35.w,
                          bottom: 10.h),
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
                          Consumer<StoryProviderClass>(
                              builder: (context, list, child) {
                            return Row(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  width: isRecording ? 120.w : 30.h,
                                  height: 30.h,
                                  child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50.r),
                                          border: Border.all(
                                              color: AppColor.darkGray,
                                              width: .75)),
                                      child: Row(
                                        mainAxisAlignment: isRecording
                                            ? MainAxisAlignment.start
                                            : MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Transform.translate(
                                                offset: Offset(3.w, 0),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      isRecording
                                                          ? {pause = !pause}
                                                          : {
                                                              isRecording =
                                                                  true,
                                                              startTimer(),
                                                              pause = false
                                                            };
                                                    });
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: isRecording
                                                            ? 10.w
                                                            : 6.w,
                                                        left: isRecording
                                                            ? 5.w
                                                            : 0),
                                                    child: Icon(
                                                      isRecording
                                                          ? pause
                                                              ? Icons.mic
                                                              : Icons.pause
                                                          : Icons.mic,
                                                      size: AppSize
                                                              .appBarIconsSize +
                                                          5,
                                                      color: AppColor.darkGray,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isRecording,
                                                child: SizedBox(
                                                  width: 5.w,
                                                  child: VerticalDivider(
                                                    color: AppColor.lightGrey,
                                                    width: 1.w,
                                                  ),
                                                ),
                                              ),
                                              Visibility(
                                                visible: isRecording,
                                                child: InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      isRecording = false;
                                                      stopTimer();
                                                    });
                                                    list.story.data!.voiceFile =
                                                        'file';
                                                    await list
                                                        .setFavoriteStory();
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        right: 5.w),
                                                    child: Icon(
                                                      Icons.stop,
                                                      size: AppSize
                                                              .appBarIconsSize +
                                                          5,
                                                      color: AppColor.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: isRecording,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                right: 8.w,
                                              ),
                                              child: AppText(
                                                  text:
                                                      '0$hours:0$minutes:$seconds',
                                                  color: AppColor.darkGray,
                                                  fontSize:
                                                      AppSize.appBarTextSize),
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                                SizedBox(
                                  width: 5.w,
                                ),
                                IconButton(
                                  icon: Icon(
                                    AppIcons.favorite,
                                    size: AppSize.appBarIconsSize + 5,
                                    color: list.favoriteStories
                                            .contains(list.story.data)
                                        ? AppColor.favorite
                                        : AppColor.darkGray,
                                  ),
                                  onPressed: () async {
                                    if (!list.favoriteStories
                                        .contains(list.story.data)) {
                                      await list.setFavoriteStory();
                                    } else {
                                      await list.removeFavoriteStory();
                                    }
                                  },
                                ),
                              ],
                            );
                          }),
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
                                        text: Provider.of<StoryProviderClass>(
                                                    context,
                                                    listen: false)
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
                                        text: Provider.of<StoryProviderClass>(
                                                    context,
                                                    listen: false)
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
