/*
 * Created by 李卓原 on 2018/10/13.
 * email: zhuoyuan93@gmail.com
 * 写一个贼特么好看的登录页面
 */
import 'dart:convert' show json;
import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/page_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:groovin_material_icons/groovin_material_icons.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/httpUtils.dart';
import 'package:ath_app/common/http/response/respObj.dart';
import 'package:ath_app/common/messageAlter.dart';
import 'package:ath_app/common/messageDialog.dart';
import 'package:ath_app/common/model/userInfo.dart';
import 'package:ath_app/common/utils/str_util.dart';
import 'package:ath_app/page/register_page.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  String _phoneNum, _password;
  bool _isObscure = true;
  Color _eyeColor;
  List _loginMethod = [
    {
      "title": "facebook",
      "icon": GroovinMaterialIcons.facebook,
    },
    {
      "title": "google",
      "icon": GroovinMaterialIcons.google,
    },
    {
      "title": "twitter",
      "icon": GroovinMaterialIcons.twitter,
    },
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        key: _globalKey ,
        body: Form(

            key: _formKey,

            child: ListView(

              padding: EdgeInsets.symmetric(horizontal: 22.0),

              children: <Widget>[

                SizedBox(

                  height: kToolbarHeight,

                ),

                buildTitle(),

                buildTitleLine(),

                SizedBox(height: 70.0),

                buildPhoneTextField(),

                SizedBox(height: 30.0),

                buildPasswordTextField(context),

                buildForgetPasswordText(context),

                SizedBox(height: 60.0),

                buildLoginButton(context),

                SizedBox(height: 30.0),

                buildOtherLoginText(),

                buildOtherMethod(context),

                buildRegisterText(context),

              ],

            )));

  }



  Align buildRegisterText(BuildContext context) {

    return Align(

      alignment: Alignment.center,

      child: Padding(

        padding: EdgeInsets.only(top: 10.0),

        child: Row(

          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[

            Text('没有账号？'),

            GestureDetector(

              child: Text(

                '点击注册',

                style: TextStyle(color: Colors.green),

              ),
              onTap: () {
                //TODO 跳转到注册页面
                Navigator.of(context).push(
                    new MaterialPageRoute(
                      builder: (context){
                        return RegisterPage("");
                      },
                    )
                );
              },

            ),

          ],

        ),

      ),

    );

  }



  ButtonBar buildOtherMethod(BuildContext context) {

    return ButtonBar(

      alignment: MainAxisAlignment.center,

      children: _loginMethod

          .map((item) => Builder(

        builder: (context) {

          return IconButton(

              icon: Icon(item['icon'],

                  color: Theme.of(context).iconTheme.color),

              onPressed: () {

                //TODO : 第三方登录方法

                Scaffold.of(context).showSnackBar(new SnackBar(

                  content: new Text("${item['title']}登录"),

                  action: new SnackBarAction(

                    label: "取消",

                    onPressed: () {},

                  ),

                ));

              });

        },

      ))

          .toList(),

    );

  }



  Align buildOtherLoginText() {

    return Align(

        alignment: Alignment.center,

        child: Text(

          '其他账号登录',

          style: TextStyle(color: Colors.grey, fontSize: 14.0),

        ));

  }
  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            'Login',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              UserInfo userInfo = new UserInfo.empty();
              userInfo.userPhone='$_phoneNum';
              userInfo.userPwd='$_password';
              print('email:$_phoneNum , assword:$_password');
             // json.
              HttpUtils.post(Api.USER_LOGIN,ssucce,context,params: json.decode(json.encode(userInfo)),errorCallBack: fail2);
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }
  _goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.HOME_PAGE, (Route<dynamic> route) => false);
  }
  void ssucce(RespObj data){
    UserInfo user = UserInfo.fromJson(data.data);
   // Navigator.of(context).pop();
    LoginInfo.id = user.id;
    LoginInfo.userName = user.userName;
    LoginInfo.userCode = user.userCode;
    LoginInfo.faceImage = user.faceImage;
    LoginInfo.userEmail = user.userEmail;
    LoginInfo.userPhone = user.userPhone;
    LoginInfo.faceImageBig = user.faceImageBig;
    LoginInfo.isLogin=true;
    LoginInfo.loginTime = new DateTime.now();
    _goHomePage();
  }
  void fail2(RespObj data){
    if(data.code=="U001"){
      showDialog<Null>(
          context: context, //BuildContext对象
          barrierDismissible: false,
          builder: (BuildContext context) {
            return new MessageDialog(
              title: "登录失败",
              message: data.message,
              negativeText: "取消",
              positiveText: "注册",
              onPositivePressEvent:_onPositivePressEvent,
              onCloseEvent: onCloseEvent,
            );
          });
    }else{
      Alter.show(context, data.message);
    }
  }
  void onCloseEvent(){
    print("onCloseEvent");
  }
  void _onPositivePressEvent(){
    Navigator.of(_globalKey.currentContext).push(
        new MaterialPageRoute(
          builder: (context){
            return RegisterPage('$_phoneNum');
          },
        )
    );
  }
  Padding buildForgetPasswordText(BuildContext context) {

    return Padding(

      padding: const EdgeInsets.only(top: 8.0),

      child: Align(

        alignment: Alignment.centerRight,

        child: FlatButton(

          child: Text(

            '忘记密码？',

            style: TextStyle(fontSize: 14.0, color: Colors.grey),

          ),

          onPressed: () {

            Navigator.pop(context);

          },

        ),

      ),

    );

  }



  TextFormField buildPasswordTextField(BuildContext context) {

    return TextFormField(

      onSaved: (String value) => _password = value,

      obscureText: _isObscure,

      validator: (String value) {

        if (value.isEmpty) {

          return '请输入密码';

        }

      },

      decoration: InputDecoration(

          labelText: '密码',

          suffixIcon: IconButton(

              icon: Icon(

                Icons.remove_red_eye,

                color: _eyeColor,

              ),

              onPressed: () {

                setState(() {

                  _isObscure = !_isObscure;

                  _eyeColor = _isObscure

                      ? Colors.grey

                      : Theme.of(context).iconTheme.color;

                });

              })),

    );

  }



  TextFormField buildPhoneTextField() {
    var node = new FocusNode();
    return TextFormField(
      maxLines: 1,
      maxLength: 11,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        labelText: '手机号',
      ),
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onFieldSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
      },
      validator: (String value) {
        if (!StringUtil.isPhoneNum(value)) {
          return '请输入正确的手机号';
        }
      },
      onSaved: (String value) => _phoneNum = value,
    );
  }



  Padding buildTitleLine() {

    return Padding(

      padding: EdgeInsets.only(left: 12.0, top: 4.0),

      child: Align(

        alignment: Alignment.bottomLeft,

        child: Container(

          color: Colors.black,

          width: 40.0,

          height: 2.0,

        ),

      ),

    );

  }



  Padding buildTitle() {

    return Padding(

      padding: EdgeInsets.all(8.0),

      child: Text(

        'Login',

        style: TextStyle(fontSize: 42.0),

      ),

    );

  }

}