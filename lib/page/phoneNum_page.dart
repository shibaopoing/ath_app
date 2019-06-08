import 'package:ath_app/common/ShareDataWidget.dart';
import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/common/utils/NavigatorRouterUtils.dart';
import 'package:ath_app/common/verifyCodeBtn.dart';
import 'package:ath_app/page/editNewPhone_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PhoneNumPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar:new AppBar(
        title: new Text("更换手机号"),
      ),
      body: new Center(
        child: new _CreatePage(),
      ),
    );
  }
}
class _CreatePage extends StatefulWidget{
  @override
  createState() => new _CreateRegisterPage();

}
class _CreateRegisterPage extends State<_CreatePage> {
 // static GlobalKey<ScaffoldState> _globalKey;
 // final _formKey = GlobalKey<FormState>();
  FocusNode focusNode1 = new FocusNode();
  FocusNode focusNode2 = new FocusNode();
  String _verifyCode="";
  String _errorVerCode1="";
  String _phoneNum="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _phoneNum = LoginInfo.userPhone;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: ListView(
          children: <Widget>[
            _buildOldPhoneFields(context),
          ],
        )
      ),
    );

  }
  Widget _buildOldPhoneFields(BuildContext context){
    return new ShareDataWidget(
      data:  _phoneNum,
      child: Form(
          child: Column(
            // padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                SizedBox(
                  height: kToolbarHeight,
                ),
                buildVerifyCodeTextField(context),
                //修改按钮
                buildEditBtn(context),
              ]
          )
      )
    );
  }
  Widget buildVerifyCodeTextField(BuildContext context) {
    var node = new FocusNode();
    Widget verifyCodeEdit = new TextField(
      focusNode: focusNode1,//关联focusNode1
      onChanged: (str) {
        setState(() {
          if(_errorVerCode1.isNotEmpty){
            _errorVerCode1="";
          }
          _verifyCode = str;
        });
      },
      decoration: InputDecoration(
        icon: Icon(Icons.confirmation_number),
        hintText: '请输入短信验证码',
        errorText: '$_errorVerCode1'.isEmpty?null:'$_errorVerCode1',
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
  Padding buildEditBtn(context) {
    return new Padding(
      padding: const EdgeInsets.only( top: 10.0),
      child: new RaisedButton(
        color: Colors.red,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        onPressed:() {
          //NavigatorRouterUtils.pushToPage(context, EditNewPhonePage());
          Navigator.of(context).push(
              new MaterialPageRoute(
                builder: (context){
                  return EditNewPhonePage();
                },
              )
          );
        },
        child: new Text(
          "修改",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}