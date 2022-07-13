import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';
import 'package:langapp/pages/videopage.dart';

class VideoListPage extends StatefulWidget{
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>{
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('bottom-navbar-item-1'.tr()),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              Row(
                children: [
                  ImageCard(title: 'map-item-1-title'.tr(), color: AppColors.FAMILY, imageAsset: 'assets/images/mapPage/myFamily.png', 
                    onPressedFunction: (){
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (context) => VideoPage()
                          )
                      );
                    },
                  ),
              ]),
              Row(
                children: [
                  ImageCard(title: 'map-item-2-title'.tr(), color: AppColors.HOUSE, imageAsset: 'assets/images/mapPage/myHouse.png', onPressedFunction: (){},),
              ]),
              Row(
                children: [
                  ImageCard(title: 'map-item-3-title'.tr(), color: AppColors.NATURE, imageAsset: 'assets/images/mapPage/nature.png', onPressedFunction: (){},),
              ]),
              Row(
                children: [
                  ImageCard(title: 'map-item-4-title'.tr(), color: AppColors.ANIMALS, imageAsset: 'assets/images/mapPage/animals.png', onPressedFunction: (){},),
              ]),
              Row(
                children: [
                  ImageCard(title: 'map-item-5-title'.tr(), color: AppColors.CULTURE, imageAsset: 'assets/images/mapPage/culture.png', onPressedFunction: (){},),
              ]),
              Row(
                children: [
                  ImageCard(title: 'map-item-6-title'.tr(), color: AppColors.FOOD, imageAsset: 'assets/images/mapPage/nationalFood.png', onPressedFunction: (){},),
              ]),
            ]
          ),
        ),
      )
    );
    
  }

}