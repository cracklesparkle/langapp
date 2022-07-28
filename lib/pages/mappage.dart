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
      backgroundColor: hexToColor('#73ac83'),
      navigationBar: CupertinoNavigationBar(
        middle: Text('bottom-navbar-item-1'.tr()),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/mapPage/river/river.png'),
              repeat: ImageRepeat.repeatY
              )
            ),
            height: isLoading ? 1 : subjects.length * 197,
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
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
        ),
      )
    );
    
  }

  Widget buildSubject(Subject subject, index){
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);
    return Row(
      mainAxisAlignment: index % 2 == 0 ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Stack(
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
            
          ],
        ), 
    ]);
  }
}

class MapPainter extends CustomPainter{
    @override
    void paint(Canvas canvas, Size size){
      final paint = Paint()
      ..color = Colors.amber
      ..strokeWidth = 10;
      canvas.drawLine(
        Offset(size.width * 1/6, size.height * 1/2),
        Offset(size.width * 5/6, size.height * 0),
        paint
      );
    }

    @override
    bool shouldRepaint(CustomPainter old){
      return false;
    }
  }