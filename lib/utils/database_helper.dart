import 'dart:io';
import 'package:champion/models/checkin.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:champion/models/inspection.dart';

class DatabaseHelper
  {
    static DatabaseHelper _databaseHelper; //Singleton
    static Database _database; //Singleton

    String inspectionTable = 'inspection_table';
    String checkinTable = 'checkin_table';
    String colId = 'id';
    String colName = 'name';
    String colDateReceived = 'date_received';
    String colCategory = 'category';
    String colStage = 'stage';
    String colNumber ='number';
    String colUser = 'user';
    String colDescription ='description';
    String colPurchaseValue ='purchase_value';
    String colLocation ='location';
    String colProject ='project';
    String colChasisNumber ='chasis_number';
    String colEngineNumber ='engine_number';
    String colLicencePlate ='licence_plate';
    String colSerialNumber ='serial_number';
    String colDateCommissioned ='date_commissioned';
    String colDate = 'date';

    DatabaseHelper._createInstance();
    factory DatabaseHelper()
      {
        if(_databaseHelper==null)
        {
          _databaseHelper = DatabaseHelper._createInstance();
        }
        return _databaseHelper;
      }
      Future<Database> get database async{
        if(_database == null)
          {
            _database = await initialiseDatabase();
          }
        return _database;
      }
    Future<Database> initialiseDatabase () async
      {
        Directory directory = await getApplicationDocumentsDirectory();
        String path = directory.path + 'inspections.db';

        var inspectionsDatabase = await openDatabase(path, version:1, onCreate: _createDb);
        return inspectionsDatabase;
      }   

    void _createDb(Database db, int newVersion) async
      {
        await db.execute('CREATE TABLE $inspectionTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colName TEXT, $colDateReceived TEXT, $colCategory TEXT, $colNumber TEXT, $colUser TEXT, $colStage INTEGER, $colDescription TEXT, $colPurchaseValue TEXT, $colLocation TEXT, $colProject TEXT, $colChasisNumber TEXT, $colEngineNumber TEXT, $colLicencePlate TEXT, $colSerialNumber TEXT, $colDateCommissioned TEXT, $colDate TEXT)');

                 // Battery DB
       await db.execute('CREATE TABLE $checkinTable('
        'id INTEGER PRIMARY KEY AUTOINCREMENT,'  
        'owner TEXT,'
        'serial TEXT,'
        'stage int,'
        'department int,'
        'color TEXT,'     
        'date TEXT'
        ')'); 
      }

      
// ************Asset Inspection section Start**************************//
      // fetch data
      Future<List<Map<String, dynamic>>>getInspectionMapList() async{
        Database db = await this.database;
        var result = await db.query(inspectionTable, orderBy: '$colStage ASC');
        return result;
      }
      //  insert data
      Future<int>insertInspection(Inspection inspection) async{
        Database db = await this.database;
        var result = await db.insert(inspectionTable, inspection.toMap());
        return result;
      }

        //  Update data
      Future<int>updateInspection(Inspection inspection) async{
        Database db = await this.database;
        var result = await db.update(inspectionTable, inspection.toMap(),where: '$colId=?', whereArgs: [inspection.id]);
        return result;
      }

         //  delete data
      Future<int>deleteInspection(int id) async{
        Database db = await this.database;
        var result = await db.rawInsert('DELETE FROM $inspectionTable WHERE $colId = $id');
        return result;
      }

          //  Get number on Inspection Objects in database
      Future<int>getCount() async{
        Database db = await this.database;
        List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $inspectionTable');
        int result = Sqflite.firstIntValue(x);
        return result;
      }

      Future<List<Inspection>> getInspectionList() async
        {
          var inspectionMapList = await getInspectionMapList();
          int count = inspectionMapList.length;
          List<Inspection> inspectionList = List<Inspection>();

          for (int i=0; i<count; i++)
            {
              inspectionList.add(Inspection.fromMapObject(inspectionMapList[i]));
            }
            return inspectionList;
        }

// ************Asset Inspection section End**************************//

// ***********Checkin section start *********************************//
 // fetch data
      Future<List<Map<String, dynamic>>>getCheckinMapList() async{
        Database db = await this.database;
        var result = await db.query(checkinTable, orderBy: 'stage ASC');
        return result;
      }
      //  insert data
      Future<int>insertCheckin(Checkin checkin) async{
        Database db = await this.database;
        var result = await db.insert(checkinTable, checkin.toMap());
        return result;
      }

        //  Update data
      Future<int>updateCheckin(Checkin checkin) async{
        Database db = await this.database;
        var result = await db.update(checkinTable, checkin.toMap(),where: 'id=?', whereArgs: [checkin.id]);
        return result;
      }

         //  delete data
      Future<int>deleteCheckin(int id) async{
        Database db = await this.database;
        var result = await db.rawInsert('DELETE FROM $checkinTable WHERE id = $id');
        return result;
      }

      Future<List<Checkin>> getCheckinList() async
        {
          var checkinMapList = await getCheckinMapList();
          int count = checkinMapList.length;
          List<Checkin> checkinList = List<Checkin>();

          for (int i=0; i<count; i++)
            {
              checkinList.add(Checkin.fromMapObject(checkinMapList[i]));
            }
            return checkinList;
        }

// ***********Checkin Section End  **********************************//


  }