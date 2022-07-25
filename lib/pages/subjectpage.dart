import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/models/subjectmodel.dart';
import 'package:langapp/pages/audiolistpage.dart';
import 'package:langapp/pages/learnpage.dart';
import 'package:langapp/pages/videolistpage.dart';
import 'package:langapp/services/preferencesservice.dart';
import 'package:provider/provider.dart';

import '../helpers/appcolors.dart';

class SubjectPage extends StatefulWidget{
  final String title;
  final Color color;
  final int language;
  final List<SubjectOption> options;

  const SubjectPage({
    Key? key,
    required this.title,
    required this.color,
    required this.language,
    required this.options,
  }) : super(key: key);

  @override
  State<SubjectPage> createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
    //backgroundColor: color,
    navigationBar: CupertinoNavigationBar(
      middle: Text(widget.title),
      //trailing: TopNavBarButton(),
    ),
    child: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                      itemCount: widget.options.length,
                      itemBuilder: (context, index){
                        final _subjectOption = widget.options[index];
                        //return CupertinoActivityIndicator();
                        return buildOption(_subjectOption);
                      }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
                    ),
            ),
          ]
        ),
      )
    ),
  );
  }

  ImageCard buildOption(SubjectOption subjectOption){
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);
    IconData icon;
    switch(subjectOption.type){
      case "audio":
        icon = CupertinoIcons.headphones;
      break;
      case "video":
        icon = CupertinoIcons.film;
      break;
      case "quiz":
        icon = CupertinoIcons.list_bullet_below_rectangle;
      break;
      default:{
        icon = CupertinoIcons.nosign;
      }
    }
    return ImageCard(
                          title: subjectOption.title, 
                          color: CupertinoColors.systemGrey5,
                          iconData: icon,
                          onPressedFunction: (){
                            Navigator.of(context, rootNavigator: true).push(
                              CupertinoPageRoute(
                                builder: (context) {
                                  switch(subjectOption.type){
                                    case "audio":
                                      return AudioListPage(url: prefService.langs[prefService.langToLearn].url + subjectOption.url);
                                    
                                    case "video":
                                      return VideoListPage();
                                    
                                    case "quiz":
                                      return LearnPage();
                                    //if type not set for a subject
                                    default:{
                                      return AudioListPage(url: prefService.langs[prefService.langToLearn].url + subjectOption.url);
                                    }
                                  }
                                }
                            ));
                          }
                        );
  }
}