import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:champion/checkins/checkin_list.dart';
import 'package:flutter/material.dart';
import 'package:champion/models/checkin.dart';
import 'package:champion/utils/database_helper.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CheckinDetail extends StatefulWidget {
  final appBarTitle;
  final Checkin checkin;

  CheckinDetail(this.checkin,this.appBarTitle);
  @override
  _CheckinDetailState createState() => _CheckinDetailState(this.checkin,this.appBarTitle);
}

class _CheckinDetailState extends State<CheckinDetail> {
// stage on capturing
  String appBarTitle;
  DatabaseHelper helper = DatabaseHelper();
  static var _stage = ['In', 'Out'];
  static var _department = ['ICT','HR','Finance','Risk'];
  Checkin checkin;

TextEditingController ownerController = TextEditingController();
TextEditingController serialController = TextEditingController();
TextEditingController dateController = TextEditingController();
TextEditingController stageController = TextEditingController();
TextEditingController departmentController = TextEditingController();
TextEditingController colorController = TextEditingController();

  _CheckinDetailState(this.checkin,this.appBarTitle);

  @override
  Widget build(BuildContext context) {
ownerController.text = checkin.owner;
serialController.text = checkin.serial;
dateController.text = checkin.date;
colorController.text = checkin.color;
    
    return WillPopScope(
          onWillPop: ()
          {
            movetoHomeScreen();
          },
          child: Scaffold(
          appBar: AppBar(
          title: Text(appBarTitle),
          leading: IconButton(
            icon: Icon(Icons.home), onPressed: (){
            movetoHomeScreen();
          }),
          backgroundColor: Colors.green[600],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 30.0, right: 30.0),
          child: ListView(
            children: <Widget>[
              // first element
              ListTile(
                title: Text("Time"),
                trailing: DropdownButton(
                  items: _stage.map((String dropDownStringItem){
                    return DropdownMenuItem<String> (                    
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),                    
                      );
                  }
                  ).toList(), 
                  isExpanded: false,              
                  value: getStageAsString(checkin.stage),
                  onChanged: (stageSelectedByUser){
                    setState(() {
                      updateStageAsInt(stageSelectedByUser);
                    });
                  }
                  ),
              ),

              // First Element
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: ownerController,
                  onChanged: (value){                   
                    updateOwner();
                  },
                  decoration: InputDecoration(
                    labelText: 'Owner',
                  ),
                ),
                ),


                     // first element
              ListTile(
                title: Text("Department"),
                trailing: DropdownButton(
                  items: _department.map((String dropDownStringItem){
                    return DropdownMenuItem<String> (                    
                      value: dropDownStringItem,
                      child: Text(dropDownStringItem),                    
                      );
                  }
                  ).toList(), 
                  isExpanded: false,              
                  value: getDepartmentAsString(checkin.department),
                  onChanged: (stageSelectedByUser){
                    setState(() {
                      updateDepartmentAsInt(stageSelectedByUser);
                    });
                  }
                  ),
              ),

                           // First Element
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: serialController,
                  onChanged: (value){                   
                    updateSerial();
                  },
                  decoration: InputDecoration(
                    labelText: 'Serial Number',
                  ),
                ),
                ),

                           // First Element
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: colorController,
                  onChanged: (value){                   
                    updateColor();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',
                  ),
                ),
                ),

              
              // Submit Button
                    Padding(
                padding: EdgeInsets.only(top: 15.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Colors.green,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,                  
                        ),                
                        onPressed: (){
                          setState(() {
                            debugPrint("Save Button Clicked");
                            _save();
                          });
                        })
                      ),
                      Container(width: 5.0),
                    Expanded(
                      child: FlatButton(
                        color: Colors.green,
                        child: Text(
                          'Delete',
                          textScaleFactor: 1.5,                  
                        ),                
                        onPressed: (){
                          setState(() {
                            debugPrint("Delete Button Clicked");
                            _delete();
                          });
                        })
                      ),

                  ],
                )
                )    
            ],
          ),
          ),
       
      ),
    );
  }
 void   movetoHomeScreen(){
    Navigator.push(
              context, 
              new MaterialPageRoute(
                builder: (context)=> CheckinList())); 
  }

  void updateStageAsInt(String value)
    {
      switch(value)
        {
          case 'In':
            checkin.stage = 1;
            break;

          case 'Out':
          checkin.stage = 2;
          break;      

        }
    }

      void updateDepartmentAsInt(String value)
    {
      switch(value)
        {
          case 'ICT':
            checkin.department = 1;
            break;

          case 'Finance':
          checkin.department= 2;
          break;   

          case 'HR':
          checkin.department= 3;
          break;  

          case 'Finance':
          checkin.department= 2;
          break;   

        }
    }

  String getStageAsString(int value)
    {
      String stage;
      switch(value)
        {
          case 1:
            stage = _stage[0];
            break;

          case 2:
            stage = _stage[1];
          break;        

        }
        return stage;
    }

      String getDepartmentAsString(int value)
    {
      String department;
      switch(value)
        {
          case 1:
            department = _department[0];
            break;

          case 2:
            department = _department[1];
          break;   

          case 3:
            department = _department[2];
          break;   

          case 4:
            department = _department[3];
          break;      

        }
        return department;
    }

void updateOwner() {checkin.owner = ownerController.text;}
void updateSerial() {checkin.serial = serialController.text;}
void updateDate() {checkin.date = dateController.text;}
void updateColor() {checkin.color = colorController.text;}

  
    // save data to the database
    void _save() async
      {
        movetoHomeScreen();
        checkin.date = DateFormat.yMMMd().format(DateTime.now());
         int result;
        if(checkin.id != null)       
          {
           result = await helper.updateCheckin(checkin);        
          }
          else{
            result = await helper.insertCheckin(checkin);
          }
        
        if(result !=0)
          {
            _showAlterDialog('Status', 'Checkin Saved Successfully');
          } else{
            _showAlterDialog('Status', 'Problem Saving Checkin');
          }
      }

    void _delete() async
      {
        movetoHomeScreen();     
        if(checkin.id == null)
          {
            _showAlterDialog('Status', 'No Checkin was deleted');
			      return;
          } 

          int result = await helper.deleteCheckin(checkin.id);
          if (result != 0) {
			      _showAlterDialog('Status', 'Checkin Deleted Successfully');
          } else {
            _showAlterDialog('Status', 'Error Occured while Deleting Checkin');
          }
      }

      void _showAlterDialog(String title, String message)
        {
          AlertDialog alertDialog = AlertDialog(
            title: Text('title'),
            content: Text(message),
          );
          showDialog(
            context: context,
            builder: (_) => alertDialog
          );
        }

}