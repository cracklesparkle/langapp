import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/customwidgets.dart';

class MapPage extends StatefulWidget{
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('bottom-navbar-item-1'.tr()),
        trailing: Icon(CupertinoIcons.globe),
      ),
      child: SafeArea(
        child: Column(
          children: [
            ImageCard(title: 'Моя семья', color: Colors.yellow.shade400, imageAsset: 'assets/images/mapPage/myFamily.png'),
          ],
        ),
      )
    );
    
  }

}