import 'package:flutter/material.dart';
import 'package:blog/home.dart';
import 'package:blog/article.dart';
import 'package:blog/loading.dart';
import 'package:blog/login.dart';
import 'package:blog/signpu.dart';
import 'package:blog/create.dart';

void main() => runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData.dark(),
    initialRoute: '/login',
    routes: {
      '/login':(context)=>login(),
      '/signup':(context)=>Signup(),
      '/home':(context)=>Home(),
      '/load':(context)=>Loading(),
      '/article':(context)=>Article(),
      '/create':(context)=>Create(),
    },

));