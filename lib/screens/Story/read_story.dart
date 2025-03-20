import 'dart:async';
import 'dart:io';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:custom_story/BackEnd/provider_class.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:showcaseview/showcaseview.dart';
import '../../Widget/AppText.dart';
import 'llevels_main.dart';

class ReadStory extends StatefulWidget {
  const ReadStory({super.key});

  @override
  State<StatefulWidget> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  GlobalKey showCase1 = GlobalKey();
  GlobalKey showCase2 = GlobalKey();

  ScrollController scrollController = ScrollController();
  final record = Record();
  final player = AudioPlayer();

  bool isRecording = false;
  bool pause = false;
  bool isPlaying = false;

  int fromIndex = 0;
  int intTo = 85;

  Timer? timer;
  int hours = 0, minutes = 0, seconds = 0;

  BuildContext? showCase1Context;
  BuildContext? showCase2Context;

  bool? showCase;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      cc != null ? Navigator.pop(cc!) : null;
      showCase = await Provider.of<StoryProviderClass>(context, listen: false)
          .getShowCasePreferences();

      if (showCase != true) {
        ShowCaseWidget.of(showCase1Context!).startShowCase([showCase1]);
      }
    });

    player.onPlayerComplete.listen((event) {
      setState(() {
        isPlaying = false;
      });
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
  void dispose() {
    isPlaying ? player.stop() : null;
    record.dispose();
    super.dispose();
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
                              isPlaying ? player.stop() : null;
                              Navigator.pop(context);
                            },
                          ),
                          Consumer<StoryProviderClass>(
                              builder: (context, list, child) {
                            return Row(
                              children: [
                                list.story.data!.voiceFile != null
                                    ? CircleAvatar(
                                        radius: 17.r,
                                        backgroundColor:
                                            AppColor.darkGray.withOpacity(.05),
                                        child: IconButton(
                                            onPressed: () async {
                                              setState(() {
                                                isPlaying = !isPlaying;
                                              });
                                              isPlaying
                                                  ? await player.play(
                                                      DeviceFileSource(list
                                                          .story
                                                          .data!
                                                          .voiceFile!))
                                                  : await player.pause();
                                            },
                                            icon: Icon(
                                              isPlaying
                                                  ? Icons.pause
                                                  : AppIcons.play,
                                              color: AppColor.darkGray,
                                              size: AppSize.appBarIconsSize + 3,
                                            )),
                                      )
                                    : ShowCaseWidget(builder: (con) {
                                        showCase2Context = con;
                                        return Showcase(
                                          onBarrierClick: () {
                                            Provider.of<StoryProviderClass>(
                                                    context,
                                                    listen: false)
                                                .setShowCasePreferences();
                                          },
                                          key: showCase2,
                                          description:
                                              AppLocalizations.of(context)!
                                                  .recordStory,
                                          child: AnimatedContainer(
                                            duration: const Duration(
                                                milliseconds: 500),
                                            width: isRecording ? 120.w : 30.h,
                                            height: 30.h,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50.r),
                                                    border: Border.all(
                                                        color:
                                                            AppColor.darkGray,
                                                        width: .75)),
                                                child: Row(
                                                  mainAxisAlignment: isRecording
                                                      ? MainAxisAlignment.start
                                                      : MainAxisAlignment
                                                          .center,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Transform.translate(
                                                          offset:
                                                              Offset(3.w, 0),
                                                          child: InkWell(
                                                            onTap: () async {
                                                              String thePath =
                                                                  await getPath();

                                                              isRecording
                                                                  ? {
                                                                      pause
                                                                          ? await record
                                                                              .resume()
                                                                          : await record
                                                                              .pause(),
                                                                      setState(
                                                                          () {
                                                                        pause =
                                                                            !pause;
                                                                      }),
                                                                    }
                                                                  : {
                                                                      if (await record
                                                                          .hasPermission())
                                                                        {
                                                                          await record.start(
                                                                              path: thePath),
                                                                          setState(
                                                                              () {
                                                                            startTimer();
                                                                            pause =
                                                                                false;
                                                                            isRecording =
                                                                                true;
                                                                          })
                                                                        }
                                                                      else
                                                                        {
                                                                          await Permission
                                                                              .microphone
                                                                              .request(),
                                                                          if (await record
                                                                              .hasPermission())
                                                                            {
                                                                              await record.start(path: thePath),
                                                                              setState(() {
                                                                                startTimer();
                                                                                pause = false;
                                                                                isRecording = true;
                                                                              })
                                                                            }
                                                                        }
                                                                    };
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets.only(
                                                                  right:
                                                                      isRecording
                                                                          ? 10.w
                                                                          : 6.w,
                                                                  left:
                                                                      isRecording
                                                                          ? 5.w
                                                                          : 0),
                                                              child: Icon(
                                                                isRecording
                                                                    ? pause
                                                                        ? Icons
                                                                            .mic
                                                                        : Icons
                                                                            .pause
                                                                    : Icons.mic,
                                                                size: AppSize
                                                                        .appBarIconsSize +
                                                                    5,
                                                                color: AppColor
                                                                    .darkGray,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: isRecording,
                                                          child: SizedBox(
                                                            width: 5.w,
                                                            child:
                                                                VerticalDivider(
                                                              color: AppColor
                                                                  .lightGrey,
                                                              width: 1.w,
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: isRecording,
                                                          child: InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                isRecording =
                                                                    false;
                                                                stopTimer();
                                                              });
                                                              final path =
                                                                  await record
                                                                      .stop();
                                                              print(path);
                                                              list.story.data!
                                                                      .voiceFile =
                                                                  path;
                                                              await list
                                                                  .setFavoriteStory();
                                                            },
                                                            child: Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right:
                                                                          5.w),
                                                              child: Icon(
                                                                Icons.stop,
                                                                size: AppSize
                                                                        .appBarIconsSize +
                                                                    5,
                                                                color: AppColor
                                                                    .black,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Visibility(
                                                      visible: isRecording,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          right: 8.w,
                                                        ),
                                                        child: AppText(
                                                            text:
                                                                '0$hours:0$minutes:$seconds',
                                                            color: AppColor
                                                                .darkGray,
                                                            fontSize: AppSize
                                                                .appBarTextSize),
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        );
                                      }),
                                SizedBox(
                                  width: 5.w,
                                ),
                                ShowCaseWidget(builder: (con) {
                                  showCase1Context = con;
                                  return Showcase(
                                    key: showCase1,
                                    onBarrierClick: () async {
                                      await Future.delayed(
                                          const Duration(milliseconds: 300));
                                      ShowCaseWidget.of(showCase2Context!)
                                          .startShowCase([showCase2]);
                                    },
                                    description: AppLocalizations.of(context)!
                                        .addToFavorites,
                                    child: IconButton(
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
                                  );
                                }),
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

  Future<String> getPath() async {
    await Permission.storage.request();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    File file = File(
        '$appDocPath/levels/story${Duration.microsecondsPerMillisecond}.m4a');
    await file.create(recursive: true);
    return file.path;
  }
}
