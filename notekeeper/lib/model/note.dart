class Note{
  int _id, _priority;
  String _title, _description, _date;
  Note(this._title, this._date, this._priority,[this._description]);
  Note.withId(this._id, this._title, this._date, this._priority,[this._description]);
  int get id => _id;
  int get priority => _priority;
  String get title => _title;
  String get description => _description;
  String get date => _date;

  set title(String value){
    this._title = value;
  }

  set description(String value){
    this._description = value;
  }

  set date(String value){
    this._date = value;
  }

  set priority(int value){
    this._priority = value;
  }

  Map<String,dynamic> toMap(){
    var map = Map<String,dynamic>();
    if (id!=null){
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['priority'] = _priority;
    map['date'] = _date;
    return map;
  }

  Note.fromMapObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this. _date = map['date'];
  }
}