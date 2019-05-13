
import 'package:ath_app/common/skip_down_time.dart';
import 'package:ath_app/page_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() {
    return new _WelcomePageState();
  }
}

class _WelcomePageState extends State<WelcomePage>
    implements OnSkipClickListener {
  var welcomeImageUrl = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getWelcomeImage();
    _delayedGoHomePage();
  }

  _delayedGoHomePage() {
    Future.delayed(new Duration(seconds: 5), () {
      _goHomePage();
    });
  }

  _goHomePage() {
    Navigator.of(context).pushNamedAndRemoveUntil(
        PageConstance.HOME_PAGE, (Route<dynamic> route) => false);
  }

  _getWelcomeImage() async {
//    String url = AppConstance.makeUrl('services/app_ad_cover.json', null);
//    Dio dio = new Dio();
//    Response response = await dio.get(url);
//    print(response.data);
//    var data = response.data.toString();
//    List list = json.decode(data);
//    String cover = '';
//    var item;
//    for (item in list) {
//      cover = item['field_app_ad_cover'];
//      if (cover != null && cover.isNotEmpty) {
//        cover = StringUtil.getSrcImagePath(cover);
//        break;
//      }
//    }
//
//    print('cover===$cover');
//    setState(() {
//      welcomeImageUrl = cover;
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        new Container(
          color: Colors.white,
          child: new Image.network(
            "http://www.wsrtv.com.cn/sites/default/files/%E4%B8%89%E6%9C%88%E4%BD%A0%E5%A5%BD.jpg",
            fit: BoxFit.cover,
          ),
          constraints: new BoxConstraints.expand(),
        ),
        new Image.asset('assets/images/wenshan_wel_logon.jpg',fit: BoxFit.fitWidth),
        new Container(
          child: Align(
            alignment: Alignment.topRight,
            child: new Container(
              padding: const EdgeInsets.only(top: 30.0, right: 20.0),
              child: new SkipDownTimeProgress(
                Colors.red,
                22.0,
                new Duration(seconds: 5),
                new Size(25.0, 25.0),
                skipText: "跳过",
                clickListener: this,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onSkipClick() {
    _goHomePage();
  }
}
