//http://eswar007.pythonanywhere.com/api/?format=json

import 'package:http/http.dart';
import 'dart:convert';

class article{
  int id;
  String title;
  String body;
  String thumbnail;
  String pubdate;
  int like;
  int author;
  

  article(this.id,this.title,this.body,this.thumbnail,this.pubdate,this.author,this.like);
  

}