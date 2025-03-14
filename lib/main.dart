import 'package:custom_story/screens/Intro/introduction.dart';
import 'package:custom_story/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'BackEnd/provider_class.dart';
import 'components/AppMessage.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const  MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static Locale? locale;

  static Future<void> setLocale(
      {required BuildContext context, required String code}) async {
    _MyHomePageState? state =
    context.findAncestorStateOfType<_MyHomePageState>();
    state?.setLocale(Locale(code));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('locale', code);


  }

  static Future<Locale?> getLocale({required BuildContext context}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _MyHomePageState? state =
        context.findAncestorStateOfType<_MyHomePageState>();
    Locale tempLocale =
        state?.getLocale() ?? Locale(prefs.getString('locale') ?? 'en');
    locale = tempLocale;
    state?.setLocale(locale!);
    return locale;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: MyApp.locale == const Locale('ar')
            ? GoogleFonts.almarai().fontFamily
            : GoogleFonts.libreBaskerville().fontFamily,
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            textStyle: TextStyle(
              fontFamily: MyApp.locale == const Locale('ar')
                  ? GoogleFonts.almarai().fontFamily
                  : GoogleFonts.libreBaskerville().fontFamily,
            ),
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver{
  Locale? _locale;

  setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  getLocale() {
    return _locale;
  }

  initLocale() async {
    MyApp.getLocale(context: context).then((v) {
      _locale = v;
    });
  }

  @override
  void initState() {
    initLocale();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StoryProviderClass(),
        )
      ],
      child: ScreenUtilInit(
          minTextAdapt: true,
          builder: (_, __) => MaterialApp(
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: _locale,
                home: const SplashScreen(),
                debugShowCheckedModeBanner: false,
                title: AppMessage.appName,
              )),
    );
  }
}
