import 'package:audioplayers/audioplayers.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../Widget/AppBar.dart';
import '../../../components/AppColor.dart';
import '../../BackEnd/provider_instance.dart';
import '../../components/AppMessage.dart';

class RandomQuote extends StatefulWidget {
  const RandomQuote({super.key});

  @override
  State<StatefulWidget> createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  ProviderContainer? provider;
  bool loading = false;

  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = ProviderScope.containerOf(context);
      loadData();
    });
  }

  loadData() async {
    setState(() {
      loading = true;
    });
    await provider!
        .read(storyProvider)
        .getQuote(
            text:
                'اكتب عبارة واحدة  ليس مصفوفة goodnightMessage فقط  بصيغة json عشوائية لطفل قبل النوم باللغة العربية')
        .then((result) async {
      await player.play(AssetSource('sound/clapping.mp3'));

      setState(() {
        loading = false;
      });
      result == AppMessage.loaded &&
              provider!.read(storyProvider).quote.data != null
          ? null
          : null;
    });
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
          text: 'عبارة تشجيعية',
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
          color: AppColor.yellow.withOpacity(.2),
        ),
        child: loading
            ? Center(
                child: LottieBuilder.asset(
                  'assets/lottie/raffle.json',
                  height: 250.h,
                ),
              )
            : Center(
                child: AppText(
                  text: ProviderScope.containerOf(context)
                          .read(storyProvider)
                          .quote
                          .data
                          ?.encouragement ??
                      'انت شخص رائع',
                  overflow: TextOverflow.visible,
                  align: TextAlign.center,
                  fontSize: AppSize.textSize,
                ),
              ),
      ),
    );
  }
}
