import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:langapp/pages/mainpage.dart';
import 'package:langapp/pages/welcomepage.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final firstLaunch = prefs.getBool('firstLaunch') ?? true;
  final lang = prefs.getInt('lang') ?? 0;
  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'), 
        Locale('ru', 'RU')
      ],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: Locale('ru', 'RU'),
      child: MainApp(firstLaunch: firstLaunch, lang: lang,)
    )
  );
}

class MainApp extends StatelessWidget {
  final bool firstLaunch;
  final int lang;
  const MainApp({super.key, required this.firstLaunch, required this.lang});

  @override
  Widget build(BuildContext context) {
    
    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            color: CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.black,
              darkColor: CupertinoColors.white,
            ),
            shadows: [Shadow(offset: Offset.fromDirection(1.0), blurRadius: 5, color: CupertinoColors.inactiveGray)]
          )
        )
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Welcome to Flutter',
      //home: MainPage()
      home: firstLaunch == true ? WelcomePage() : MainPage(language: lang)
    );
  }
}