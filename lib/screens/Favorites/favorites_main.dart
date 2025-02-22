import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppDialog.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppMessage.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/class_models.dart';
import '../../BackEnd/provider_class.dart';
import '../../Widget/AppBar.dart';
import '../../components/AppColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../components/AppRoutes.dart';
import '../Story/learnt_morals.dart';
import '../Story/llevels_main.dart';
import '../Story/read_story.dart';

class FavoritesMain extends StatefulWidget {
  const FavoritesMain({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesMainState();
}

class _FavoritesMainState extends State<FavoritesMain> {
  StoryProviderClass? provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      provider = Provider.of<StoryProviderClass>(context, listen: false);
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
          text: '',
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
        padding: EdgeInsets.all(10.r),
        decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover,
              image: Image.asset(
                Assets.backgroundMain,
              ).image),
        ),
        child: Selector<StoryProviderClass, List<Story>>(
            selector: (_, provider) => provider.favoriteStories,
            builder: (context, list, child) {
              return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (_, i) => favContainer(list[i]));
            }),
      ),
    );
  }

  Widget favContainer(Story list) {
    return Dismissible(
      background: Container(
        margin: EdgeInsets.all(5.r),
        padding: EdgeInsets.all(10.r),
        color: AppColor.error,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  AppIcons.delete,
                  color: AppColor.white,
                  size: 25.r,
                ),
                SizedBox(
                  width: 5.w,
                ),
                AppText(
                  text: AppLocalizations.of(context)!.delete,
                  fontSize: AppSize.titleSize,
                  color: AppColor.white,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppText(
                  text: AppLocalizations.of(context)!.delete,
                  fontSize: AppSize.titleSize,
                  color: AppColor.white,
                ),
                SizedBox(
                  width: 5.w,
                ),
                Icon(
                  AppIcons.delete,
                  color: AppColor.white,
                  size: 25.r,
                ),
              ],
            ),
          ],
        ),
      ),
      confirmDismiss: (confirmed) async {
        return await AppDialog.infoDialogue(
            context: context,
            title: AppLocalizations.of(context)!.confirmDeleteTitle,
            message: AppLocalizations.of(context)!.confirmDeleteContent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 30.spMin, vertical: 30.spMin),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppButtons(
                      height: 35.h,
                      width: 110.w,
                      backgroundColor: AppColor.error,
                      textStyleColor: AppColor.white,
                      onPressed: () {
                        provider!.removeFavoriteStory(theStory: list);
                        Navigator.of(cc!).pop(true);
                      },
                      text: AppLocalizations.of(context)!.confirm),
                  AppButtons(
                      height: 35.h,
                      width: 110.w,
                      textStyleColor: AppColor.white,
                      backgroundColor: AppColor.darkGray.withOpacity(.5),
                      onPressed: () {
                        Navigator.of(cc!).pop(false);
                      },
                      text: AppLocalizations.of(context)!.cancel),
                ],
              ),
            ));
      },
      key: const Key(''),
      child: InkWell(
        onTap: () {
          provider!.story.data = list;
          provider!.story.result = AppMessage.loaded;
          AppRoutes.pushThenRefresh(context, const ReadStory(), then: (v) {
            AppRoutes.pushReplacementTo(
                context, noAnimation: true, const LearntMorals());
          });
        },
        child: Container(
          height: 80.h,
          width: double.infinity,
          margin: EdgeInsets.all(8.spMin),
          padding: EdgeInsets.all(10.spMin),
          decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(color: AppColor.darkGray, blurRadius: 3.r)
              ]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 30.r,
                backgroundColor: AppColor.purple.withOpacity(.6),
                child: Icon(
                  AppIcons.book,
                  color: AppColor.darkGray.withOpacity(.6),
                  size: AppSize.appBarIconsSize + 10,
                ),
              ),
              SizedBox(
                width: 15.spMin,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: list.title!,
                    fontSize: AppSize.titleSize - 1,
                    color: AppColor.darkGray.withOpacity(.8),
                  ),
                  AppText(
                    text: '${list.story!.substring(0, 25)}...',
                    fontSize: AppSize.subTitle,
                    color: AppColor.darkGray.withOpacity(.6),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
