import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService extends ChangeNotifier{

  int langToLearn = 0;
  int appLang = 0;

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