import 'package:custom_story/BackEnd/provider_instance.dart';
import 'package:custom_story/Widget/AppBar.dart';
import 'package:custom_story/Widget/AppDialog.dart';
import 'package:custom_story/components/AppColor.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:custom_story/screens/Story/read_story.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import '../../Widget/AppSnackBar.dart';
import '../../Widget/AppText.dart';
import '../../components/AppMessage.dart';
import '../../components/AppRoutes.dart';
import 'learnt_morals.dart';

BuildContext? cc;

class LevelsMain extends StatefulWidget {
  const LevelsMain({super.key});

  @override
  State<StatefulWidget> createState() => _LevelsMainState();
}

class _LevelsMainState extends State<LevelsMain> {
  ProviderContainer? provider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = ProviderScope.containerOf(context);
    });
    super.initState();
  }

  loadData({required String subject}) async {
    await provider!
        .read(storyProvider)
        .getStory(
            text:
                'write story about $subject in a json format contains benefits and title in arabic')
        .then((result) {
      result == AppMessage.loaded &&
              provider!.read(storyProvider).story.data!.story!.isNotEmpty
          ? AppRoutes.pushThenRefresh(context, const ReadStory(), then: (v) {
              AppRoutes.pushReplacementTo(
                  context, noAnimation: true, const LearntMorals());
            })
          : AppSnackBar.showInSnackBar(
              context: context,
              message: AppMessage.tryAgainSthWrong,
              isSuccessful: false);
    });
  }

  List<String> adj = [
    'الصدق',
    'التعاون',
    'المسامحة',
    'الكرم',
    'الصبر',
    'الإحترام',
    'الصداقة',
    'المساعدة',
    'الوفاء',
    'القناعة',
    'تحمل المسؤولية',
    'الرفق'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: '',
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
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: Image.asset(
                  Assets.backgroundMain,
                ).image)),
        child: Column(
          children: [
            Flexible(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.only(top: 15.h),
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, childAspectRatio: .8),
                  children: List.generate(
                      12,
                      (i) => InkWell(
                            onTap: () async {
                              AppDialog.showLoading(context: context);
                              await loadData(subject: adj[i]);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: AppColor.white.withOpacity(.3),
                              ),
                              margin: EdgeInsets.all(5.r),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible(
                                      flex: 2,
                                      child: Image.asset(
                                        'assets/images/book.png',
                                        color: i == 0
                                            ? null
                                            : AppColor.lightGrey
                                                .withOpacity(.4),
                                      )),
                                  SizedBox(
                                    height: 5.h,
                                  ),
                                  Visibility(
                                    visible: i == 0,
                                    child: Flexible(
                                        flex: 1,
                                        child: AppText(
                                          text: i == 0 ? adj[i] : '',
                                          color: AppColor.darkGray,
                                          fontSize: AppSize.textSize,
                                        )),
                                  )
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
