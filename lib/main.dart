import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState(getPost());
}

Future<List> getPost() async {
  String url = "https://jsonplaceholder.typicode.com/posts";
  http.Response response = await http.get(url);
  List data = await json.decode(response.body) ;
  return data;
}

class _MyAppState extends State<MyApp> {
  Future<List> posts ;
  _MyAppState(this.posts);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(icon: Icon(Icons.menu),onPressed: (){
              setState(() {
              });
            },)
          ],
          title: Text(
            "flutter Dimo",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: FutureBuilder<List>(
            future: posts,
            builder: (context,snapshot){
              if(snapshot.hasData){
                var content= '';
                for(int i =0 ; i<100;i++){
                 content += '\n ${snapshot.data[i]['title']}\n ${snapshot.data[i]['body']}\n ${snapshot.data[i]['id']} \n ${snapshot.data[i]['userId']}';
                }
                return Text(content);
              }else if(snapshot.hasError){
                return Text('${snapshot.error} error ');
              }
              return CircularProgressIndicator();
            },
          )
        ),
      ),
    );
  }
}
