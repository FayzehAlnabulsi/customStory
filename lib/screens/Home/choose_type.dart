import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/main.dart';
import 'package:custom_story/screens/Favorites/favorites_main.dart';
import 'package:custom_story/screens/Story/cutom_story_type.dart';
import 'package:custom_story/screens/Story/llevels_main.dart';
import 'package:custom_story/screens/quotes/random_quote.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/provider_class.dart';

class ChooseType extends StatefulWidget {
  const ChooseType({super.key});

  @override
  State<StatefulWidget> createState() => _ChooseTypeState();
}

class _ChooseTypeState extends State<ChooseType> {
  TextEditingController about = TextEditingController();
  StoryProviderClass? provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<StoryProviderClass>(context, listen: false);
      MyApp.getLocale(context: context).then((v) {
        setState(() {});
      });
      loadData();
    });

    super.initState();
  }

  loadData() async {
    await provider!.getFavoriteStories();
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
                    onSelected: (value) async {
                      await MyApp.setLocale(context: context, code: value!);
                      setState(() {
                        MyApp.locale = Locale(value!);
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
                              fontFamily: MyApp.locale == const Locale('ar')
                                  ? GoogleFonts.almarai().fontFamily
                                  : GoogleFonts.libreBaskerville().fontFamily,
                            ),
                          )),
                      DropdownMenuEntry(
                          label: '  ar  ',
                          value: 'ar',
                          style: TextButton.styleFrom(
                            textStyle: TextStyle(
                              fontSize: AppSize.smallSubText,
                              color: AppColor.darkGray,
                              fontFamily: MyApp.locale == const Locale('ar')
                                  ? GoogleFonts.almarai().fontFamily
                                  : GoogleFonts.libreBaskerville().fontFamily,
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
                    Assets.homeAnimation),
              ),
              Flexible(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 60.spMin),
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.6),
                            borderRadius: BorderRadius.circular(10.r)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(13.spMin),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AppText(
                              text: AppLocalizations.of(context)!.mainTitle,
                              fontSize: AppSize.titleSize,
                              overflow: TextOverflow.visible,
                              color: AppColor.darkGray.withOpacity(.8),
                              align: TextAlign.center,
                            ),
                            SizedBox(
                              height: 25.h,
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
                              height: 13.h,
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
                              height: 13.h,
                            ),
                            AppButtons(
                              onPressed: () {
                                AppRoutes.pushThenRefresh(
                                    context, const RandomQuote(), then: (v) {
                                  provider?.quote
                                      .data
                                      ?.encouragement = null;
                                });
                              },
                              text: AppLocalizations.of(context)!
                                  .encouragementMessage,
                              width: double.infinity,
                              backgroundColor: AppColor.green,
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            AppButtons(
                              onPressed: () {
                                AppRoutes.pushTo(
                                    context, const FavoritesMain());
                              },
                              text: AppLocalizations.of(context)!.favorites,
                              width: double.infinity,
                              backgroundColor: AppColor.purple.withOpacity(.6),
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
