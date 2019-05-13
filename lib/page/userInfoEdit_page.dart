import 'package:ath_app/common/model/logininfo.dart';
import 'package:flutter/material.dart';

class EditUserInfoPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new _EditUserInfoPageState();
  }
}
class _EditUserInfoPageState extends State<EditUserInfoPage> {
  var inputText;
  var sex;
  TextEditingController _selectionController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
          title: new Text(
            '个人信息',
            style: TextStyle(color: Colors.white),
          ),
          actions: <Widget>[
            new Padding(
              padding: new EdgeInsets.fromLTRB(0.0, 15.0, 15.0, 0.0),
              child: new GestureDetector(
                onTap: _saveUserInfo,
                child: new Text(
                  '保存',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            )
          ]),
      body: new Container(
          child: new Form(
            child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 22.0),
                children: <Widget>[
                  new Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: new TextField(
                      enabled: false,
                      controller: TextEditingController(text: LoginInfo.userCode),
                      decoration: InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: "账号",
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: new DropdownButton(
                      isExpanded: true,
                      hint:new Text('性别'),//当没有默认值的时候可以设置的提示
                      value: sex,//下拉菜单选择完之后显示给用户的值
                      onChanged: (T){//下拉菜单item点击之后的回调
                        setState(() {
                          sex=T;
                        });
                      },
                      elevation: 24,//设置阴影的高度
/*                     style: new TextStyle(//设置文本框里面文字的样式
                          color: Colors.red
                      ),*/
                      // isDense: false,//减少按钮的高度。默认情况下，此按钮的高度与其菜单项的高度相同。如果isDense为true，则按钮的高度减少约一半。 这个当按钮嵌入添加的容器中时，非常有用
                  //   iconSize: 50.0,//设置三角标icon的大小
                      items: getSexData(),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: new TextField(
                      controller: TextEditingController(text: LoginInfo.userName),
                      decoration: InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: "昵称",
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: new TextField(
                      controller: TextEditingController(text: LoginInfo.userEmail),
                      decoration: InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: "邮箱",
                      ),
                    ),
                  ),
                  new Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: new TextField(
                      controller: TextEditingController(text: LoginInfo.userEmail),
                      decoration: InputDecoration(
                        //icon: Icon(Icons.person),
                        labelText: "地区",
                      ),
                    ),
                  ),
                ]
            )
        )
      ),
    );
  }
  List<DropdownMenuItem> getSexData() {
    List<DropdownMenuItem> items = new List();
    DropdownMenuItem dropdownMenuItem1 = new DropdownMenuItem(
      child: new Text('男'),
      value: '1',
    );
    items.add(dropdownMenuItem1);
    DropdownMenuItem dropdownMenuItem2 = new DropdownMenuItem(
      child: new Text('女'),
      value: '2',
    );
    items.add(dropdownMenuItem2);
    return items;
  }
  ///
  /// 保存按钮点击的回调
  ///
  _saveUserInfo() {
    Navigator.pop(context, '$inputText');
  }
  ///
  /// 输入内容改变之后
  ///
  _onInputTextChange(String value) {
    setState(() {
      inputText = value;
    });
  }
}
