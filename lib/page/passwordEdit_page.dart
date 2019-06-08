/*
 * Created by 李卓原 on 2018/10/13.
 * email: zhuoyuan93@gmail.com
 * 写一个贼特么好看的登录页面
 */
import 'dart:convert' show json;
import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/page/login_page.dart';
import 'package:ath_app/page_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/httpUtils.dart';
import 'package:ath_app/common/http/response/respObj.dart';
import 'package:ath_app/common/messageAlter.dart';
import 'package:ath_app/common/messageDialog.dart';
import 'package:ath_app/common/model/userInfo.dart';
import 'package:ath_app/common/utils/str_util.dart';
import 'package:ath_app/page/register_page.dart';
class PasswordEdit extends StatefulWidget {
  @override
  _PasswordEdit createState() => _PasswordEdit();
}

class _PasswordEdit extends State<PasswordEdit> {
  final _formKey = GlobalKey<FormState>();
  static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  String _oldPassword;
  String _newPassword;
  String _newPassword1;
  bool _isObscure = true;
  Color _eyeColor;
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
                buildOldPasswordTextField(context),
                SizedBox(height: 20.0),
                buildNewPasswordTextField(context),
                SizedBox(height: 20.0),
                buildPasswordTextField(context),
                SizedBox(height: 60.0),
                buildLoginButton(context),
              ],
            )));

  }

  Align buildLoginButton(BuildContext context) {
    return Align(
      child: SizedBox(
        height: 45.0,
        width: 270.0,
        child: RaisedButton(
          child: Text(
            '确认修改',
            style: Theme.of(context).primaryTextTheme.headline,
          ),
          color: Colors.black,
          onPressed: () {
            if (_formKey.currentState.validate()) {
              ///只有输入的内容符合要求通过才会到达此处
              _formKey.currentState.save();
              if (_newPassword1 != _newPassword) {
                  Alter.show(context, "2次输入的新密码不一致");
              }else{
                UserInfo userInfo = new UserInfo.empty();
                userInfo.id = LoginInfo.id;
                userInfo.userPwd = '$_oldPassword';
                print('assword:$_oldPassword');
                // json.
                HttpUtils.post(Api.CHECK_PASSWORD, checkSuccess, context,
                    params: json.decode(json.encode(userInfo)),
                    errorCallBack: fail);
              }
            }
          },
          shape: StadiumBorder(side: BorderSide()),
        ),
      ),
    );
  }
  void checkSuccess(RespObj data){
    UserInfo userInfo = new UserInfo.empty();
    userInfo.id = LoginInfo.id;
    userInfo.userPwd = '$_newPassword';
    print('assword:$_oldPassword');
    // json.
    HttpUtils.post(Api.SET_PASSWORD, success, context,
        params: json.decode(json.encode(userInfo)),
        errorCallBack: fail);
  }
  void success(RespObj data){
    LoginInfo.goHome = false;
    Navigator.of(context).pop();
    Navigator.of(context).push(
        new MaterialPageRoute(
          builder: (context){
            return LoginPage();
          },
        )
    );
  }
  void fail(RespObj data){
    Alter.show(context, data.message);
  }
  void onCloseEvent(){
    print("onCloseEvent");
  }
  TextFormField buildOldPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _oldPassword = value,
      obscureText: false,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入原密码';
        }
      },
      decoration: InputDecoration(
          labelText: '原密码'),
    );
  }
  TextFormField buildNewPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _newPassword = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请输入新密码';
        }
      },
      decoration: InputDecoration(
          labelText: '新密码',
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
  TextFormField buildPasswordTextField(BuildContext context) {
    return TextFormField(
      onSaved: (String value) => _newPassword1 = value,
      obscureText: _isObscure,
      validator: (String value) {
        if (value.isEmpty) {
          return '请确认新密码';
        }
      },
      decoration: InputDecoration(
          labelText: '确认新密码',
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

        '密码修改',

        style: TextStyle(fontSize: 42.0),

      ),

    );

  }

}