
import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      title: "Exploring UI Widgets - ListView",
      home: Scaffold(
        appBar: AppBar(title: Text("List View")),
        body: getListView(),
        floatingActionButton: FloatingActionButton(
          child:Icon(Icons.add),
          tooltip: "Add one more item",
          onPressed: (){
            debugPrint("A");
          },
        ),
      )
    )
  );
}

List<String> getListElements(){
  var items = List<String>.generate(1000, (counter)=> "Item $counter");
  return items;
}

Widget getListView(){
  var listItems = getListElements();
  var listView = ListView.builder(
    itemBuilder: (context,index) {
      return ListTile(
        leading: Icon(Icons.arrow_right),
        title: Text(listItems[index]),
        onTap: () {
          showSnackBar(context,listItems[index]);
        },
      );
    }
  );
  return listView;
}

void showSnackBar(BuildContext context, String item){
  var snackBar = SnackBar(
    content: Text(item),
    action: SnackBarAction(
      label: "Undo",
      onPressed: (){
        debugPrint("Dummpy");
        
      },
    ),
  );
  Scaffold.of(context).showSnackBar(snackBar);
}