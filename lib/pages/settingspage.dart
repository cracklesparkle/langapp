import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('bottom-navbar-item-4'.tr()),
    ),
    child: SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
          ]
        ),
      )
    ),
  );
}