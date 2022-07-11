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

  runApp(
    EasyLocalization(
      supportedLocales: [
        Locale('en', 'US'), 
        Locale('ru', 'RU')
      ],
      path: 'assets/translations', // <-- change the path of the translation files 
      fallbackLocale: Locale('ru', 'RU'),
      child: MainApp()
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // set json file directory
    // default value is ['lib/i18n']

    return CupertinoApp(
      theme: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Montserrat',
            shadows: [Shadow(offset: Offset.fromDirection(1.0), blurRadius: 5, color: CupertinoColors.inactiveGray)]
          )
        )
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Welcome to Flutter',
      //home: MainPage()
      home: WelcomePage()
    );
  }
}