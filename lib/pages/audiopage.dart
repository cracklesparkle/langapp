import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';

import '../helpers/customfunctions.dart';

class AudioPage extends StatefulWidget{
  final String url;
  final String thumbnailUrl;
  final String title;
  final String subtitle;
  final String description;
  const AudioPage({
    Key? key, 
    required this.url,
    required this.thumbnailUrl,
    required this.title,
    required this.subtitle,
    required this.description
  }) : super(key: key);

  @override
  _AudioPageState createState() => _AudioPageState();
}

class _AudioPageState extends State<AudioPage>{
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState(){
    super.initState();

    setAudio();
    ///Listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) { 
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    ///Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
     });

     ///Listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
     });



     @override
     void dispose(){
      audioPlayer.dispose();

      super.dispose();
     }
  }

  Future setAudio() async{
    ///Repeat song when completed
    audioPlayer.setReleaseMode(ReleaseMode.loop);

    ///Load audio from URL
    await audioPlayer.setSourceUrl(widget.url);
    ///Load audio from File
    //await audioPlayer.setSource(AssetSource(path));
    }

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(widget.title),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: PageView(
          controller: controller,
          children: [
            CupertinoScrollbar(
              child: Column(
                children: [
                  SizedBox(height: 32,),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: widget.thumbnailUrl == '' ? 
                      SizedBox(
                        width: 300,
                        height: 300,
                        child: Container(
                          child: Icon(CupertinoIcons.headphones, size: 100,),
                          color: CupertinoColors.systemGrey3,
                        ),
                      )
                    : CachedNetworkImage(
                      width: 300,
                      height: 300,
                      placeholder: (context, url){
                        return ShimmerWidget.circular(
                          width: 64, 
                          height: 64,
                          shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        );
                      },
                      imageUrl: widget.thumbnailUrl,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: CupertinoTheme.of(context).textTheme.textStyle.color
                    ),
                    //style: CupertinoTheme.of(context).textTheme.textStyle
                  ),
                  const SizedBox(height: 4),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 20, color: CupertinoTheme.of(context).textTheme.textStyle.color),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: Slider(
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);
                                
                        ///Optional: Play audio if was paused
                        await audioPlayer.resume();
                      },
                                
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(formatTime(position), style: TextStyle(color: CupertinoTheme.of(context).textTheme.textStyle.color),),
                        Text(formatTime(duration), style: TextStyle(color: CupertinoTheme.of(context).textTheme.textStyle.color)),
                      ],
                    ),
                  ),
                  CircleAvatar(
                    radius: 35,
                    child: CupertinoButton(
                      child: isPlaying ? Icon(CupertinoIcons.pause_fill, color: CupertinoColors.white) : Icon(CupertinoIcons.play_fill, color: CupertinoColors.white),
                      onPressed: () async {
                        if (isPlaying){
                          await audioPlayer.pause();
                        } else {
                          audioPlayer.resume();
                        }
                      },
                    ),
                  )
                ],
              )
            ),
            CupertinoScrollbar(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: CupertinoTheme.of(context).textTheme.textStyle.color),
                  ),
                  Text(
                    widget.subtitle,
                    style: TextStyle(fontSize: 18, color: CupertinoTheme.of(context).textTheme.textStyle.color),
                  ),
                  SizedBox(height: 8,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.description,
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: CupertinoTheme.of(context).textTheme.textStyle.color),
                    )
                  )
                ],
              )
            ),
          ]
        ),
        ),
      );
  }

}