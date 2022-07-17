import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:langapp/data/videos.dart';
import 'package:langapp/helpers/appcolors.dart';
import 'package:langapp/helpers/customwidgets.dart';
import 'package:langapp/models/videoitem.dart';
import 'package:langapp/pages/newpage.dart';
import 'package:langapp/pages/subjectpage.dart';
import 'package:langapp/pages/videopage.dart';

class VideoListPage extends StatefulWidget{
  @override
  _VideoListPageState createState() => _VideoListPageState();
}

class _VideoListPageState extends State<VideoListPage>{
  bool isLoading = false;
  List<VideoItem> videos = [];

  static Future<List<VideoItem>> getVideos() async{
    const url = 'http://45.67.35.180/json/lang1/cat1/videos.json';
    final response = await get(Uri.parse(url));
    final body = jsonDecode(utf8.decode(response.bodyBytes));
    return body.map<VideoItem>(VideoItem.fromJson).toList();
  }

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

    //videos = List.of(allVideos);
    videos = await getVideos();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('category-video'.tr()),
        trailing: TopNavBarButton()
      ),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              child: Text('category-video-list-description'.tr()),
              padding: EdgeInsets.all(10),
            ),
            Flexible(
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: isLoading ? 5 : videos.length,
                itemBuilder: (context, index){
                  if (isLoading){
                   return buildListShimmer();
                  }
                  else {
                    final video = videos[index];
                    return buildVideoItem(video);
                  }
                  
                },
              ),
            ),
          ],
        ),
      )
    );
  }

  Widget buildVideoItem(VideoItem video){
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
                    builder: (context) => VideoPage(url: video.url, description: video.description, title: video.title,)
                    ),
                );
              },
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            fit: BoxFit.fill,
            width: 64,
            height: 64,
            placeholder: (context, url){
              return ShimmerWidget.circular(
                width: 64, 
                height: 64,
                shapeBorder: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              );
            },
            imageUrl: video.thumbnailUrl,
          ),
        ),
        title: Text(
          video.title,
          style: TextStyle(fontSize: 16),
        ),
        subtitle: Text(
          video.description,
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