import 'package:ath_app/common/movieCard.dart';
import 'package:ath_app/page/ITabPage/ITab_page.dart';
import 'package:ath_app/page/movie_page.dart';
import 'package:ath_app/page/searchBarDelegate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ath_app/common/myDrawer.dart';
class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MainPageState createState() => new _MainPageState();
}
class _MainPageState extends State<MainPage> with SingleTickerProviderStateMixin{
  static GlobalKey<ScaffoldState> _globalKey= new GlobalKey();
  TabController _tabController; //需要定义一个Controller
  static MoviePage  moviePage = new MoviePage("电影",0);
  List tabs1 = ["电影", "电视剧","戏曲","动漫","音乐","短视频"];
  List<MoviePage> tabs = [moviePage];
  @override
  void initState() {
    super.initState();
    // 创建Controller
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(()
    {
      switch(_tabController.index){
/*        case 1: ;
        case 2: ... ;*/
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _globalKey , //设置key
      appBar:
      new AppBar(
        title:TabBar(//生成Tab菜单
            controller: _tabController,
            isScrollable: true,
            tabs: tabs.map((e) => Tab(text: e.tabName)).toList(),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.dashboard, color: Colors.white), //自定义图标
            onPressed: () {
              // 打开抽屉菜单
              //  Scaffold.of(context).openDrawer();
              _globalKey.currentState.openDrawer();
            },
          );
        }),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.search),
            tooltip: '搜索',
            onPressed: (){
             // NavigatorUtil.intentToPage(context, new SearchPage(), pageName: "SearchPage");
              showSearch(context: context, delegate: SearchBarDelegate());
            }
        )
        ],
      ),
      drawer: new MyDrawer(), //抽屉
      body:TabBarView(
        controller: _tabController,
        children: tabs.map((e) { //创建3个Tab页
          return Container(
            alignment: Alignment.topCenter,
            child: Stack(
              children: <Widget>[
                tabs[e.tabIndex],
              ],
            )

          );
        }).toList(),
      ),
    );
  }

}
