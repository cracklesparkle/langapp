import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
  final String imageAsset;

  const ImageCard({
    Key? key,
    required this.title,
    required this.color,
    required this.imageAsset,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    
    return SizedBox(
      height: 180,
      width: 180,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shadowColor: CupertinoColors.inactiveGray,
        elevation: 8,
        color: Color.fromRGBO(110, 110, 110, 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(imageAsset, height: 120, fit: BoxFit.cover),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(2),
              child: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            )
          ],
        )
        ),
    );
  }
}