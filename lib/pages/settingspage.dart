import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget{
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage>{
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('bottom-navbar-item-4'.tr()),
    ),
    child: SafeArea(
     child: CupertinoScrollbar(
      child: ListView(
        children: [
          Material(
            child: LangSelect()
          ),
            
        ],
      )
     )
    ),
  );
}

class LangSelect extends StatefulWidget{
  const LangSelect({super.key});

  @override
  State<LangSelect> createState() => _LangSelectState();
}

class _LangSelectState extends State<LangSelect>{
  bool isLoading = false;
  int currentLang = 0;
  bool _langChanged = false;

   @override
  void initState(){
    super.initState();

    loadPrefs();
  }

  Future loadPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    currentLang = await prefs.getInt('lang')!;
    
    // setState(() {
    //   isLoading = false;
    // });
  }
  
  void setLang(int lang) async{
    final prefs = await SharedPreferences.getInstance();
    //set language
    await prefs.setInt('lang', lang);

    setState(() {
      loadPrefs();
    });
  }

  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('welcome-page-button-choose-language-popup-title'.tr()),
        message: Text('welcome-page-button-choose-language-popup-descr'.tr()),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setLang(1);
            },
            child: Text('lang1-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setLang(2);
            },
            child: Text('lang2-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setLang(3);
            },
            child: Text('lang3-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.pop(context);
              setLang(4);
            },
            child: Text('lang4-name'.tr()),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return ListTile(
              onTap: (){
                _showActionSheet(context);
              },
              title: Text('Язык для изучения'),
              subtitle: Text(currentLang == 0 ? '': 'Текущий язык: $currentLang'),
    );
  }
}