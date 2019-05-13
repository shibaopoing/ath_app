import 'package:ath_app/common/separator.dart';
import 'package:ath_app/common/text_style.dart';
import 'package:flutter/material.dart';
class ListTitleCard extends StatelessWidget {
  final List<String> widgets;
  final String title;
  final double barHeight = 30.0;
  final double listWith ;
  final double listHeight;
  ListTitleCard(this.title,this.widgets,this.listWith,this.listHeight);
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin:  new EdgeInsets.only(top:10),
      height: 100,
      color: Style.cardColor,
      child: new Column(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Padding(
                padding: EdgeInsets.only(left: 15),
                child:new Text(title,
                  style: Style.commonTextStyle,
                ),
              ),
              new Icon(Icons.keyboard_arrow_right,color: Style.iconColor,),
            ],
          ),
         // new Separator(),
          new Container(
            margin: EdgeInsets.fromLTRB(6, 0, 6, 0),
            height: 65,
            child: new ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount:widgets==null?0:widgets.length,
              itemBuilder: (BuildContext context, int index){
                return _getData(context, index);
              }
            ),
          )
        ],
      ),
    );
  }
  Widget  _getData(BuildContext context, int position){
    if(widgets!=null){
      return GestureDetector(
        onTap: () {
          print(widgets[position]);
        },
        child:
        Center(
            child: new Container(
                width: listWith,
                height: listHeight,
                decoration: BoxDecoration(
                  color: Style.iconColor,
                ),
                margin: EdgeInsets.all(5),
                //padding: EdgeInsets.only(top: 2.0),
                child: Center(child: new Text(widgets[position])))),
      );
    }else{
      return null;
    }
  }
}
