import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
 TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
 
  
  @override
  Widget build(BuildContext context) {
   return Scaffold(
        appBar: AppBar(
          title: Text('Sample App'),
          backgroundColor: Colors.grey[850],
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
                            color: Colors.blue,
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
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: TextField(
                      obscureText: true,
                      controller: passwordController2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Re-type Password',
                      ),
                    ),
                  ),
                


                  Container(
                    height: 50,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.grey[850],
                        child: Text('Signup'),
                        onPressed: () async{
                          
                          String uname = nameController.text;
                          String pass = passwordController.text;
                          String pass2 = passwordController2.text;
                          var url = "http://eswar007.pythonanywhere.com/api/apisignup/";
                         
                          var body = {"username":"$uname","password1":"$pass","password2":"$pass2"};
                          
                        
                          

                          final response = await http.post(url,
                                        //body:{"username":uname,"password":pass},
                                        headers: {'Content-Type': 'application/json'},
                                        body:JsonEncoder().convert(body),
                                        );
                          
                          int stat = response.statusCode;
                          
                          
                          if (stat==201){
                            Navigator.popAndPushNamed(context, 'login');
                          
                          } 

                         
                        },
                      )),
                  
                ],
              )),
        ));
  } 
} 