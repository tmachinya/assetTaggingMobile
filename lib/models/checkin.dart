class Checkin{
  int _id;
  String _owner;
  String _serial;
  String _date;
  int _stage;
  int _department;
  String _color;

  Checkin(this._owner,this._serial,this._date,this._stage,this._department,this._color);

  Checkin.withID(this._id,this._owner,this._serial,this._date,this._stage,this._department,this._color);

 int get id => _id;

 String get owner => _owner;
 set owner(String value) => _owner = value;

 String get serial => _serial;
 set serial(String value) => _serial = value;

 String get date => _date;
 set date(String value) => _date = value;

 int get stage => _stage;
 set stage(int value) => _stage = value;

 int get department => _department;
 set department(int value) => _department = value;

 String get color => _color;
 set color(String value) => _color = value;

 Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  if(id !=null)
    {
      map['id'] = _id;
    }
    map['owner'] = _owner;
    map['serial'] = _serial;
    map['date'] = _date;
    map['stage'] = _stage;
    map['department'] = _department;
    map['color'] = _color;
    return map;
} 

Checkin.fromMapObject(Map<String, dynamic> map)
  {
    this._owner = map['owner'];
    this._serial = map['serial'];
    this._date = map['date'];
    this._stage = map['stage'];
    this._department = map['department'];
    this._color = map['color'];   
    this._id = map['id'];
  }



}