import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPage extends StatefulWidget{
  final String url;
  final String title;
  final String description;
  const VideoPage({Key? key, required this.url, required this.title, required this.description }) : super(key: key);

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage>{

  late YoutubePlayerController controller;

  @override
  void initState(){
    super.initState();

    //const url = 'https://www.youtube.com/watch?v=dQw4w9WgXcQ';

    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.url)!,
      flags: const YoutubePlayerFlags(
        mute: false,
        loop: false,
        autoPlay: true,
        hideControls: false,
      ),
    )..addListener(() {
      if(mounted){
        setState(){};
      }
    });
  }

  @override
  void deactivate(){
    controller.pause();

    super.deactivate();
  }

  @override
  void dispose(){
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: controller,
        ),
      builder: (context, player){
        return CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('bottom-navbar-item-1'.tr()),
            trailing: TopNavBarButton()
          ),
          child: SafeArea(
            child: CupertinoScrollbar(
              child: ListView(
                padding: const EdgeInsets.all(10),
                children: [
                  player,
                  SizedBox(height: 8),
                  Text(widget.title),
                  SizedBox(height: 8),
                  Text(widget.description)
                  //Text(controller.metadata.duration.inMinutes.toString()),
                  // ElevatedButton(
                  //   onPressed: (){
                  //     const url = 'https://www.youtube.com/watch?v=0_fgxq9xtzI';
                  //     controller.load(YoutubePlayer.convertUrlToId(url)!);
                  //   }, 
                  //   child: const Text('Next video'),
                  // ),

                ]
              ),
            ),
          )
        );
      },
    );
  }

}