import 'package:ath_app/common/separator.dart';
import 'package:ath_app/common/text_style.dart';
import 'package:ath_app/page/video_page.dart';
import 'package:flutter/material.dart';
class MovieCard extends StatelessWidget {
 // final List<String> widgets;
  double itemHeight =120;
  var no;
  var title;
  var start ;//  //电影标题，星标评分，演员简介Container
  var year ;
  var imgUrl;
  var casts;
  var genres;
  MovieCard(
      this.no,
      this.title,
      this.start,
      this.casts,
      this.year,
      this.genres,
      this.imgUrl
      );
  @override
  Widget build(BuildContext context) {
    double pWith = MediaQuery.of(context).size.width;
    return new SizedBox(
      height: 140.0,  //设置高度
      child: new Card(
        elevation: 15.0,  //设置阴影
        color: Style.iconColor,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14.0))),  //设置圆角
        child: new Row(  // card只能有一个widget，但这个widget内容可以包含其他的widget
          children: [
            //显示影片预览图
            GestureDetector(
              child:showMovieImage(),
              onTap: (){
                Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context){
                        return VideoPage();
                      },
                    )
                );
              },
            ),
            //影片简介区域
            GestureDetector(
              child:getMovieInfoView(pWith,context),
            ),
          ],
        ),
      ),
    );
  }
  showMovieImage(){
    return new Container(
      child: Center(
        child: Icon(
          Icons.play_circle_outline,
          color: Colors.redAccent,
          size: 80,
        ),
      ),
      margin: EdgeInsets.all(5),
      width: 100,
      height: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
              image: NetworkImage(imgUrl),
              fit: BoxFit.cover
          )
      )
    );
  }

  //NO.1 图标
  numberWidget(var no) {
    return Container(
      child: Text(
        'No.$no',
        style: TextStyle(color: Color.fromARGB(255, 133, 66, 0)),
      ),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 201, 129),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
      margin: EdgeInsets.only(left: 12, top:4),
    );
  }
  //电影标题，星标评分，演员简介Container
  getMovieInfoView(double pWith,BuildContext context) {
    //var start = subject['rating']['average'];
    return Container(
      height: itemHeight,
      width: pWith-100-50,
      padding: EdgeInsets.only(left: 10),
     // alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
        //  numberWidget(no + 1),
          getTitleView(),
          DescWidget(casts,genres),
          RatingBar(start),
          buildCommentSection(context),
        ],
      ),
    );
  }
  //分享评论区
  buildCommentSection(BuildContext context){
    return Container(
    //  color: Style.cardColor,
    //  padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.only(top: 2),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildButtonColumn(Icons.call, 'CALL',context),
          buildButtonColumn(Icons.near_me, 'ROUTE',context),
          buildButtonColumn(Icons.share, 'SHARE',context),
          buildButtonColumn(Icons.star, 'SHARE',context),
        ],
      ),
    );
  }
  //圆角图片
  getImage(var imgUrl) {
    return Container(
      decoration: BoxDecoration(
          image:
          DecorationImage(image: NetworkImage(imgUrl), fit: BoxFit.cover),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      margin: EdgeInsets.only(left: 8, top: 3, right: 8, bottom: 3),
      height: itemHeight,
      width: 100.0,
    );
  }

  getStaring(var stars) {
    return Row(
      children: <Widget>[RatingBar(stars), Text('$stars')],
    );
  }
  //肖申克的救赎(1993) View
  getTitleView() {
   // var title = subject['title'];
   // var year = subject['year'];
    return Container(
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Text('($year)',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey))
        ],
      ),
    );
  }
  Column buildButtonColumn(IconData icon, String label,BuildContext context) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        new Icon(icon, color: color,size: 15,),
        new Container(
          //margin: const EdgeInsets.only(top: 2.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 8.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
//类别、演员介绍
class DescWidget extends StatelessWidget {
  var casts;
  var genres;
  DescWidget(this.casts,this.genres);
  @override
  Widget build(BuildContext context) {
   // var casts = subject['casts'];
    var sb = StringBuffer();
  //  var genres = subject['genres'];
    for (var i = 0; i < genres.length; i++) {
      sb.write('${genres[i]}  ');
    }
    sb.write("/ ");
/*    List<String> list = List.generate(
        casts.length, (int index) => casts[index]['name'].toString());

    for (var i = 0; i < list.length; i++) {
      sb.write('${list[i]} ');
    }*/
    return Container(
      child: Text(
        sb.toString(),
        softWrap: true,
        textDirection: TextDirection.ltr,
        style:
        TextStyle(fontSize: 16, color: Color.fromARGB(255, 118, 117, 118)),
      ),
    );
  }
}

class RatingBar extends StatelessWidget {
  double stars;
  RatingBar(this.stars);
  @override
  Widget build(BuildContext context) {
    List<Widget> startList = [];
    //实心星星
    var startNumber = stars ~/ 2;
    //半实心星星
    var startHalf = 0;
    if (stars.toString().contains('.')) {
      int tmp = int.parse((stars.toString().split('.')[1]));
      if (tmp >= 5) {
        startHalf = 1;
      }
    }
    //空心星星
    var startEmpty = 5 - startNumber - startHalf;

    for (var i = 0; i < startNumber; i++) {
      startList.add(Icon(
        Icons.star,
        color: Colors.amberAccent,
        size: 18,
      ));
    }
    if (startHalf > 0) {
      startList.add(Icon(
        Icons.star_half,
        color: Colors.amberAccent,
        size: 18,
      ));
    }
    for (var i = 0; i < startEmpty; i++) {
      startList.add(Icon(
        Icons.star_border,
        color: Colors.grey,
        size: 18,
      ));
    }
    startList.add(Text(
      '$stars',
      style: TextStyle(
        color: Colors.grey,
      ),
    ));
    return Container(
     // alignment: Alignment.bottomCenter,
     // color: Style.cardColor,
      margin: const EdgeInsets.only(top: 30.0),
     // padding: const EdgeInsets.only(left: 10),
      child: Row(
        children: startList,
      ),
    );
  }
}
