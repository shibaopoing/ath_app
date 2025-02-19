import 'package:ath_app/page/home_page.dart';
import 'package:flutter/material.dart';

class PageConstance {
  static String WELCOME_PAGE = '/';
  static String HOME_PAGE = '/home';

  static Map<String, WidgetBuilder> getRoutes() {
    var route = {
      HOME_PAGE: (BuildContext context) {
        return MyHomePage(title: '未登录');
      }
    };

    return route;
  }
}
