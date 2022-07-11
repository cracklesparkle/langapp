import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/pages/mainpage.dart';
import 'package:langapp/pages/mappage.dart';

import '../helpers/customwidgets.dart';

class WelcomePage extends StatelessWidget{
  const WelcomePage({Key? key}) : super(key: key);

  // This shows a CupertinoModalPopup which hosts a CupertinoActionSheet.
  void _showActionSheet(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: Text('welcome-page-button-choose-language-popup-title'.tr()),
        message: Text('welcome-page-button-choose-language-popup-descr'.tr()),
        actions: <CupertinoActionSheetAction>[
          CupertinoActionSheetAction(
            onPressed: () {
              //Navigator.pop(context);
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MainPage(language: 1)
                  )
                );
            },
            child: Text('lang1-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MainPage(language: 2)
                  )
                );
            },
            child: Text('lang2-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MainPage(language: 3)
                  )
                );
            },
            child: Text('lang3-name'.tr()),
          ),
          CupertinoActionSheetAction(
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => MainPage(language: 4)
                  )
                );
            },
            child: Text('lang4-name'.tr()),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
      child: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0,
                child: FlutterLogo(),
              )
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Opacity(
                          opacity: 1,
                          child: Image.asset('assets/images/welcomePage/welcomePageBg.png'),
                        )
                      ),
                      Center(
                        heightFactor: 2,
                        child: ClipOval(
                          child: Container(
                            width: 180,
                            height: 180,
                            //color: Color(0xFF80C038),
                            alignment: Alignment.center,
                            child: Image.asset('assets/images/welcomePage/welcomePageLogo.png'),
                          )
                        )
                      ),
                    ]
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Column(
                      children: [
                        Text('welcome-app-title'.tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            inherit: true,
                            color: Colors.black,
                            fontSize: 32,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        SizedBox(height: 40),
                        Text('welcome-app-description'.tr(),
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            inherit: true,
                            color: Colors.black,
                            fontSize: 18,
                          )
                        ),
                        SizedBox(height: 50),
                        // Padding(
                        //   padding: const EdgeInsets.all(20),
                        //   child: 
                        // ),
                        CButton(
                            color: CupertinoColors.activeBlue,
                            text: 'welcome-page-button-choose-language'.tr(), 
                            // onPressedfunction: (){
                            //   Navigator.push(context, CupertinoPageRoute(
                            //     builder: (context) => MainPage()
                            //   ));
                            // },
                            onPressedfunction: (){_showActionSheet(context);},
                        ),
                      ]
                    ),
                  ),
                ],
              )
            )
          ],
        )
      )
    );
  }
}