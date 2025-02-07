import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/main.dart';
import 'package:custom_story/screens/Home/story_type/cutom_story_type.dart';
import 'package:custom_story/screens/Story/llevels_main.dart';
import 'package:custom_story/screens/quotes/random_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../BackEnd/provider_instance.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      MyApp.getLocale(context: context).then((v) {
        print(MyApp.locale);
        setState(() {});
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: AppLocalizations.of(context)!.customStory,
          directionality: TextDirection.ltr,
          actions: [
            Visibility(
              visible: MyApp.locale != null,
              child: Transform.translate(
                offset: Offset(30.w, 5.h),
                child: DropdownMenu(
                    leadingIcon: Icon(
                      AppIcons.globe,
                      color: Colors.white,
                      size: AppSize.appBarIconsSize,
                    ),
                    width: 75.w,
                    trailingIcon: Icon(
                      AppIcons.forwardArrow,
                      color: AppColor.noColor,
                    ),
                    selectedTrailingIcon: Icon(
                      AppIcons.forwardArrow,
                      color: AppColor.noColor,
                    ),
                    menuStyle: MenuStyle(
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    )),
                    onSelected: (value) {
                      MyApp.setLocale(context: context, code: value!);
                      setState(() {
                        MyApp.locale = Locale(value);
                      });
                    },
                    textStyle: TextStyle(color: AppColor.noColor),
                    inputDecorationTheme: const InputDecorationTheme(
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none)),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(
                          label: '  en  ',
                          value: 'en',
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: AppSize.smallSubText - 2,
                              color: AppColor.darkGray,
                              fontFamily:
                                  GoogleFonts.libreBaskerville().fontFamily,
                            ),
                          )),
                      DropdownMenuEntry(
                          label: '  ar  ',
                          value: 'ar',
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: AppSize.smallSubText,
                              color: AppColor.darkGray,
                              fontFamily:
                                  GoogleFonts.libreBaskerville().fontFamily,
                            ),
                          ))
                    ]),
              ),
            ),
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
                                AppRoutes.pushThenRefresh(
                                    context, const RandomQuote(), then: (v) {
                                  ProviderScope.containerOf(context)
                                      .read(storyProvider)
                                      .quote
                                      .data
                                      ?.encouragement = null;
                                });
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
