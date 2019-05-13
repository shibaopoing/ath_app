import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/model/userInfo.dart';
import 'package:ath_app/common/separator.dart';
import 'package:ath_app/common/text_style.dart';
import 'package:ath_app/page/detail_page.dart';
import 'package:flutter/material.dart';
class PlanetSummary extends StatelessWidget {

  final UserInfo userInfo;
  final bool horizontal;

  PlanetSummary(this.userInfo, {this.horizontal = true});

  PlanetSummary.vertical(this.userInfo): horizontal = false;


  @override
  Widget build(BuildContext context) {

    final planetThumbnail = new Container(
      margin: new EdgeInsets.symmetric(
        vertical: 16.0
      ),
      alignment: horizontal ? FractionalOffset.centerLeft : FractionalOffset.center,
      child: new Hero(
          tag: "planet-hero-${userInfo.id}",
          child: ClipOval(
            clipBehavior: Clip.hardEdge,
            child:
            userInfo.faceImage != null ? Image.network(Api.ImageUrl+userInfo.faceImage,width: 92,height: 92,fit: BoxFit.cover,) : Image.asset("assets/images/avatar.png", width: 92,height: 92,fit: BoxFit.cover),
          ),
      ),
    );

    Widget _planetValue({String value, String image}) {
      return new Container(
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Image.asset(image, height: 12.0),
            new Container(width: 8.0),
            new Text(value, style: Style.smallTextStyle),
          ]
        ),
      );
    }


    final planetCardContent = new Container(
      margin: new EdgeInsets.fromLTRB(horizontal ? 76.0 : 16.0, horizontal ? 16.0 : 42.0, 16.0, 16.0),
      constraints: new BoxConstraints.expand(),
      child: new Column(
        crossAxisAlignment: horizontal ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: <Widget>[
          new Container(height: 4.0),
          new Text(userInfo.userName, style: Style.titleTextStyle),
          new Container(
              child: new Center(

              ),
              height: 10.0
          ),
          new Text(userInfo.userCode, style: Style.commonTextStyle),
          new Separator(),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Expanded(
                flex: horizontal ? 1 : 0,
                child: _planetValue(
                  value: "54.6m Km",
                  image: 'assets/images/ic_distance.png')
              ),
              new Container (
                width: 32.0,
              ),
              new Expanded(
                  flex: horizontal ? 1 : 0,
                  child: _planetValue(
                  value: "4.711 m/s",
                  image: 'assets/images/ic_gravity.png')
              )
            ],
          ),
        ],
      ),
    );


    final planetCard = new Container(
      child: planetCardContent,
      height: horizontal ? 124.0 : 154.0,
      margin: horizontal
        ? new EdgeInsets.only(left: 46.0)
        : new EdgeInsets.only(top: 72.0),
      decoration: new BoxDecoration(
        color: new Color(0xFF333366),
        shape: BoxShape.rectangle,
        borderRadius: new BorderRadius.circular(8.0),
        boxShadow: <BoxShadow>[
          new BoxShadow(
            color: Colors.black12,
            blurRadius: 10.0,
            offset: new Offset(0.0, 10.0),
          ),
        ],
      ),
    );


    return new GestureDetector(
      onTap: horizontal
          ? () => Navigator.of(context).push(
            new PageRouteBuilder(
              pageBuilder: (_, __, ___) => new DetailPage(userInfo),
              transitionsBuilder: (context, animation, secondaryAnimation, child) =>
                new FadeTransition(opacity: animation, child: child),
              ) ,
            )
          : null,
      child: new Container(
        margin: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 24.0,
        ),
        child: new Stack(
          children: <Widget>[
            planetCard,
            planetThumbnail,
          ],
        ),
      )
    );
  }
}
