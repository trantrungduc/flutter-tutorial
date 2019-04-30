
import 'package:flutter/material.dart';
void main(){
  runApp(
    MaterialApp(
      title: "Stateful App example",
      home: FavoriteCity()
    )
  );
}

class FavoriteCity extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _FavoriteCityState();
  }
  
}

class _FavoriteCityState extends State<FavoriteCity>{
  String nameCity="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stateful App Example")),
      body: Container(
        margin: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextField(
              onChanged: (String userInput){
                setState(() {
                  nameCity=userInput;
                });
              },
            ),
            Padding(
              child:Text(
                "Your best city is $nameCity"
              ),
              padding: EdgeInsets.all(30.0),
            )
          ],
        ),
      )
    );
  }
  
}