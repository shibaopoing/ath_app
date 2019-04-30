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
clipBehavior: Clip.hardEdge,
                          child:LoginInfo.faceImage != null ? Image.network(Api.ImageUrl+LoginInfo.faceImage,width: 80,fit: BoxFit.cover,) : Image.asset("pic/images/avatar.png", width: 80,fit: BoxFit.cover),
                        ),
                      )
                    ),
                    new Expanded(
                      child: GestureDetector(
                          onTap: () {
                            print("姓名、电话");
                          },
                        child: new Container(
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            child: new ListTile(
                              contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
                              title: new Text(
                                LoginInfo.userName!= null?LoginInfo.userName:"未登录",
                                style: new TextStyle(
                                    color: const Color(0xff353535), fontSize: 20.0,fontWeight: FontWeight.bold),
                              ),

                              subtitle: new Text(LoginInfo.userCode!= null?LoginInfo.userCode:"",
                                  style: new TextStyle(
                                      color: const Color(0xffaaaaaa), fontSize: 14.0
                                  )
                              ),
                              trailing: new Icon(Icons.keyboard_arrow_right),
                            ),
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
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.assignment_return),
                      title: const Text('退出'),
                      onTap:_pushLogOut,
                    ),
                  ],
                ),
              ),
            ],
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