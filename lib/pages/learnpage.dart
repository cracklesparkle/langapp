import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';

class LearnPage extends StatelessWidget{
  final int number;

  const LearnPage({
    Key? key,
    this.number = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => CupertinoPageScaffold(
    navigationBar: CupertinoNavigationBar(
      middle: Text('category-test'.tr()),
      //trailing: Icon(CupertinoIcons.globe),
    ),
    child: SafeArea(
      child: QuestionWidget()
    ),
  );
}