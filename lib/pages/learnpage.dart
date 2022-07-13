import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';

class LearnPage extends StatelessWidget{
  final String title;
  final Color color;
  final int number;

  const LearnPage({
    Key? key,
    required this.title,
    required this.color,
    this.number = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    backgroundColor: color,
    navigationBar: CupertinoNavigationBar(
      middle: Text(title),
      trailing: Icon(CupertinoIcons.globe),
    ),
    child: SafeArea(
      child: QuestionWidget()
    ),
  );
}