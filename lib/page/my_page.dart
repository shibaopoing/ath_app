import 'dart:convert';
import 'dart:io';

import 'package:ath_app/common/PicPreview.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/httpUtils.dart';
import 'package:ath_app/common/http/response/respObj.dart';
import 'package:ath_app/common/messageAlter.dart';
import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/common/model/userInfo.dart';
import 'package:ath_app/common/utils/ImageUtil.dart';
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
  static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Container(
      key: _globalKey,
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
                          clipBehavior: Clip.hardEdge,
                          child:LoginInfo.faceImage != null ? Image.network(Api.ImageUrl+LoginInfo.faceImage,width: 64,fit: BoxFit.cover,) : Image.asset("pic/images/avatar.png", width: 64,fit: BoxFit.cover),
                        ),
                      )
                    ),
                    new Container(
                      child: GestureDetector(
                          onTap: () {
                            print("姓名、电话");
                          },
                        child: new Container(
                           // margin: const EdgeInsets.only(top:10),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              new Text(
                                LoginInfo.userName!= null?LoginInfo.userName:"未登录",
                                style: new TextStyle(
                                    color: const Color(0xff353535), fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),
                              new Container(
                                height: 25,
                                //color: Color(0xff353535),
                                margin: const EdgeInsets.only(top: 0),
                                child: new Row(
                                  children: <Widget>[
                                    new Text(
                                        LoginInfo.userCode!= null?LoginInfo.userCode:"",
                                        style: new TextStyle(
                                            color: const Color(0xffaaaaaa), fontSize: 14.0)
                                    ),
                                  ],
                                ),
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
                margin: EdgeInsets.only(top: 30),
                color: const Color(0xffebebeb),
                height:40.0,
                padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                child: new FractionallySizedBox(
                  alignment: Alignment.bottomCenter,
                  widthFactor: 1,
                  heightFactor: 2.5,
                  child: new Card(
                    //color: Colors.red,
                    child: new Row(
                      children: <Widget>[
                        new Container(
                            margin: new EdgeInsets.only(left: 20),
                            child:new GestureDetector(
                              onTap: (){
                                print("获取影币");
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    '影币:',
                                    style: new TextStyle(
                                        color: const Color(0xff353535),fontStyle: FontStyle.normal),
                                  ),
                                  new Text(
                                    '300',
                                    style: new TextStyle(
                                        color: const Color(0xff353535),fontStyle: FontStyle.normal),
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    child: new Image.asset("pic/images/money-gold.png", width: 20.0, height: 20.0,semanticLabel: "影豆",),
                                  ),
                                ],
                              ),
                            )
                        ),
                        new Container(
                            margin: new EdgeInsets.only(left:MediaQuery.of(context).size.width-200.0),
                             // padding: EdgeInsets.only(right: 20),
                            child:new GestureDetector(
                              onTap: (){
                                print("签到");
                              },
                              child: new Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  new Text(
                                    '签到',
                                    style: new TextStyle(
                                        color: const Color(0xff353535), fontStyle: FontStyle.normal),
                                  ),
                                  new Padding(
                                    padding: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                                    child:new Icon(Icons.calendar_today,color: Colors.amber,size:20 ,),
                                   // child: new Image.asset("pic/images/money-gold.png", width: 24.0, height: 24.0,semanticLabel: "影豆",),
                                  ),
                                ],
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.payment),
                      title: const Text('支付'),
                    ),
                    new Container(
                      height: 20.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.center_focus_strong),
                      title: const Text('关注'),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications_active),
                      title: const Text('通知'),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                       height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.help),
                      title: const Text('反馈与帮助'),
                    ),
                    new Container(
                      height: 20.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings),
                      title: const Text('设置'),
                    ),
                    new Container(
                      height: 20.0,
                      color: const Color(0xffebebeb),
                    ),
                    buildRegisterBtn(context),
                  ],
                ),
              ),
            ],
        ),
      ),
    );
  }
  Padding buildRegisterBtn(context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: new RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed:() {
          _pushLogOut();
        },
        child: new Text(
          "退出",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
  void _modalBottomSheetMenu(){
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context){
          return new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Container(
                padding:const EdgeInsets.only(top: 10.0,bottom: 10.0),
                child: new Text("头像信息",
                  style:new TextStyle(
                      color: const Color(0xff353535), fontSize: 20.0,fontWeight: FontWeight.bold),
                ),
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              new ListTile(
                leading: new Icon(Icons.crop_original),
                title: new Text("查看图片"),
                onTap: () {
                  Navigator.pop(context);
                  _showIamgeView();
                },
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text("拍照"),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.pickerImage().then((imageFile){
                    _cropImage(imageFile);
                  });
                },
              ),
              new Container(
                margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                height: 1.0,
                color: const Color(0xffebebeb),
              ),
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text("从相册中获取",),
                onTap: () async {
                  Navigator.pop(context);
                  ImageUtil.getImageFromMyGallery().then((imageFile){
                    _cropImage(imageFile);
                  });
                },
              ),
            ],
          );
        }

    );
  }
  void _pushLogOut() {
    if(LoginInfo.hasInit){
      setState(() {
        LoginInfo.id = 0;
        LoginInfo.hasInit=false;
        LoginInfo.userName = "未登录";
        LoginInfo.userCode = "";
        LoginInfo.faceImage =null;
        LoginInfo.userEmail = "";
        LoginInfo.userPhone = "";
        LoginInfo.isLogin=false;
        LoginInfo.loginTime = null;
      });
    }
  }
  void _showIamgeView(){
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            return  PicPreview();
          },
        )
    );
  }
  void _pushLogin() {
    if(LoginInfo.isLogin){
      _modalBottomSheetMenu();
    }else{
      Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            return LoginPage();
          },
        )
      );
    }
  }
  Future _cropImage(File imageFile) async {
    var image = await ImageUtil.cropImage(imageFile.path);
    if (image != null) {
      //请求后台保存图片信息
      //先将图片转换为base64字符串
      List<int> byteData = await image.readAsBytes();
      String bs64 = base64Encode(byteData);
      LoginInfo.faceImage = bs64;
      UserInfo userInfo = new UserInfo.empty();
      userInfo.id=LoginInfo.id;
      userInfo.faceImage=LoginInfo.faceImage;
      // json.
      HttpUtils.post(Api.SET_FACE_IMAGE,success,context,params: json.decode(json.encode(userInfo)),errorCallBack: fail);
    }
  }
  success(RespObj data) {
    UserInfo user = UserInfo.fromJson(data.data);
    setState(() {
      LoginInfo.faceImage = user.faceImage;
      LoginInfo.faceImageBig = user.faceImageBig;
    });
  }
  fail(RespObj data) {
    Alter.show(context, data.message);
  }

}