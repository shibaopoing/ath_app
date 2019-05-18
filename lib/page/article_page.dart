import 'package:flutter/material.dart';

enum ArticleType {
  HOME_ARTICLE,
  NORMAL_ARTICLE,
  PROJECT_ARTICLE,
}

enum JumpFromType{
  KNOWLEDGE,
  OTHER,
}

class ArticlePage extends StatelessWidget {
  final String name;
  final int id;
  final ArticleType type;

  ArticlePage({this.name, this.id, this.type});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text(name),
      ),
    );
  }
}
