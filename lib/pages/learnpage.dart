import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';

class LearnPage extends StatelessWidget{
  final Color color;
  final int number;

  const LearnPage({
    Key? key,
    required this.color,
    this.number = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    backgroundColor: color,
    navigationBar: CupertinoNavigationBar(
      middle: Text('category-test'.tr()),
      trailing: Icon(CupertinoIcons.globe),
    ),
    child: SafeArea(
      child: QuestionWidget()
    ),
  );
}