import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:notekeeper/model/note.dart';
import 'package:notekeeper/utils/database_helper.dart';
import 'package:intl/intl.dart';

class NoteDetail extends StatefulWidget{

  final String appBarTitle;
  final Note note;

  NoteDetail(this.note, this.appBarTitle);

  @override
  State<StatefulWidget> createState() {
    return NoteDetailState(this.note, this.appBarTitle);
  }
  
}

class NoteDetailState extends State<NoteDetail>{
  
  DatabaseHelper databaseHelper = DatabaseHelper();
  String appBarTitle;
  Note note;

  NoteDetailState(this.note, this.appBarTitle);

  static var _priorities = ['High','Low'];
  TextEditingController cTitle = TextEditingController();
  TextEditingController cDesc = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    cTitle.text = note.title;
    cDesc.text = note.description;

    return WillPopScope(
      onWillPop:(){
        moveToLastScreen();
      } ,
      child: Scaffold(
        appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              moveToLastScreen();
            },
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(top:10.0,left: 10.0,right: 10.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                title: DropdownButton(
                  items: _priorities.map((String value){
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  style: textStyle,
                  value: getPriorityAsString(note.priority),
                  onChanged: (newValue){
                    setState(() {
                      updatePriorityAsInt(newValue);
                    });
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: cTitle,
                  style: textStyle,
                  onChanged: (newValue){
                    updateTitle();
                  },
                  decoration: InputDecoration(
                    labelText: 'Title',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: TextField(
                  controller: cDesc,
                  style: textStyle,
                  onChanged: (newValue){
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: textStyle,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Save',style: TextStyle(color:Colors.white),textScaleFactor: 1.5,),
                        onPressed: (){
                          setState(() {
                            _save();
                          });
                        },
                      ),
                    ),
                    Container(width: 20.0,),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text('Delete',style: TextStyle(color:Colors.white),textScaleFactor: 1.5,),
                        onPressed: (){
                          setState(() {
                            _delete();
                          });
                        },
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }
  void moveToLastScreen(){
    Navigator.pop(context,true);
  }

  void updatePriorityAsInt(String value){
    switch(value){
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }

  String getPriorityAsString(int value){
    switch(value){
      case 1:
        return 'High';
        break;
      case 2:
        return 'Low';
        break;
    }
  }

  void updateTitle(){
    note.title = cTitle.text;
  }

  void updateDescription(){
    note.description = cDesc.text;
  }

  void _save() async{

    moveToLastScreen();
    note.date = DateFormat.yMMMd().format(DateTime.now());

    int result;
    if (note.id!=null){
      result = await databaseHelper.updateNote(note);
    }else{
      result = await databaseHelper.insertNote(note);
    }

    if (result!=0){
      _showAlertDialog('Status','Note saved successfully');
    }else{
      _showAlertDialog('Status','Problem saving note');
    }
  }

  void _delete() async{
    moveToLastScreen();
    if (note.id==null){
      _showAlertDialog('Status','No note was deleted');
    }else{
      int result = await databaseHelper.deleteNote(note.id);
      if (result!=0){
        _showAlertDialog('Status','Note deleted successfully');
      }else{
        _showAlertDialog('Status','Problem deleting note');
      }
    }
  }

  void _showAlertDialog(String title, String message){
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (_) => alert);
  }

}