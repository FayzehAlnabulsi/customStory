import 'package:custom_story/BackEnd/provider_instance.dart';
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../Widget/AppBar.dart';
import '../../../components/AppColor.dart';
import '../../Story/read_story.dart';

class CustomStory extends StatefulWidget {
  const CustomStory({super.key});

  @override
  State<StatefulWidget> createState() => _CustomStoryState();
}

class _CustomStoryState extends State<CustomStory> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController about = TextEditingController();
  TextEditingController hero = TextEditingController();
  ProviderContainer? provider;

  bool loading = false;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = ProviderScope.containerOf(context);
    });
    super.initState();
  }

  loadData() async {
    await provider!
        .read(storyProvider)
        .getStory(
            text:
                'اكتب قصة قصيرة عن ${about.text},واسم الشخصية الرئيسية ${hero.text} بصيغة json وتحتوي على عنوان و فوائد القصة ')
        .then((result) {
      result == AppMessage.loaded && provider!
          .read(storyProvider).story.data!.story!.isNotEmpty
          ? AppRoutes.pushTo(context, const ReadStory())
          : AppSnackBar.showInSnackBar(
              context: context,
              message: AppMessage.tryAgainSthWrong,
              isSuccessful: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: 'قصة مخصصة',
          actions: [],
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
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Form(
                    key: _key,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: 'قم بتخصيص جوهر للقصة واسم بطل/ة القصة',
                            fontSize: AppSize.titleSize,
                            color: AppColor.darkGray,
                            overflow: TextOverflow.visible,
                            align: TextAlign.center,
                          ),
                          SizedBox(height: 20.h),
                          AppTextFields(
                            validator: (String? v) {
                              return v == null || v.isEmpty
                                  ? AppMessage.mandatoryTx
                                  : null;
                            },
                            controller: about,
                            textDirection: TextDirection.rtl,
                            textAlignment: TextAlign.right,
                            fillColor: AppColor.white.withOpacity(0.5),
                            hintText: 'جوهر القصة',
                          ),
                          SizedBox(height: 10.h),
                          AppTextFields(
                            validator: (String? v) {
                              return v == null || v.isEmpty
                                  ? AppMessage.mandatoryTx
                                  : null;
                            },
                            controller: hero,
                            textDirection: TextDirection.rtl,
                            textAlignment: TextAlign.right,
                            hintText: 'اسم بطل/ة القصة',
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
                              textStyleColor:
                                  AppColor.darkGray.withOpacity(0.7),
                              text: loading ? 'تحميل' : 'انشاء قصة'),
                        ]),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
