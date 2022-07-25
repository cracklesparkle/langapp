import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langapp/models/quiz.dart';
import 'package:langapp/pages/mainpage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../services/preferencesservice.dart';

class MButton extends StatelessWidget{
  const MButton({
    Key? key,
    required this.text,
    required this.onPressedfunction
  }) : super(key: key);

  final Function() onPressedfunction;
  final String text;

  @override
  Widget build(BuildContext context){
    return ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blueAccent
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.all(16.0),
                    primary: Colors.white,
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: onPressedfunction,
                  child: Text(text),
                ),
              ],
            ),
          );
  }
}

class CButton extends StatelessWidget{
  const CButton({
    Key? key,
    required this.text,
    required this.color,
    required this.onPressedfunction
  }) : super(key: key);

  final Function() onPressedfunction;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context){
    return CupertinoButton(
      borderRadius: BorderRadius.circular(80),
      //padding: EdgeInsets.symmetric(horizontal: 48, vertical: 12),
      color: CupertinoColors.activeBlue,
      child: Text(
        text,
        style: TextStyle(
            inherit: true,
            fontSize: 18,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
            color: Colors.white
          ),
        ),
      onPressed: onPressedfunction
    );
  }
}

//Button for language select on top navigation bar
class TopNavBarButton extends StatelessWidget{

  void setLang(int lang) async{
    final prefs = await SharedPreferences.getInstance();
    //set language
    await prefs.setInt('lang', lang);
  }
  void _showActionSheet(BuildContext context) {
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: false);
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('welcome-page-button-choose-language-popup-title'.tr()),
        message: Text('welcome-page-button-choose-language-popup-descr'.tr()),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              //Navigator.pop(context);
              // Navigator.pushReplacement(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) {
              //       return MainPage(language: 1);
              //     }
              //     )
              //   );
              Navigator.pop(context);
              prefService.changeLangToLearn(0);
              setLang(0);
            },
            child: Text('lang0-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) {
              //       return MainPage(language: 2);
              //     }
              //     )
              //   );
              Navigator.pop(context);
              setLang(1);
              prefService.changeLangToLearn(1);
            },
            child: Text('lang1-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => MainPage(language: 3)
              //     )
              //   );
              Navigator.pop(context);
              setLang(2);
              prefService.changeLangToLearn(2);
            },
            child: Text('lang2-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              // Navigator.pushReplacement(
              //   context,
              //   CupertinoPageRoute(
              //     builder: (context) => MainPage(language: 4)
              //     )
              //   );
              Navigator.pop(context);
              setLang(3);
              prefService.changeLangToLearn(3);
            },
            child: Text('lang3-name'.tr()),
          )
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context){
    
    return CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Icon(CupertinoIcons.globe),
            onPressed: (){_showActionSheet(context);},
    );
  }
}

class WordWidget extends StatelessWidget{
  final List<String> splitWords;
  final String type;
  final String definition;
  final String example;

  const WordWidget({
    Key? key,
    required this.splitWords,
    required this.type,
    required this.definition,
    required this.example,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    final bullet = " \u2022 ";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Word of the Day',
          style: TextStyle(fontSize: 22, color: Colors.white54),),
        const SizedBox(height: 12),
        Text(
          splitWords.join(bullet),
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: -1,),
        ),
        const SizedBox(height: 12),
        Text(
          type,
          style: TextStyle(fontSize: 20, color: Colors.white54),
        ),
        const SizedBox(height: 8),
        Text(
          definition,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(height: 8),
        Text(
          example,
          style: TextStyle(fontSize: 20, color: Colors.white70),
        ),
      ],
    );
  }
}

class WordCardWidget extends StatelessWidget{
  final List<String> splitWords;
  final String type;
  final String definition;
  final String example;
  final Color color;

  const WordCardWidget({
    Key? key,
    required this.splitWords,
    required this.type,
    required this.definition,
    required this.example,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
    return Card(
      shadowColor: CupertinoColors.inactiveGray,
      elevation: 8,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            WordWidget(splitWords: splitWords, type: type, definition: definition, example: example),
            SizedBox(height: 12),
            TextButton(onPressed: (){}, child: Text('Learn more'))
          ],
        ))
      );
  }
}

class ImageCard extends StatelessWidget{
  final String title;
  final Color color;
  final String? imageAsset;
  final IconData? iconData;
  final Function() onPressedFunction;

  const ImageCard({
    Key? key,
    required this.title,
    required this.color,
    this.imageAsset,
    this.iconData,
    required this.onPressedFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
    return CupertinoButton(
      onPressed: onPressedFunction,
      child: SizedBox(
        height: 165,
        width: 165,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shadowColor: CupertinoColors.inactiveGray,
          elevation: 8,
          color: Color.fromRGBO(110, 110, 110, 1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                color: color,
                child: imageAsset != null 
                        ? Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                              child: Image.asset(imageAsset!, height: 100, fit: BoxFit.contain)
                            ),
                          ],
                )
                : Container(
                    child: iconData != null ? Icon(iconData!, size: 60,) : Icon(CupertinoIcons.xmark, size: 60),
                    height: 100,
                  )
              ),
              Container(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(overflow: TextOverflow.fade, title, textAlign: TextAlign.center, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              )
            ],
          )
          ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget{
  const QuestionWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget>{
  bool isLoading = false;

  static Future<List<Question>> getQuestions() async{
    const url = 'http://45.67.35.180/json/lang1/cat1/questions.json';
    final response = await get(Uri.parse(url));
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    return body.map<Question>(Question.fromJson).toList();
  }

  late PageController _controller;
  int _questionNumber = 1;
  int _score = 0;
  bool _isLocked = false;

  List<Question> questions = [];

  Future loadData() async{

    setState(() {
      isLoading = true;
    });

    //await Future.delayed(Duration(seconds: 2), (){});
    questions = await getQuestions();
    //audios = List.of(allAudios);
    setState(() {
      isLoading = false;
    });
  }


  @override
  void initState(){
    super.initState();
    _controller = PageController(initialPage: 0);
    loadData();
  }

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(height: 32),
          Text('Question $_questionNumber/${questions.length}'),
          const Divider(thickness: 1, color: Colors.grey),
          Expanded(
            child: PageView.builder(
              itemCount: isLoading ? 5 : questions.length,
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                if (isLoading){
                    return CupertinoActivityIndicator();
                } else{
                  final _question = questions[index];
                  return buildQuestion(_question);
                }
              },
            )
          ),
          _isLocked ? buildElevatedButton() : const SizedBox.shrink(),
          const SizedBox(height: 20),
        ]
      ),
    );
  }

  Column buildQuestion(Question question){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 32),
        Text(
          question.text,
          style: const TextStyle(fontSize: 25),
        ),
        SizedBox(height: 32),
        Expanded(
          child: OptionsWidget(
            question: question,
            onClickedOption: (option){
              if (question.isLocked){
                return;
              } else{
                setState(() {
                  question.isLocked = true;
                  question.selectedOption = option;
                });
                _isLocked = question.isLocked;
                if(question.selectedOption!.isCorrect){
                  _score++;
                }
              }
            },
          )
        )
      ],
    );
  }

  ElevatedButton buildElevatedButton(){
    return ElevatedButton(
      onPressed: (){
        if(_questionNumber < questions.length){
          _controller.nextPage(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInExpo
          );
          setState(() {
            _questionNumber++;
            _isLocked = false;
          });
        } else {
          Navigator.pushReplacement(
            context, 
            MaterialPageRoute(builder: (context) => ResultPage(score: _score, questions: questions,),
            )
          );
        }
      }, 
      child: Text(
        _questionNumber < questions.length ? 'Next Page' : 'See the result'),
      );
  }
}

class OptionsWidget extends StatelessWidget{
  final Question question;
  final ValueChanged<Option> onClickedOption;

  const OptionsWidget({
    Key? key,
    required this.question,
    required this.onClickedOption
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: Column(
      children: question.options
      .map((option) => buildOption(context, option))
      .toList(),
    )
  );

  Widget buildOption(BuildContext context, Option option){
    final color = getColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        height: 50,
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.text,
              style: const TextStyle(fontSize: 20),
            ),
            getIconForOption(option, question),
          ],
        ),
      ),
    );
  }

  Color getColorForOption(Option option, Question question){
    final isSelected = option == question.selectedOption;
    if(question.isLocked){
      if(isSelected){
        return option.isCorrect ? Colors.green : Colors.red;
      } else if(option.isCorrect){
        return Colors.green;
      }
    }

    return Colors.grey.shade300;
  }

  Widget getIconForOption(Option option, Question question){
    final isSelected = option == question.selectedOption;
    if(question.isLocked){
      if(isSelected){
        return option.isCorrect ? const Icon(Icons.check_circle, color: Colors.green)
        : const Icon(Icons.cancel, color: Colors.red);
      } else if(option.isCorrect){
        return const Icon(Icons.check_circle, color: Colors.green);
      }
    }

    return const SizedBox.shrink();
  }
}

class ResultPage extends StatelessWidget{
  const ResultPage({Key? key, required this.score, required this.questions}) : super(key: key);

  final int score;
  final List<Question> questions;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:
        Center(
          child: Text('You got $score/${questions.length}')
        )
    );
  }
}

class ShimmerWidget extends StatelessWidget{
  final double width;
  final double height;
  final ShapeBorder shapeBorder; 

  const ShimmerWidget.rectangular({
    this.width = double.infinity,
    required this.height,
  }) : this.shapeBorder = const RoundedRectangleBorder();

  const ShimmerWidget.circular({
    required this.width,
    required this.height,
    this.shapeBorder = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context){
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[300]!,
      period: Duration(seconds: 1),
      child: Container(
        width: width,
        height: height,
        decoration: ShapeDecoration(
          color: Colors.grey[400],
          shape: shapeBorder
        ),
        
      ),
    );
  }
}