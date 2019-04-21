import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ath_app/page/main_page.dart';
import 'package:ath_app/page/my_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();

}
class _MyHomePageState extends State<MyHomePage>{
  List<Widget> _viewList; //创建视图数组
  int _index = 0; //数组索引，通过改变索引值改变视图
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _viewList = List();
    _viewList..add(MainPage())..add(MainPage())..add(MainPage())..add( MyPage());

  }
  _openNewPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return EachView(title:"new Pager");
    }));
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:_viewList[_index],
      floatingActionButton: FloatingActionButton( //悬浮按钮
          child: Icon(Icons.add),
          onPressed:_openNewPage
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.home),
              onPressed: () {
                setState(() {
                  _index = 0;
                });
              },
            ),
            IconButton(icon: Icon(Icons.trip_origin),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
              },
            ),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.grade),
              onPressed: () {
                setState(() {
                  _index = 2;
                });
              },
            ),
            IconButton(icon: Icon(Icons.account_circle),
              onPressed: () {
                setState(() {
                  _index = 3;
                });
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
//子页面
//代码中设置了一个内部的_title变量，这个变量是从主页面传递过来的，然后根据传递过来的具体值显示在APP的标题栏和屏幕中间。
class EachView extends StatefulWidget {
  EachView({Key key,this.title}) : super(key: key);
  String title;
  @override
  _EachViewState createState() => _EachViewState(pageName:title);
}
class _EachViewState extends State<EachView>{
  _EachViewState({Key key,this.pageName});
  String pageName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(child: Text(widget.title)),
    );

  }
}
