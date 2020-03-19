import 'package:flutter/widgets.dart';

abstract class ITabPage extends StatefulWidget  {
  String tabName;
  int tabIndex;
  ITabPage(this.tabName ,this.tabIndex);
  String getName(){
    return this.tabName;
  }
  int getIndex(){
    return this.tabIndex;
  }
}