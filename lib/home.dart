import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:blog/blogapi.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  
  List<article> allData=[];
  
  @override
  Widget build(BuildContext context) {
    
    
    Map data = ModalRoute.of(context).settings.arguments;
    
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    
    return WillPopScope(
          onWillPop: (){
            Navigator.popAndPushNamed(context,"/load");
          },

          child: Scaffold(
            appBar: AppBar(
              title:Text(data['title'])
            ),
            body: Stack(
              children:<Widget>[
                Container(
                  height: screenheight,
                  width: screenwidth,
                  color: Colors.grey[850],
                ),

                Container(
                  height:screenheight - screenheight/2,
                  width: screenwidth,
                  decoration: BoxDecoration(
                    image:DecorationImage(
                      image : NetworkImage("http://eswar007.pythonanywhere.com"+data["image"].toString()),
                      fit:BoxFit.cover
                    ),
                  ),
                ),

                Positioned(
                  top:screenheight/2 - 30 ,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                      padding : EdgeInsets.only(left:20.0),
                      height: screenheight/2 + 25.0,
                      width: screenwidth,
                      child: ListView(
                          children: <Widget>[
                          Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:[
                            SizedBox(height:25.0),
                            Text(data["title"],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:20,
                                fontWeight:FontWeight.bold),
                            ),
                            SizedBox(height:25.0),
                            Text(data["body"],
                            style: TextStyle(
                                fontSize:15,
                                ),
                            ),
                            SizedBox(height:30.0),

                            Container(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 100),
                              child: Row(
                                
                                children:[

                                  RaisedButton.icon(
                                  shape: RoundedRectangleBorder(
                                     borderRadius:BorderRadius.circular(30.0)
                                  ) ,
                                  onPressed: ()async{
                                    var body={"id":data["id"].toString(),"action":"1"};
                                    var url="https://eswar007.pythonanywhere.com/api/apilike/";
                                    final response = await http.post(url,
                                                                    headers: {'Content-Type': 'application/json'},
                                                                    body:JsonEncoder().convert(body),);

                                    int code = response.statusCode;
                                    //print(response.body);
                                    if(code == 201){
                                          data["like"]=data["like"]+1;
                                          
                                          setState(() {
                                            
                                          });
                                    } 
                                  }, 
                                  icon: Icon(Icons.thumb_up),
                                  label: Text(""),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(data["like"].toString()),
                                  ),

                                  RaisedButton.icon(
                                  shape: RoundedRectangleBorder(
                                     borderRadius:BorderRadius.circular(30.0)
                                  ) ,
                                  onPressed: ()async{
                                     var body={"id":data["id"].toString(),"action":"0"};
                                    var url="https://eswar007.pythonanywhere.com/api/apilike/";
                                    final response = await http.post(url,
                                                                    headers: {'Content-Type': 'application/json'},
                                                                    body:JsonEncoder().convert(body),);

                                    int code = response.statusCode;
                                    
                                    if(data["like"]==0){return;}
                                    if(code == 201){
                                          data["like"]=data["like"]-1;
                                          
                                          setState(() {
                                            
                                          });
                                    }
                                  }, 
                                  icon: Icon(Icons.thumb_down),
                                  label: Text(""),
                                  )

                                ]
                              ),
                            ),
                            SizedBox(height:20.0)

                          ]
                        ),],
                      ), 
                      decoration: BoxDecoration(
                        
                        borderRadius: BorderRadius.only(topLeft:Radius.circular(25.0),topRight:Radius.circular(25.0)),
                        color: Colors.grey[800]
                      ),
                    ),
                  ),
                  ),


              ],
            )
          ),
    );
  }
}