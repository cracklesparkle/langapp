import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:langapp/pages/mappage.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/settingspage.dart';

class MainPage extends StatelessWidget{
  final int language;

  const MainPage({
    Key? key,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoTabScaffold(
    tabBar: CupertinoTabBar(
      backgroundColor: CupertinoColors.lightBackgroundGray,
      activeColor: CupertinoColors.activeBlue,
      inactiveColor: CupertinoColors.inactiveGray,
      height: 60,
      onTap: (index){
        print('Clicked Tab $index');
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
            builder: (context) => NewPage(
              title: 'Tab 2 on lang $language', 
              color: CupertinoColors.activeOrange
            )
          );
        case 2:
          return CupertinoTabView(
            builder: (context) => NewPage(
              title: 'Tab 3 on lang $language', 
              color: CupertinoColors.activeBlue
            )
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
}