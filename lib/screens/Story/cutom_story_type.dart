import 'package:custom_story/Widget/AppButtons.dart';
import 'package:custom_story/Widget/AppSnackBar.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/Widget/AppTextFields.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppMessage.dart';
import 'package:custom_story/components/AppRoutes.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../BackEnd/provider_class.dart';
import '../../Widget/AppBar.dart';
import '../../components/AppColor.dart';
import '../../main.dart';
import 'learnt_morals.dart';
import 'read_story.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomStory extends StatefulWidget {
  const CustomStory({super.key});

  @override
  State<StatefulWidget> createState() => _CustomStoryState();
}

class _CustomStoryState extends State<CustomStory> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController about = TextEditingController();
  TextEditingController hero = TextEditingController();
  StoryProviderClass? provider;

  bool loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<StoryProviderClass>(context, listen: false);
    });
    super.initState();
  }

  loadData() async {
    await provider!
        .getStory(
            text:
                'write kids story about ${about.text}, the main character name is ${hero.text} in a json format contains title and story and list of strings benefits in ${MyApp.locale == const Locale('en') ? 'english' : 'arabic'}')
        .then((result) {
      result == AppMessage.loaded &&
              provider!.story.data!.story!.isNotEmpty
          ? AppRoutes.pushThenRefresh(context, const ReadStory(), then: (v) {
              AppRoutes.pushReplacementTo(
                  context, noAnimation: true, const LearntMorals());
            })
          : AppSnackBar.showInSnackBar(
              context: context,
              message: AppLocalizations.of(context)!.tryAgainSthWrong,
              isSuccessful: false);
    });
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
          padding: EdgeInsets.all(15.r),
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  Assets.backgroundMain,
                ).image),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  constraints: BoxConstraints(maxHeight: 400.h),
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10.r)),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.r),
                child: Form(
                  key: _key,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: AppLocalizations.of(context)!.customStoryTitle,
                          fontSize: AppSize.titleSize - 2,
                          color: AppColor.darkGray,
                          overflow: TextOverflow.visible,
                          align: TextAlign.center,
                        ),
                        SizedBox(height: 20.h),
                        AppTextFields(
                          validator: (String? v) {
                            return v == null || v.isEmpty
                                ? AppLocalizations.of(context)!.required
                                : null;
                          },
                          controller: about,
                          fillColor: AppColor.white.withOpacity(0.5),
                          hintText: AppLocalizations.of(context)!.subject,
                        ),
                        SizedBox(height: 10.h),
                        AppTextFields(
                          validator: (String? v) {
                            return v == null || v.isEmpty
                                ? AppLocalizations.of(context)!.required
                                : null;
                          },
                          controller: hero,
                          hintText:
                              AppLocalizations.of(context)!.mainCharacterName,
                          fillColor: AppColor.white.withOpacity(0.5),
                        ),
                        SizedBox(height: 30.h),
                        AppButtons(
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                setState(() {
                                  loading = true;
                                });
                                await loadData();
                                setState(() {
                                  loading = false;
                                });
                              }
                            },
                            backgroundColor: AppColor.blue,
                            width: double.infinity,
                            label: loading
                                ? SizedBox(
                                    height: 25.h,
                                    width: 25.h,
                                    child: CircularProgressIndicator(
                                      color: AppColor.white,
                                    ),
                                  )
                                : null,
                            textStyleColor: AppColor.darkGray.withOpacity(0.7),
                            text: AppLocalizations.of(context)!.createStory),
                      ]),
                ),
              ),
            ],
          )),
    );
  }
}
