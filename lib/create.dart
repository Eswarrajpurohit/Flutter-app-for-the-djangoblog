//import 'dart:html';
import 'dart:io';

import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Create extends StatefulWidget {
  Create({Key key}) : super(key: key);

  @override
  _CreateState createState() => _CreateState();
}

class _CreateState extends State<Create> {
  
  
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController bodyController = TextEditingController();
  Dio dio = new Dio();
  var imagepicker;
  bool uploadstate = false;
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
          onWillPop: (){
            Navigator.popAndPushNamed(context,"/load");
          },
          child: Scaffold(
          appBar: AppBar(
            title: Text('Sample App'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image : DecorationImage(image: AssetImage("assets/tree.webp"),fit:BoxFit.cover)
              
            ),
            child: Padding(
                padding: EdgeInsets.all(10),
                child: ListView(
                  children: <Widget>[

                    //Heading
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Create New article',
                          style: TextStyle(
                              //color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              fontSize: 30),
                        )),
                    
                    //sub heading
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                        "Enter the data",
                          style: TextStyle(fontSize: 20),
                        )),
                    
                    //title field
                    Container(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        controller: titlecontroller,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Title',
                        ),
                      ),
                    ),
                    
                    //body field
                    Container(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        controller: bodyController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Article Body',
                        ),
                      ),
                    ),
                  
                    

                    //image picker button
                    Container(
                      height: 60,
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(30.0)
                          ),
                          textColor: Colors.white,
                          color: Colors.grey[850],
                          child: Text('pick image'),
                          
                          onPressed: () async{
                            imagepicker =await ImagePicker.pickImage(source: ImageSource.gallery);
                            
                          }
                        )),



                    //submit button
                    Container(
                      height: 60,
                      
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(30.0)
                          ),
                          textColor: Colors.white,
                          color: Colors.grey[850],
                          child: Text('Submit'),
                          onPressed: () async{
                            
                            try{
                              final localdata = await SharedPreferences.getInstance();
                              String filename = imagepicker.path.split("/").last;
                              String title = titlecontroller.text;
                              String uid = localdata.getInt("userId").toString();
                              String body = bodyController.text;
                              uploadstate = true;
                              setState(() {
                                
                              });
                              FormData formdata=new FormData.fromMap({
                                'thumbnail':await MultipartFile.fromFile(imagepicker.path,filename: filename,
                                            contentType: new MediaType('image','png')),
                                'title':"$title",
                                'body':"$body",
                                'author':"$uid"

                              });
                              Response response = await dio.post("http://eswar007.pythonanywhere.com/api/apicreate/",
                              data: formdata,
                              options: Options(
                                headers:{
                                  "Content-type":"multipart/form-data"
                                }
                                
                              ));
                              
                              if (response.statusCode==201){
                                Navigator.popAndPushNamed(context,"/load");
                              }
                            }
                            catch(e){
                              print(e.toString());
                            }
                          },
                        )),

                        Container(
                          padding: EdgeInsets.all(30),
                          child:uploadstate?
                          Center(child: new CircularProgressIndicator()):
                          Text("after pressing the submit button please wait for some time"),
                        )



                    
                  ],
                )),
          )),
    );
  }
}