import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ath_app/common/http/api/api.dart';
import 'package:ath_app/common/http/httpUtils.dart';
import 'package:ath_app/common/http/response/respObj.dart';
import 'package:ath_app/common/ShareDataWidget.dart';
import 'package:ath_app/common/messageAlter.dart';
import 'package:ath_app/common/model/userInfo.dart';
import 'package:ath_app/common/utils/str_util.dart';
import 'package:ath_app/common/verifyCodeBtn.dart';

class EditNewPhonePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:new AppBar(),
      body: new Center(
        child: new _CreatePage(),
      ),
    );
  }
}
class _CreatePage extends StatefulWidget {
  @override
  createState() => new _CreateEditPage();
  //这里提供了一个static方法，是为了外面好获取
}
class _CreateEditPage extends State<_CreatePage> {
  TextEditingController _selectionController = new TextEditingController();
  //static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  FocusScopeNode focusScopeNode;
  String _phoneNum="";
  String _verifyCode="";
  String _errorPhone="";
  String _errorVerCode="";
  @override
  void initState() {
    super.initState();
    //_selectionController.text=_phoneNum;
  }
  @override
  Widget build(BuildContext context) {
    return new ShareDataWidget(
      data: _phoneNum,
      child: new Scaffold(
       // key:_globalKey ,
        body: Form(
          child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildTitle(),
                buildTitleLine(),
                SizedBox(height: 70.0),
                buildPhoneTextField(context),
                //SizedBox(height: 30.0),
                buildVerifyCodeTextField(context),
                //buildPhoneTextField(context),
                buildRegisterBtn(context),
              ]
          )
        )
      ),
    );
  }
  Padding buildTitle() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        '手机号修改',
        style: TextStyle(fontSize: 42.0),
      ),
    );
  }
  Widget buildPhoneTextField(BuildContext context) {
    var node = new FocusNode();
    return new Padding(
     padding: const EdgeInsets.only(top: 20),
      child: new TextField(
        //autofocus: true,
        focusNode: focusNode1,//关联focusNode1
       // controller: _selectionController,
        onChanged: (str) {
          setState(() {
            if(_errorPhone.isNotEmpty){
              _errorPhone="";
            }
            _phoneNum = str;
          });
        },
        decoration: new InputDecoration(
          icon: Icon(Icons.phone),
          hintText: '请输入新手机号',
          errorText: '$_errorPhone'.isEmpty?null:'$_errorPhone',
        ),
      //  controller: TextEditingController(text: '$_phoneNum'),
        maxLines: 1,
        maxLength: 11,
        //键盘展示为号码
        keyboardType: TextInputType.phone,
        //只能输入数字
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly,
        ],
        onSubmitted: (text) {
          FocusScope.of(context).reparentIfNeeded(node);
        },
      ),
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
  Widget buildVerifyCodeTextField(BuildContext context) {
    var node = new FocusNode();
    Widget verifyCodeEdit = new TextField(
      focusNode: focusNode2,//关联focusNode2
      onChanged: (str) {
        setState(() {
          if(_errorVerCode.isNotEmpty){
            _errorVerCode="";
          }
          _verifyCode = str;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.confirmation_number),
        hintText: '请输入短信验证码',
        errorText: '$_errorVerCode'.isEmpty?null:'$_errorVerCode',
      ),
      maxLines: 1,
      maxLength: 6,
      //键盘展示为数字
      keyboardType: TextInputType.number,
      //只能输入数字
      inputFormatters: <TextInputFormatter>[
        WhitelistingTextInputFormatter.digitsOnly,
      ],
      onSubmitted: (text) {
        FocusScope.of(context).reparentIfNeeded(node);
      },
    );

    return new Padding(
      padding: const EdgeInsets.only( top: 10.0),
      child: new Stack(
        children: <Widget>[
          verifyCodeEdit,
          new Align(
            alignment: Alignment.bottomRight,
            child: new CreateVerifyCodeBtn(),
          ),
        ],
      ),
    );
  }
  Padding buildRegisterBtn(context) {
    return new Padding(
      padding: const EdgeInsets.only(left: 40.0, right: 40.0, top: 20.0),
      child: new RaisedButton(
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed:(_phoneNum.isEmpty || _verifyCode.isEmpty) ? null : () {
          register();
        },
        child: new Text(
          "确认",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
  void register(){
    FocusScope.of(context).reparentIfNeeded(FocusNode());
    if(null == focusScopeNode){
      focusScopeNode = FocusScope.of(context);
    }
    if (!StringUtil.isPhoneNum(_phoneNum)) {
      _errorPhone ="请输入正确的手机号";
      focusScopeNode.requestFocus(focusNode1);
      return;
    }else{
      _errorPhone="";
    }
    if(_verifyCode.isEmpty){
      _errorVerCode ="请输入验证码";
      focusScopeNode.requestFocus(focusNode2);
      return;
    }else{
      _errorVerCode="";
      _errorVerCode="";
    }
    UserInfo userInfo = new UserInfo.empty();
    userInfo.id = LoginInfo.id;
    userInfo.userPhone=_phoneNum;
    print('phoneNum:$_phoneNum');
    HttpUtils.post(Api.SET_PHONE_NUM,success,context,params: userInfo.toJson(),errorCallBack: fail);
  }
  void success(RespObj data){
    Alter.show(context,"修改成功");
    LoginInfo.goHome = false;
    Navigator.of(context).pop();
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
}

