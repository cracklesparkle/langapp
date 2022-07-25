import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/models/langmodel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier{

  int langToLearn = 0;
  int appLang = 0;

  List<Lang> langs = [
    Lang(title: 'lang0-name'.tr(), url: "http://45.67.35.180/json/lang1/"),
    Lang(title: 'lang1-name'.tr(), url: "http://45.67.35.180/json/lang2/"),
    Lang(title: 'lang2-name'.tr(), url: "http://45.67.35.180/json/lang3/"),
    Lang(title: 'lang3-name'.tr(), url: "http://45.67.35.180/json/lang4/"),
  ];

  Future loadPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    langToLearn = await prefs.getInt('lang')!;
    // setState(() {
    //   isLoading = false;
    // });
  }
  
  void setLang(int lang) async{
    final prefs = await SharedPreferences.getInstance();
    //set language
    await prefs.setInt('lang', lang);
  }

  void changeLangToLearn(int newLangToLearn) async{
    langToLearn = newLangToLearn;
    final prefs = await SharedPreferences.getInstance();
    //set language
    await prefs.setInt('lang', newLangToLearn);

    notifyListeners();
    //print(langToLearn);

  }
}