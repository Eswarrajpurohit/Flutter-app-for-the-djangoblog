import "package:flutter/material.dart";
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';


class login extends StatefulWidget {
  login({Key key}) : super(key: key);

  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void checklogin()async{
    final localdata = await SharedPreferences.getInstance();
    if(localdata.getBool("login")){
      Navigator.pushReplacementNamed(context, '/load');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    checklogin();
   return Scaffold(
        appBar: AppBar(
          backgroundColor:Colors.grey[850],
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
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Blog for Everyone',
                        style: TextStyle(
                            color: Colors.blue[50],
                            fontWeight: FontWeight.w500,
                            fontSize: 30),
                      )),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sign in',
                        style: TextStyle(fontSize: 20),
                      )),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                
                  Container(
                    height: 60,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RaisedButton(
                        elevation: 60,
                        
                        textColor: Colors.white,
                        //color: Colors.grey[850],
                        child: Text('Login'),
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(30.0)
                          
                        ),
                        onPressed: () async{
                          
                          String uname = nameController.text;
                          String pass = passwordController.text;
                          var url = "http://eswar007.pythonanywhere.com/api/apilogin/";
                         
                          var body = {"username":"$uname","password":"$pass"};
                          
                        
                          

                          final response = await http.post(url,
                                        headers: {'Content-Type': 'application/json'},
                                        body:JsonEncoder().convert(body),
                                        );
                          var finaldata = response.body;
                          int stat = response.statusCode;
                          
                          if (stat==201){
                            

                            final localdata = await SharedPreferences.getInstance();
                            localdata.setBool("login", true);
                            localdata.setString("username", uname);
                            var  responseMessage = jsonDecode(response.body);
                            
                            int userid = responseMessage["id"];
                            localdata.setInt("userId", userid);
                            Navigator.pushReplacementNamed(context, '/load');
                          
                          }        
                        },
                      )),


                    Container(
                    height: 60,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      
                      child: RaisedButton(
                        elevation: 20,
                        shape: RoundedRectangleBorder(
                          borderRadius:BorderRadius.circular(30.0)
                        ),
                        textColor: Colors.white,
                        color: Colors.grey[850],
                        child: Text('Signup'),
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                          }
                        
                      )),

                  
                ],
              )),
        ));
  }
} 