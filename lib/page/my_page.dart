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
import 'package:ath_app/page/setting_page.dart';
import 'package:ath_app/page/userInfoEdit_page.dart';
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
                          child:LoginInfo.faceImage.isNotEmpty ? Image.network(Api.ImageUrl+LoginInfo.faceImage,width: 64,fit: BoxFit.cover,) : Image.asset("assets/images/avatar.png", width: 64,fit: BoxFit.cover),
                        ),
                      )
                    ),
                    new Container(
                      child: GestureDetector(
                          onTap: () {
                            _showUserInfo();
                          },
                        child: new Container(
                           // margin: const EdgeInsets.only(top:10),
                            child: new Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                              new Text(
                                LoginInfo.userName.isNotEmpty?LoginInfo.userName:"未登录",
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
                    new Container(
                      margin: new EdgeInsets.only(left:MediaQuery.of(context).size.width-320.0),
                      padding: const EdgeInsets.all(4.0),
                      child: new RawChip(
                        onPressed: (){
                          print("签到");
                        },
                    //    elevation: 30,
                        deleteIcon:new Icon(Icons.keyboard_arrow_right,color: Colors.amber,) ,
                        onDeleted: (){
                          print("签到");
                        },
                        deleteButtonTooltipMessage: "签到",
                        avatar: CircleAvatar(
                          backgroundColor: Colors.amberAccent.shade100,
                          maxRadius: 10,
                          child:new Icon(Icons.calendar_today,color: Colors.amber,size: 10,)
                        ),
                        label: Text('去签到',style: TextStyle(fontSize: 10)),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                padding: const EdgeInsets.fromLTRB(100.0,10,0,0),
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
                          child: new Image.asset("assets/images/money-gold.png", width: 20.0, height: 20.0,semanticLabel: "影豆",),
                        ),
                      ],
                    ),
                  )
              ),
              new Container(
                margin: EdgeInsets.only(top: 30),
                color: const Color(0xffebebeb),
                height:40.0,
                padding: const EdgeInsets.fromLTRB(0.0,10.0,0.0,10.0),
                child: new FractionallySizedBox(
                  alignment: Alignment.center,
                  widthFactor: 1,
                  heightFactor: 4,
                  child: new Card(
                    //color: Colors.red,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new GestureDetector(
                          onTap: () {
                            _showFansPage();
                          },
                          child:buildButtonColumn("粉丝数", '1',),
                        ),
                        new GestureDetector(
                          onTap: () {
                            _showConcernPage();
                          },
                          child:buildButtonColumn("关注数", '2',),
                        ),
                        new GestureDetector(
                          onTap: () {
                            _showPublishPage();
                          },
                          child:buildButtonColumn("发布数", '2',),
                        ),
                        new GestureDetector(
                          onTap: () {
                            _showWishPage();
                          },
                          child:buildButtonColumn("心愿单", '3',),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              new Container(
                height: 20.0,
             //   color: const Color(0xffebebeb),
              ),
              //_buildSizedBox(),
              Expanded(
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.payment,color: Colors.blue),
                      title: const Text('支付'),
                    ),
                    new Container(
                      height: 20.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.center_focus_strong,color: Colors.blue),
                      title: const Text('关注'),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                      height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.notifications_active,color: Colors.deepOrangeAccent),
                      title: const Text('通知'),
                    ),
                    new Container(
                      margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                       height: 1.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.help,color: Colors.blue),
                      title: const Text('反馈与帮助'),
                    ),
                    new Container(
                      height: 20.0,
                      color: const Color(0xffebebeb),
                    ),
                    ListTile(
                      leading: const Icon(Icons.settings,color: Colors.blue),
                      title: const Text('设置'),
                      onTap: (){
                        _userSetting();
                      },
                    ),
                    new Container(
                     // padding: EdgeInsets.fromLTRB(0.0, 150.0, 0.0, 1.0),
                      height: double.maxFinite,
                      color: const Color(0xffebebeb),
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
                  _showImageView();
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
  Column buildButtonColumn(String title, String label) {
    Color color = Theme.of(context).primaryColor;
    return new Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
       // new Icon(icon, color: color),
        new Text(title,
          style: new TextStyle(
          fontSize: 15.0,
          fontWeight: FontWeight.bold,
        ),),
        new Container(
          margin: const EdgeInsets.only(top: 8.0),
          child:new Text(
            label,
            style: new TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
  SizedBox _buildSizedBox(){
    return SizedBox(
      height: 100,

      child: NestedScrollView(
          headerSliverBuilder: (BuildContext context,bool innerBoxIsScrolled){
            return<Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,
                  title: Text("1212121",style: TextStyle(color: Colors.white,fontSize: 16.0)),
                  background: Image.network("http://47.102.217.76:88/ath/M00/00/00/rBOlvlzEe5CALrEWAAEr_S0fWk4773.png",fit: BoxFit.cover,),
                ),
              ),
            ];
          },
          body: Center(
            child: Text("向上拉，看效果"),
          )
      ),
    );
  }
  void _showFansPage(){
    print("粉丝数");
  }
  void _showConcernPage(){
    print("关注数");
  }
  void _showPublishPage(){
    print("发布数");
  }
  void _showWishPage(){
    print("愿望单");
  }
  void _showImageView(){
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
  void _showUserInfo() {
    if(LoginInfo.isLogin){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return EditUserInfoPage();
            },
          )
      );
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
  void _userSetting() {
    if(LoginInfo.isLogin){
      Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (context){
              return SettingPage();
            },
          )
      );
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