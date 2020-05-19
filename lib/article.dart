import 'package:flutter/material.dart';

class Article extends StatefulWidget {
  Article({Key key}) : super(key: key);

  @override
  _ArticleState createState() => _ArticleState();
}

class _ArticleState extends State<Article> {
  @override
  Widget build(BuildContext context) {
    return Container(
       child: Text("article"),
    );
  }
}