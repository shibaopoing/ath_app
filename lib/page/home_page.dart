import 'package:ath_app/common/text_style.dart';
import 'package:ath_app/page/demoChip.dart';
import 'package:ath_app/page/mine_page.dart';
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
  static const double _iconSize = 30;
  static const int selectedColor =0xFF2962FF;
  static const int normalColor =0xFF212121;
  List<int> _itemsColor;
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _viewList = List();
    _viewList..add(MainPage())..add( new ChipDemo())..add(MinePage())..add( MinePage());
    _itemsColor = List();
    _itemsColor..add(selectedColor)..add(normalColor)..add(normalColor)..add(normalColor);
  }
  _openNewPage() {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (BuildContext context) {
      return EachView(title:"填写您的愿望单");
    }));
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body:_viewList[_index],
      floatingActionButton: FloatingActionButton( //悬浮按钮
          backgroundColor: Style.cardColor,
          child: Icon(Icons.add,color:Style.iconColor),
          onPressed:_openNewPage
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(), // 底部导航栏打一个圆形的洞
        color: Style.iconColor,
        child: Row(
          children: <Widget>[
            IconButton(icon: Icon(Icons.home,color: Color(_itemsColor[0]),size:_iconSize),
              onPressed: () {
                setState(() {
                  _index = 0;
                });
                _setSelectedItemsColor(_index);
              },
            ),
            IconButton(icon: Icon(Icons.trip_origin,color: Color(_itemsColor[1]),size:_iconSize),
              onPressed: () {
                setState(() {
                  _index = 1;
                });
                _setSelectedItemsColor(_index);
              },
            ),
            SizedBox(), //中间位置空出
            IconButton(icon: Icon(Icons.grade,color: Color(_itemsColor[2]),size:_iconSize),
              onPressed: () {
                setState(() {
                  _index = 2;
                });
                _setSelectedItemsColor(_index);
              },
            ),
            IconButton(icon: Icon(Icons.account_box,color: Color(_itemsColor[3]),size:_iconSize),
              onPressed: () {
                setState(() {
                  _index = 3;
                });
                _setSelectedItemsColor(_index);
              },
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.spaceAround, //均分底部导航栏横向空间
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor:Style.iconColor ,
    );
  }
  _setSelectedItemsColor(int index){
    //遍历每个元素  此时不可add或remove  否则报错 但可以修改元素值，
    for(int i=0;i<_itemsColor.length;i++){
      if(i==index){
        setState(() {
          _itemsColor[i]=selectedColor;
        });
      }else{
        setState(() {
          _itemsColor[i]=normalColor;
        });
      }
    }
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
