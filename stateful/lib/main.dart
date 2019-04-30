
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
  var _currencies = ["VND","USD","Yen"];
  var _currentItemSelected="USD";
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
            DropdownButton<String>(
              items: _currencies.map((String dropItem){
                return DropdownMenuItem<String>(
                  value: dropItem,
                  child: Text(dropItem)
                );
              }).toList(),
              onChanged: (String newValueSelected){
                setState(() {
                 this. _currentItemSelected=newValueSelected;
                });
              },
              value: _currentItemSelected,
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