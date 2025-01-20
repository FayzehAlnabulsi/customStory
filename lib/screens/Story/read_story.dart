import 'package:custom_story/BackEnd/provider_instance.dart';
import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
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
  ScrollController scrollController = ScrollController();

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
          padding: EdgeInsets.symmetric(
            vertical: 60.h,
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
                        left: 10.w,
                      ),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: IconButton(
                          icon: Icon(AppIcons.backArrow),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child: RawScrollbar(
                            controller: scrollController,
                            thumbVisibility: true,
                            thumbColor: AppColor.pink,
                            radius: Radius.circular(10.r),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.only(right: 13.w),
                                child: SizedBox(
                                  width: 265.w,
                                  child: Column(
                                    children: [
                                      AppText(
                                        text: ProviderScope.containerOf(context)
                                                .read(storyProvider)
                                                .story
                                                .data!
                                                .title ??
                                            '',
                                        fontSize: AppSize.titleSize,
                                        align: TextAlign.center,
                                        textHeight: 2.5,
                                        color:
                                            AppColor.darkGray.withOpacity(0.9),
                                        fontWeight: FontWeight.bold,
                                        textDirection: TextDirection.rtl,
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
                                        fontSize: AppSize.textSize,
                                        align: TextAlign.justify,
                                        textHeight: 2.4,
                                        textDirection: TextDirection.rtl,
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
