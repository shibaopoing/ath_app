import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ath_app/page/login_page.dart';
class MyPage extends StatefulWidget{
  MyPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  State createState() {
    return new _MyPageState(title:title);
  }
}
class _MyPageState extends State<MyPage>{
  _MyPageState({Key key, this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        context: context,
        // DrawerHeader consumes top MediaQuery padding.
        removeTop: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              new Container(
                padding:const EdgeInsets.only(top: 50.0),
                child: Row(
                  children: <Widget>[
                    new GestureDetector(
                        onTap: () {
                          _pushLogin();
                        },
                      child:new Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: ClipOval(
                          child:Image.asset("pic/images/avatar.png", width: 80,),
                        ),
                      )
                    ),
                    new Expanded(
                      child: GestureDetector(
                          onTap: () {
                            print("姓名、电话");
                          },
                        child: new Container(
                          child: new Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Text(
                                'yuko',
                                style: new TextStyle(
                                    color: const Color(0xff353535), fontSize: 16.0),
                              ),
                              Row(
                                children: <Widget>[
                                  new Text('微信号:yukuoyuan',
                                      style: new TextStyle(
                                          color: const Color(0xffaaaaaa), fontSize: 14.0
                                      )
                                  ),
                                  new Container(
                                      child: new Icon(Icons.keyboard_arrow_right, color: Color(0xFF777777)),
                                      margin: new EdgeInsets.only(left: MediaQuery.of(context).size.width/ 2 - 50.0)
                                  )
                                ],
                              ),
                            ],
                          )
                        )
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 20.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add account'),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                       height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('Manage accounts'),
                    ),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
  void _pushLogin() {
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            return LoginPage();
          },
        )
    );
  }
}