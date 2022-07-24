import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/pages/learnpage.dart';
import 'package:langapp/pages/librarypage.dart';
import 'package:langapp/pages/mappage.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/settingspage.dart';
import 'package:langapp/pages/videolistpage.dart';
import 'package:langapp/services/preferencesservice.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainPage extends StatelessWidget{
  int language;

  MainPage({
    Key? key,
    required this.language,
  }) : super(key: key);

  Future loadPrefs() async{
    final prefs = await SharedPreferences.getInstance();
    language = await prefs.getInt('lang')!;
    
    // setState(() {
    //   isLoading = false;
    // });
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);
    prefService.loadPrefs();
    return Consumer<PreferencesService>(
      builder: (context, prefs, child){
        return CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      //backgroundColor: CupertinoColors.lightBackgroundGray,
      //activeColor: CupertinoColors.activeBlue,
      //inactiveColor: CupertinoColors.inactiveGray,
      height: 60,
      onTap: (index){
        
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.house),
          activeIcon: Icon(CupertinoIcons.house_fill),
          label: 'bottom-navbar-item-1'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.book),
          activeIcon: Icon(CupertinoIcons.book_fill),
          label: 'bottom-navbar-item-2'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.play_circle),
          activeIcon: Icon(CupertinoIcons.play_circle_fill),
          label: 'bottom-navbar-item-3'.tr(),
        ),
        BottomNavigationBarItem(
          icon: Icon(CupertinoIcons.gear),
          activeIcon: Icon(CupertinoIcons.gear_solid),
          label: 'bottom-navbar-item-4'.tr(),
        ),
      ],
    ), 
    tabBuilder: (context, index){
      switch(index){
        case 0:
          return CupertinoTabView(
            builder: (context) => MapPage()
          );
        case 1:
          return CupertinoTabView(
            builder: (context) => LibraryPage(color: Colors.white, language: prefs.langToLearn)
          );
        case 2:
          return CupertinoTabView(
            builder: (context) => VideoListPage()
          );
        case 3:
        default:
          return CupertinoTabView(
            builder: (context) => SettingsPage(
            )
          );
      }
    },
  );
      },
    );
  }
}