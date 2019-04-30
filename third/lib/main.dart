
import 'package:flutter/material.dart';
import 'app_screens/home.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Exploring UI Widgets - ListView",
      home: Scaffold(
        appBar: AppBar(title: Text("Basic List View")),
        body: getListView(),
      )
    )
  );
}

Widget getListView(){
  var listView = ListView(
    children: <Widget>[
      ListTile(
        leading: Icon(Icons.landscape),
        title: Text("Landscape"),
        subtitle: Text("Beautiful View!"),
        trailing: Icon(Icons.wb_sunny),
        onTap: (){
          debugPrint("Landscape tapping!");
        },
      ),
      ListTile(
        leading: Icon(Icons.phone),
        title: Text("Windows")
      ),
      Text("Yet anather elements!"),
      Container(color: Colors.red, height: 50.0,),

    ],
  );
  return listView;
}