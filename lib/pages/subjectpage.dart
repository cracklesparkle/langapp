import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/pages/audiolistpage.dart';
import 'package:langapp/pages/learnpage.dart';
import 'package:langapp/pages/videolistpage.dart';

import '../helpers/appcolors.dart';

class SubjectPage extends StatelessWidget{
  final String title;
  final Color color;
  final int number;
  final int language;

  const SubjectPage({
    Key? key,
    required this.title,
    required this.color,
    this.number = 1,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    //backgroundColor: color,
    navigationBar: CupertinoNavigationBar(
      middle: Text(title),
      trailing: TopNavBarButton(),
    ),
    child: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                        ImageCard(
                          title: 'category-audio'.tr(), 
                          color: CupertinoColors.systemGrey5,
                          iconData: CupertinoIcons.headphones,
                          onPressedFunction: (){
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                builder: (context) => AudioListPage()
                            ));
                          }
                        ),
                        ImageCard(
                          title: 'category-video'.tr(), 
                          color: CupertinoColors.systemGrey5, 
                          iconData: CupertinoIcons.film,
                          onPressedFunction: (){
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (context) => VideoListPage()
                                )
                            );
                          }
                        ),
                        ImageCard(title: 'category-test'.tr(), 
                          color: CupertinoColors.systemGrey5, 
                          iconData: CupertinoIcons.list_bullet_below_rectangle,
                          onPressedFunction: (){
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (context) => LearnPage(color: color)
                                )
                            );
                          }
                        ),
                        ImageCard(title: 'category-test'.tr(), 
                          color: CupertinoColors.systemGrey5, 
                          iconData: CupertinoIcons.list_bullet_below_rectangle,
                          onPressedFunction: (){
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                  builder: (context){
                                    return Scaffold(
                                      body: Center(child: WordCardWidget(color: CupertinoColors.systemGrey3, definition: 'whatever', splitWords: ['as', 'sd', 'as'], type: 'asdz', example: 'asdasg',))
                                    );
                                  } 
                                )
                            );
                          }
                        )
                      ],
                    ),
            ),
          ]
        ),
      )
    ),
  );
}