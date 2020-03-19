import 'package:ath_app/common/chVideo_player.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPage extends StatefulWidget {
  @override
  _VideoPage createState() => _VideoPage();
}
class _VideoPage extends State<VideoPage>  {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('Video Player'),
      ),
      body: ListView(
        children: <Widget>[
         // ChVideoPlayer(videoPlayerController: VideoPlayerController.asset('videos/IntroVideo.mp4',), looping: true,),
          ChVideoPlayer(videoPlayerController: VideoPlayerController.network('http://vt1.doubanio.com/201906172139/5547a0cc0076381a5b6846aa916d3204/view/movie/M/402440546.mp4',),),
         // VideoPlayer(// This URL doesn't exist - will display an errorvideoPlayerController: VideoPlayerController.network('http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/error.mp4',),),
        ],
      ),

    );

  }

}