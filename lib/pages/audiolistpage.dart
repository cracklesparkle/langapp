import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:langapp/data/audios.dart';
import 'package:langapp/data/videos.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/models/videoitem.dart';
import 'package:langapp/pages/audiopage.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';
import 'package:langapp/pages/videopage.dart';

import '../models/audioitem.dart';

class AudioListPage extends StatefulWidget{
  @override
  _AudioListPageState createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage>{
  bool isLoading = false;
  List<AudioItem> audios = [];

  @override
  void initState(){
    super.initState();

    loadData();
  }

  Future loadData() async{

    setState(() {
      isLoading = true;
    });

    //await Future.delayed(Duration(seconds: 2), (){});
  
    audios = List.of(allAudios);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('category-audio'.tr()),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text('category-audio-list-description'.tr()),
              padding: EdgeInsets.all(10),
            ),
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: isLoading ? 5 : audios.length,
                itemBuilder: (context, index){
                  //if (isLoading){
                  //  return buildListShimmer();
                  //}
                  final audio = audios[index];
            
                  return buildAudioItem(audio);
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget buildAudioItem(AudioItem audio){
    return Material(
      child: ListTile(
        // leading: CircleAvatar(
        //   radius: 32,
        //   backgroundImage: NetworkImage(video.thumbnailUrl),
        // ),
        // leading: FadeInImage.assetNetwork(
        //     placeholder: 'assets/images/mapPage/animals.png', 
        //     image: video.thumbnailUrl
        // ),
        onTap: (){
                Navigator.of(context, rootNavigator: true).push(
                  CupertinoPageRoute(
                    builder: (context) => AudioPage(url: audio.url, thumbnailUrl: audio.thumbnailUrl, title: audio.title, subtitle: audio.subtitle, description: audio.description,)
                    ),
                );
              },
        leading: audio.thumbnailUrl == ''
            ? SizedBox(
              width: 64,
              height: 64,
              child: Container(
                child: Icon(CupertinoIcons.headphones),
              ),
            )
            : CachedNetworkImage(
          placeholder: (context, url){
            return ShimmerWidget.circular(
              width: 64, 
              height: 64,
              shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            );
          },
          imageUrl: audio.thumbnailUrl,
        ),
        title: Text(
          audio.title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          audio.subtitle,
          style: TextStyle(fontSize: 14),
          maxLines: 1,
        ),
      ),
    );
  }

  Widget buildListShimmer(){
    return Material(
      child: ListTile(
        leading: ShimmerWidget.circular(
          width: 64, 
          height: 64,
          shapeBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)
          ),
        ),
        title: Align(
          alignment: Alignment.centerLeft,
          child: ShimmerWidget.rectangular(
            height: 16,
            width: MediaQuery.of(context).size.width * 0.3,
          ),
        ),
        subtitle: ShimmerWidget.rectangular(height: 14),
      ),
    );
  }

}