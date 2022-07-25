import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customfunctions.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/models/subjectmodel.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';
import 'package:langapp/services/preferencesservice.dart';
import 'package:provider/provider.dart';

class MapPage extends StatefulWidget{
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>{
  bool isLoading = false;
  
  static Future<List<Subject>> getSubjects() async{
    const url = 'http://45.67.35.180/json/lang1/subjects.json';
    final response = await get(Uri.parse(url));
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    return body.map<Subject>(Subject.fromJson).toList();
  }

  List<Subject> subjects = [];

  Future loadData() async{

    setState(() {
      isLoading = true;
    });

    //await Future.delayed(Duration(seconds: 2), (){});
    subjects = await getSubjects();
    //audios = List.of(allAudios);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState(){
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);
    print(prefService.langs[0].title);

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('bottom-navbar-item-1'.tr() + prefService.langToLearn.toString()),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: CupertinoScrollbar(
          child: ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: isLoading ? 1 : subjects.length,
            itemBuilder: (context, index){
              if (isLoading){
                    return CupertinoActivityIndicator();
                } else{
                  final _subject = subjects[index];
                  return buildSubject(_subject, index);
                }
            },
          ),
        ),
      )
    );
    
  }

  Row buildSubject(Subject subject, index){
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);
    return Row(
                mainAxisAlignment: index % 2 == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
                children: [
                  ImageCard(title: subject.title, color: hexToColor(subject.color), imageAsset: subject.imageAsset, 
                    onPressedFunction: (){
                      Navigator.of(context, rootNavigator: true).push(
                        CupertinoPageRoute(
                          builder: (context) => SubjectPage(
                              title: subject.title, 
                              color: hexToColor(subject.color),
                              language: prefService.langToLearn,
                              options: subject.options,
                            )
                          )
                      );
                    },
                  ),
              ]);
  }
}