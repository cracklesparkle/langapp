import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';

class NewPage extends StatelessWidget{
  final String title;
  final Color color;
  final int number;

  const NewPage({
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
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '$title on $number',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              )
            ),
            const SizedBox(height: 32),
            CButton(
              text: title, 
              color: color, 
              onPressedfunction: () => Navigator.of(context, rootNavigator: true).push(
                CupertinoPageRoute(
                  builder: (context) => NewPage(
                      title: title, 
                      color: color,
                      number: number + 1,
                    )
                  )
                )
              )
          ]
        ),
      )
    ),
  );
}