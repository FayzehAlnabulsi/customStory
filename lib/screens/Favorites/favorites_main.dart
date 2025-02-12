import 'package:custom_story/components/AppIcons.dart';
import 'package:custom_story/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../Widget/AppBar.dart';
import '../../components/AppColor.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoritesMain extends StatefulWidget {
  const FavoritesMain({super.key});

  @override
  State<StatefulWidget> createState() => _FavoritesMainState();
}

class _FavoritesMainState extends State<FavoritesMain> {
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
      ),
    );
  }
}
