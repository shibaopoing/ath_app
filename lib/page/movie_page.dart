
import 'dart:io';
import 'dart:convert' as Convert;
import 'package:ath_app/common/movieCard.dart';
import 'package:ath_app/common/text_style.dart';
import 'package:ath_app/page/ITabPage/ITab_page.dart';
import 'package:flutter/material.dart';
// ignore: must_be_immutable
class MoviePage extends ITabPage {
  MoviePage(tabName, tabIndex) : super(tabName, tabIndex);
  @override
  State<StatefulWidget> createState() {
    return _MoviePage();
  }
}
class _MoviePage extends State<MoviePage> with AutomaticKeepAliveClientMixin {
  List<MovieCard> _cardWidgets;
  final double barHeight = 30.0;
  var subjects = ["1","2","3","4","5","6","7","8","9","10"];
 // var itemHeight = 150.0;
  requestMovieTop() async {
    var httpClient = new HttpClient();
    //http://api.douban.com/v2/movie/top250?start=25&count=10
    var uri = new Uri.http(
        'api.douban.com', '/v2/movie/top250', {'start': '0', 'count': '150'});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(Convert.utf8.decoder).join();
    Map data = Convert.jsonDecode(responseBody);
    setState(() {
      subjects = data['subjects'];
    });
  }
  @override
  void initState() {
    super.initState();
   // requestMovieTop();
  }
  @override
  Widget build(BuildContext context) {
    if(_cardWidgets==null){
    //  _cardWidgets =  List();
    //  MovieCard card = new MovieCard("电影");
    //  _cardWidgets.add(card);
    }
    return Container(
    //  margin:  new EdgeInsets.only(top:5),
      color: Style.cardColor,
      child: ListView.builder(
        itemCount:10,//subjects.length,
        itemBuilder: (BuildContext context, int index){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              showItemContainerView(subjects[index],index),
            ],
          );
        }
    ),
    );
  }
  showItemContainerView(var subject,int index) {
     int no = index;
     //  //电影标题，星标评分，演员简介Container
     var title = "爱，死亡和机器人";//subject['title'];
     var year = 1994;//subject['year'];
     var start = 9.6;//subject['rating']['average'];
     var imgUrl = "https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2548248276.jpg";//subject['images']['medium'];
     var casts = "11";//subject['casts'];
     var genres = "22";//subject['genres'];
    return new MovieCard(
        no,
        title,
        start,
        casts,
        year,
        genres,
        imgUrl
    );
  }
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}