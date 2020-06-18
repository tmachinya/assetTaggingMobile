class Inspection{
  int _id;
  String _name;
  String _category;
  int _stage;
  String _date_received;
  String _number;
  String _user;
  String _description;
  String _purchase_value;
  String _location;
  String _project;
  String _chasis_number;
  String _engine_number;
  String _licence_plate;
  String _serial_number;
  String _date_commissioned;
  String _date; 


 Inspection(this._name,this._category,this._date_received,this._stage,this._number,this._user, this._description,this._purchase_value,this._location,this._project,this._chasis_number,this._engine_number,this._licence_plate,this._serial_number,this._date_commissioned,this._date);

  Inspection.withID(this._id,this._name,this._category,this._date_received,this._stage, this._number, this._user, this._description,this._purchase_value,this._location,this._project,this._chasis_number,this._engine_number,this._licence_plate,this._serial_number,this._date_commissioned,this._date);

  // creating getters and setters

 int get id => _id;

  String get number => _number;
 set number(String newNumber) => _number = newNumber;

 String get user => _user;
 set user(String newUser) => _user = newUser; 

 String get name => _name;
 set name(String newName) => _name = newName;

 String get category => _category;
 set category(String newCategory) => _category = newCategory;

 int get stage => _stage;
 set stage(int newStage) => _stage = newStage;

 String get date => _date;
 set date(String newDate) => _date = newDate;

 String get date_received => _date_received;
 set date_received(String newReceived) => _date_received = newReceived; 

 String get description => _description;
 set description(String newDescription) => _description = newDescription;

 String get purchase_value => _purchase_value;
 set purchase_value(String newValue) => _purchase_value = newValue;

 String get location => _location;
 set location(String newLocation) => _location = newLocation;

 String get project => _project;
 set project(String newProject) => _project = newProject;

 String get chasis_number => _chasis_number;
 set chasis_number(String newCnumber) => _chasis_number = newCnumber;

 String get engine_number => _engine_number;
 set engine_number(String newEnumber) => _engine_number = newEnumber;

 String get licence_plate => _licence_plate;
 set licence_plate(String newLplate) => _licence_plate = newLplate;

 String get serial_number => _serial_number;
 set serial_number(String newSnumber) => _serial_number = newSnumber;

 String get date_commissioned => _date_commissioned;
 set date_commissioned(String newDcommissioned) => _date_commissioned = newDcommissioned;

Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  if(id !=null)
    {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['date'] = _date;
    map['category'] = _category;
    map['stage'] = _stage;
    map['date_received'] = _date_received;
    map['number'] = _number;
    map['user'] = _user;
    map['description'] = _description;
    map['purchase_value'] = _purchase_value;
    map['location'] = _location;
    map['project'] = _project;
    map['chasis_number'] = _chasis_number;
    map['engine_number'] = _engine_number;
    map['licence_plate'] = _licence_plate;
    map['serial_number'] = _serial_number;
    map['date_commissioned'] = _date_commissioned;

    return map;
} 

Inspection.fromMapObject(Map<String, dynamic> map)
  {
    this._date_received = map['date_received'];
    this._name = map['name'];
    this._date = map['date'];
    this._category = map['category'];
    this._stage = map['stage'];
    this._user = map['user'];
    this._number = map['number'];
    this._description = map['description'];
    this._purchase_value = map['purchase_value'];
    this._location = map['location'];
    this._project = map['project'];
    this._chasis_number = map['chasis_number'];
    this._engine_number = map['engine_number'];
    this._licence_plate = map['licence_plate'];
    this._serial_number = map['serial_number'];
    this._date_commissioned = map['date_commissioned'];
    this._id = map['id'];
  }
}