import 'package:blog/blogapi.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class Loading extends StatefulWidget {
  Loading({Key key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool dba = false;
  List<article> myalldata =[];
  
  var uname;

  Future<void> getarticle() async
  {
    final localdata = await SharedPreferences.getInstance();
    print(localdata.getBool('login'));
    uname = localdata.getString("username");


    var data = await get('http://eswar007.pythonanywhere.com/api/?format=json');
    if(data.statusCode==201){
        String jsodata = data.body;
        var finaldata = json.decode(jsodata);
        // Navigator.pushReplacementNamed(context, '/home',arguments: {
        //     'data':finaldata
        // });
        dba = true;
        for(var da in finaldata)
        {
          myalldata.add(new article(da['id'], da['title'], da['body'], da['thumbnail'], da['pubdate'],da['author'], da['like']));
        }
        setState(() {});
    }
    else{
      print("something went wrong");
      setState(() {});
    }
  }
  
   @override
  void initState() {
    super.initState();
    getarticle();
  }

  @override
  Widget build(BuildContext context) {
    var response = ModalRoute.of(context).settings.arguments;

    return Container(
      decoration: BoxDecoration(
            //image : DecorationImage(image: AssetImage("assets/tree.webp"),fit:BoxFit.cover)
          ),

      child: Scaffold(
        appBar: AppBar(
          title:Text("Blog for everyone"),
          ),
          

           drawer:new Drawer(
            child:new ListView(
              children: <Widget>[
                  UserAccountsDrawerHeader(
                    accountName: Text("$uname"), 
                    accountEmail: Text(""),
                    decoration: new BoxDecoration(
                      color:Colors.grey
                    ),),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: InkWell(
                        child:Text("Logout",
                                    style:TextStyle(
                                      
                                    )),
                        onTap: ()async{
                          final localdata = await SharedPreferences.getInstance();
                          localdata.setBool("login",false);
                          Navigator.popAndPushNamed(context, "/login");
                        },
                      ),
                    ),
              ]
            ),
          ),


          body: 
              myalldata.length ==0? Container(
                decoration: BoxDecoration(
            image : DecorationImage(image: AssetImage("assets/tree.webp"),fit:BoxFit.cover)
          ),
                child: new Center(child: new CircularProgressIndicator(),))
                :showUi(),
                floatingActionButton: FloatingActionButton(onPressed:(){
                Navigator.popAndPushNamed(context, "/create");
              },
              child: Icon(Icons.add),
              ),
              

        
      ),
    );
  }

  Widget showUi(){
    return Container(
      decoration: BoxDecoration(
            image : DecorationImage(image: AssetImage("assets/tree.webp"),fit:BoxFit.cover)
          ),


          child: Padding(
            padding: const EdgeInsets.fromLTRB(40,90,40,90),
            child: SizedBox(
              
              //height: 400,
              child: PageView.builder(
                itemCount: myalldata.length,
                itemBuilder: (_,index){
                  return Card(
                    elevation: 6,
                    color: Colors.grey[600],
                    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(30)),
                    child: InkWell(
                        child: Column(
                        children: <Widget>[
                          Container(
                            height:300,
                            decoration: BoxDecoration(
                              image : DecorationImage(image: NetworkImage("http://eswar007.pythonanywhere.com"+myalldata[index].thumbnail.toString()),fit:BoxFit.cover),
                              borderRadius: BorderRadius.circular(20.0)

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0,25,0,0),
                            child: Text(
                              myalldata[index].title,
                              style:TextStyle(
                                fontSize:20.0
                              )
                              ),
                          )
                        ],
                      ),
                      onTap:(){
                                print(myalldata[index].like);
                                print(myalldata[index].author);
                                Navigator.popAndPushNamed(context, '/home',arguments: {
                                                                                  'title':myalldata[index].title,
                                                                                  'id':myalldata[index].id,
                                                                                  'body':myalldata[index].body,
                                                                                  'image':myalldata[index].thumbnail,
                                                                                  'like':myalldata[index].like});
                              },
                     ),
                  );
                },
                
                ),
            ),
          ),
      // child: ListView.builder(
      //   itemCount : myalldata.length,
      //   itemBuilder: (_,index){
          
      //       return ListTile(
              
      //         contentPadding: EdgeInsets.all(10),
            
      //         title: Text(myalldata[index].title),
      //         trailing: Image.network("http://eswar007.pythonanywhere.com"+myalldata[index].thumbnail.toString()),
      //         onTap:(){
      //           Navigator.pushNamed(context, '/home',arguments: {
      //                                                             'title':myalldata[index].title,
      //                                                             'id':myalldata[index].id,
      //                                                             'body':myalldata[index].body,
      //                                                             'image':myalldata[index].thumbnail,
      //                                                             'like':myalldata[index].like});
      //         },
      //       );
      //   },
      // ),
    );
  }
}