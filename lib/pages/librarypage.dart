import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/pages/audiolistpage.dart';
import 'package:langapp/pages/learnpage.dart';
import 'package:langapp/pages/videolistpage.dart';
import 'package:langapp/services/preferencesservice.dart';
import 'package:provider/provider.dart';

import '../helpers/appcolors.dart';

class LibraryPage extends StatelessWidget{
  final Color color;
  final int language;

  const LibraryPage({
    Key? key,
    required this.color,
    required this.language,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferencesService prefService = Provider.of<PreferencesService>(context, listen: true);

    return CupertinoPageScaffold(
    backgroundColor: color,
    navigationBar: CupertinoNavigationBar(
      middle: Text('bottom-navbar-item-2'.tr()),
      trailing: TopNavBarButton()
    ),
    child: SafeArea(
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                      crossAxisCount: 2,
                      children: [
                      ],
                    ),
            ),
          ]
        ),
      )
    ),
  );
  }
}