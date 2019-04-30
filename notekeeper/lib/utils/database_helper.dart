import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import '../model/note.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;
  String noteTable = 'notes',colId='id',colTitle='title',colDesc='description',colPriority='priority',colDate='date';

  DatabaseHelper._createInstance();
  factory DatabaseHelper(){
    if (_databaseHelper==null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async{
    if (_database==null){
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async{
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path+'notes.db';

    var notesDB = await openDatabase(path,version: 1, onCreate: _createDB);
    return notesDB;
  }

  void _createDB(Database db, int newVersion) async{
    await db.execute('create table $noteTable($colId integer primary key autoincrement, $colTitle text, $colDesc text, $colPriority integer, $colDate text)');
  }

  Future<List<Map<String,dynamic>>> getNoteMapList() async{
    Database db = await this.database;
    var result = await db.rawQuery('select * from $noteTable order by $colPriority asc');
    return result;
  }

  Future<int> insertNote(Note note) async{
    Database db = await this.database;
    var result = await db.insert(noteTable,note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async{
    Database db = await this.database;
    var result = await db.update(noteTable,note.toMap(), where: '$colId=?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNote(int id) async{
    Database db = await this.database;
    int result = await db.rawDelete('delete from $noteTable where $colId=$id');
    return result;
  }

  Future<int> getcount() async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('select count(*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Note>> getNoteList() async{
    var noteMapList = await getNoteMapList();
    int count = noteMapList.length;
    List<Note> noteList = List<Note>();
    for (int i=0;i<count;i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }

}