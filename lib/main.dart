import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
      //   // This is the theme of your application.
      //   //
      //   // Try running your application with "flutter run". You'll see the
      //   // application has a blue toolbar. Then, without quitting the app, try
      //   // changing the primarySwatch below to Colors.green and then invoke
      //   // "hot reload" (press "r" in the console where you ran "flutter run",
      //   // or simply save your changes to "hot reload" in a Flutter IDE).
      //   // Notice that the counter didn't reset back to zero; the application
      //   // is not restarted.
      //   primarySwatch: Colors.blue,
      // ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      //home: CupertinoTabBarDemo(),
      home: WelcomePage(title: 'Добро пожаловать',)
    );
  }
}

class WelcomePage extends StatelessWidget{
  const WelcomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.3,
                child: FlutterLogo(),
              )
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width: 180,
                      height: 180,
                      color: Color(0xFF80C038),
                      alignment: Alignment.center,
                      child: FlutterLogo(),
                    )
                  ),
                  SizedBox(height: 50),
                  Text('Whatever',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold
                    )
                  ),
                  SizedBox(height: 40),
                  Text('Description and something',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    )
                  ),
                  CupertinoButton.filled(
                    child: Text('Text'), 
                    onPressed: (){},
                    borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                    
                  )

                ],
              )
            )
          ],
        )
      )
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> titles = [];
  List<String> urlImages = [];
  List<String> updExcerpts = [];

  bool _isLoading = false;

  @override
  void initState(){
    super.initState();
    getWebsiteData();
  }  

  Future getWebsiteData() async{
    setState((){_isLoading = true; });

    final titles = ["","",""];

    final updExcerpts = ["","",""];

    final urlImages = ["","",""];

    setState(() {
      this.titles = titles;
      this.urlImages = urlImages;
      this.updExcerpts = updExcerpts;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    return CupertinoPageScaffold(
      child:
      !_isLoading?ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: titles.length, 
      separatorBuilder: (context, index){
        return const SizedBox(height: 10);
      }, 
      itemBuilder: (context, index) {
        final title = titles[index];
        final urlImage = urlImages[index];
        final updExcerpt = updExcerpts[index];

        
        return Material(child: ListTile(
          tileColor: const Color(0xFF111111),
          leading: Image.network(
                'https://pro.multmania.club/$urlImage',
                width: 150,
                height: 60,
                fit: BoxFit.cover,
              ),
          title: Text(title, style: const TextStyle(
            color: Color(0xFFE0AF57),
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w500,
            )
            ,),
          subtitle: Text(updExcerpt, 
                  style: const TextStyle(
                    color: Color(0xFF959595), 
                    fontSize: 12,
                    fontFamily: 'Raleway',
                    fontStyle: FontStyle.italic,
                    ),
                ),
        ));
      }
  ):const Center(child: CupertinoActivityIndicator()));
  }
}

class _TabInfo {
  const _TabInfo(this.title, this.icon, this.activeIcon);

  final String title;
  final IconData icon;
  final IconData activeIcon;
}

class CupertinoTabBarDemo extends StatelessWidget {
  const CupertinoTabBarDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabInfo = [
      const _TabInfo(
        'Главная',
        CupertinoIcons.house,
        CupertinoIcons.house_fill
      ),
      const _TabInfo(
        'Каталог',
        CupertinoIcons.book,
        CupertinoIcons.book_fill,
      ),
      const _TabInfo(
        'Загрузки',
        CupertinoIcons.play_circle,
        CupertinoIcons.play_circle_fill,
      ),
      const _TabInfo(
        'Настройки', 
        CupertinoIcons.gear,
        CupertinoIcons.gear_solid
      )
    ];

    return DefaultTextStyle(
      style: CupertinoTheme.of(context).textTheme.textStyle,
      child: CupertinoTabScaffold(
        restorationId: 'cupertino_tab_scaffold',
        tabBar: CupertinoTabBar(
          items: [
            for (final tabInfo in tabInfo)
              BottomNavigationBarItem(
                label: tabInfo.title,
                icon: Icon(tabInfo.icon),
                activeIcon: Icon(tabInfo.activeIcon)
              ),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            restorationScopeId: 'cupertino_tab_view_$index',
            builder: (context) => _CupertinoDemoTab(
              title: tabInfo[index].title,
              icon: tabInfo[index].icon,
            ),
            defaultTitle: tabInfo[index].title,
          );
        },
      ),
    );
  }
}

class _CupertinoDemoTab extends StatelessWidget {
  const _CupertinoDemoTab({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(),
      backgroundColor: CupertinoColors.systemBackground,
      // child: Center(
      //   child: Icon(
      //     icon,
      //     semanticLabel: title,
      //     size: 100,
      //   ),
      // ),
      child: SafeArea(child: HomePage(title: 'Whatever'))
    );
  }
}


