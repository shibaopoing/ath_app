import 'package:ath_app/common/model/logininfo.dart';
import 'package:ath_app/common/utils/NavigatorRouterUtils.dart';
import 'package:ath_app/page/passwordEdit_page.dart';
import 'package:ath_app/page/phoneNum_page.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(
          '账户与安全',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: new Container(
          child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              //padding: EdgeInsets.symmetric(horizontal: 22.0),
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.account_circle,color: Colors.blue,),
                  title: const Text('账户'),
                  subtitle: Text(LoginInfo.userCode),
                  dense: true,
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                  color: const Color(0xffebebeb),
                ),
                ListTile(
                  leading: const Icon(Icons.phone_locked,color: Colors.blue),
                  title: const Text('手机号'),
                  subtitle: Text(LoginInfo.userPhone),
                  dense: true,
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    NavigatorRouterUtils.pushToPage(context, PhoneNumPage());
                  },
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                  color: const Color(0xffebebeb),
                ),
                ListTile(
                  leading: const Icon(Icons.lock_outline,color: Colors.blue),
                  title: const Text('密码'),
                  trailing: new Icon(Icons.keyboard_arrow_right),
                  onTap: (){
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                          builder: (context){
                            return PasswordEdit();
                          },
                        )
                    );
                  },
                ),
                new Container(
                  margin: new EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
                  height: 1.0,
                  color: const Color(0xffebebeb),
                ),
              ]
          )
      ),
    );
  }

}