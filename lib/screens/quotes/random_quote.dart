import 'package:audioplayers/audioplayers.dart';
import 'package:custom_story/Widget/AppDialog.dart';
import 'package:custom_story/Widget/AppText.dart';
import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/components/AppSize.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../../Widget/AppBar.dart';
import '../../../components/AppColor.dart';
import '../../BackEnd/provider_class.dart';
import '../../BackEnd/provider_instance.dart';
import '../../components/AppMessage.dart';
import '../../main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../Story/llevels_main.dart';

class RandomQuote extends StatefulWidget {
  const RandomQuote({super.key});

  @override
  State<StatefulWidget> createState() => _RandomQuoteState();
}

class _RandomQuoteState extends State<RandomQuote> {
  StoryProviderClass? provider;
  final player = AudioPlayer();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      provider = Provider.of<StoryProviderClass>(context, listen: false);
      loadData();
    });
  }

  loadData() async {
    AppDialog.showLoading(context: context);
    await provider!
        .getQuote(
            text:
                'اكتب جملة تشجيعية واحدة phrase من عشر كلمات ليس مصفوفة فقط بصيغة json عشوائية لطفل باللغة ${MyApp.locale == const Locale('en') ? 'الانجليزية' : 'العربية'}')
        .then((result) async {
      Navigator.pop(cc!);
      setState(() {});
      await player.play(AssetSource('sound/clapping.mp3'));

      result == AppMessage.loaded &&
              provider!.quote.data != null
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
                ).image)),
        child: Stack(
          fit: StackFit.expand,
          children: [
            LottieBuilder.asset(
              'assets/lottie/celebrate.json',
            ),
            Center(
              child: AppText( text: provider?.quote
                        .data
                        ?.encouragement ??
                    'انت شخص رائع',
                overflow: TextOverflow.visible,
                align: TextAlign.center,
                fontSize: AppSize.textSize,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
