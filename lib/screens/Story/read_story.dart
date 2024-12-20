import 'package:custom_story/BackEnd/provider_instance.dart';
import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Widget/AppText.dart';

class ReadStory extends StatefulWidget {
  const ReadStory({super.key});

  @override
  State<StatefulWidget> createState() => _ReadStoryState();
}

class _ReadStoryState extends State<ReadStory> {
  int fromIndex = 0;
  int intTo = 85;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 60.spMin, horizontal: 40.spMin),
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
            : RawScrollbar(
                controller: ScrollController(),
                thumbVisibility: true,
                thumbColor: AppColor.pink,
                radius: Radius.circular(10.r) ,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(right: 15.w),
                    child: Column(
                      crossAxisAlignment: intTo <
                              ProviderScope.containerOf(context)
                                      .read(storyProvider)
                                      .story
                                      .data!
                                      .story!
                                      .split(' ')
                                      .length -
                                  1
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            intTo <
                                    ProviderScope.containerOf(context)
                                            .read(storyProvider)
                                            .story
                                            .data!
                                            .story!
                                            .split(' ')
                                            .length -
                                        1
                                ? Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 8.h, top: 20.h),
                                    child: AppText(
                                      text: ProviderScope.containerOf(context)
                                              .read(storyProvider)
                                              .story
                                              .data
                                              ?.title ??
                                          '',
                                      fontSize: AppSize.titleSize,
                                      align: TextAlign.justify,
                                      color: AppColor.darkGray,
                                      fontWeight: FontWeight.bold,
                                      textDirection: TextDirection.rtl,
                                      overflow: TextOverflow.visible,
                                    ),
                                  )
                                : SizedBox(
                                    height: 15.h,
                                  ),
                            AppText(
                              text: ProviderScope.containerOf(context)
                                      .read(storyProvider)
                                      .story
                                      .data
                                      ?.story
                                      ?.substring(
                                          fromIndex,
                                          ProviderScope.containerOf(context)
                                                      .read(storyProvider)
                                                      .story
                                                      .data!
                                                      .story!
                                                      .split(' ')
                                                      .length >
                                                  85
                                              ? ProviderScope.containerOf(context)
                                                  .read(storyProvider)
                                                  .story
                                                  .data!
                                                  .story!
                                                  .indexOf(
                                                      ProviderScope.containerOf(context)
                                                          .read(storyProvider)
                                                          .story
                                                          .data!
                                                          .story!
                                                          .split(' ')[intTo])
                                              : ProviderScope.containerOf(context)
                                                  .read(storyProvider)
                                                  .story
                                                  .data!
                                                  .story!
                                                  .indexOf(
                                                      ProviderScope.containerOf(
                                                              context)
                                                          .read(storyProvider)
                                                          .story
                                                          .data!
                                                          .story!
                                                          .split(' ')
                                                          .last)) ??
                                  ' ',
                              fontSize: AppSize.textSize,
                              align: TextAlign.justify,
                              textHeight: 2.4,
                              textDirection: TextDirection.rtl,
                              overflow: TextOverflow.visible,
                            ),
                          ],
                        ),
                        // intTo <
                        //         ProviderScope.containerOf(context)
                        //                 .read(storyProvider)
                        //                 .story
                        //                 .data!
                        //                 .story!
                        //                 .split(' ')
                        //                 .length -
                        //             1
                        //     ? Padding(
                        //   padding: EdgeInsets.only(bottom: 20.h),
                        //       child: AppButtons(
                        //           onPressed: () {
                        //             setState(() {
                        //               fromIndex = intTo;
                        //               intTo = ProviderScope.containerOf(context)
                        //                       .read(storyProvider)
                        //                       .story
                        //                       .data!
                        //                       .story!
                        //                       .split(' ')
                        //                       .length -
                        //                   1;
                        //             });
                        //           },
                        //           text: '>>',
                        //           radius: 50.r,
                        //           backgroundColor: AppColor.green,
                        //           textStyleColor: Colors.white,
                        //           textSize: AppSize.titleSize,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //     )
                        //     : intTo ==
                        //             ProviderScope.containerOf(context)
                        //                     .read(storyProvider)
                        //                     .story
                        //                     .data!
                        //                     .story!
                        //                     .split(' ')
                        //                     .length -
                        //                 1
                        //         ? Padding(
                        //             padding: EdgeInsets.only(bottom: 20.h),
                        //             child: AppButtons(
                        //               onPressed: () {
                        //                 setState(() {
                        //                   fromIndex = 0;
                        //                   intTo = 85;
                        //                 });
                        //               },
                        //               text: '<<',
                        //               radius: 50.r,
                        //               backgroundColor: AppColor.green,
                        //               textStyleColor: Colors.white,
                        //               textSize: AppSize.titleSize,
                        //               fontWeight: FontWeight.bold,
                        //             ),
                        //           )
                        //         : const SizedBox(),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
