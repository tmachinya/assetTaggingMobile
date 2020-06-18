import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:champion/pages/inspection_list.dart';
import 'package:flutter/material.dart';
import 'package:champion/models/inspection.dart';
import 'package:champion/utils/database_helper.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class InspectionDetail extends StatefulWidget {
  final appBarTitle;
  final Inspection inspection;

  InspectionDetail(this.inspection,this.appBarTitle);
  @override
  _InspectionDetailState createState() => _InspectionDetailState(this.inspection,this.appBarTitle);
}

class _InspectionDetailState extends State<InspectionDetail> {
// stage on capturing
  String appBarTitle;
  DatabaseHelper helper = DatabaseHelper();
  static var _stage = ['In', 'Out'];
  Inspection inspection;

  TextEditingController nameController =  TextEditingController();
  TextEditingController dateReceivedController =  TextEditingController();
  TextEditingController categoryController =  TextEditingController();
  TextEditingController numberController =  TextEditingController();
  TextEditingController userController =  TextEditingController();
  TextEditingController descriptionController =  TextEditingController();
  TextEditingController purchaseValueController =  TextEditingController();
  TextEditingController locationController =  TextEditingController();
  TextEditingController projectController =  TextEditingController();
  TextEditingController chasisNumberController =  TextEditingController();
  TextEditingController engineNumberController =  TextEditingController();
  TextEditingController licencePlateController =  TextEditingController();
  TextEditingController serialNumberController =  TextEditingController();
  TextEditingController dateCommissionedController =  TextEditingController();

  _InspectionDetailState(this.inspection,this.appBarTitle);

  @override
  Widget build(BuildContext context) {
    nameController.text = inspection.name;
    dateReceivedController.text = inspection.date_received;
    categoryController.text = inspection.category;
    numberController.text = inspection.number;
    userController.text = inspection.user;
    descriptionController.text = inspection.description;
    purchaseValueController.text = inspection.purchase_value;
    locationController.text = inspection.location;
    projectController.text = inspection.project;
    chasisNumberController.text = inspection.chasis_number;
    engineNumberController.text = inspection.engine_number;
    licencePlateController.text = inspection.licence_plate;
    serialNumberController.text = inspection.serial_number;
    dateCommissionedController.text = inspection.date_commissioned;
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
                  value: getStageAsString(inspection.stage),
                  onChanged: (stageSelectedByUser){
                    setState(() {
                      updateStageAsInt(stageSelectedByUser);
                    });
                  }
                  ),
              ),


              // Name Element
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: nameController,
                  onChanged: (value){                   
                    updateName();
                  },
                  decoration: InputDecoration(
                    labelText: 'Asset Name',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),

                // Date Received Element
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: dateReceivedController,
                  onChanged: (value){
                    updateDateReceived();
                  },
                  decoration: InputDecoration(
                    labelText: 'Date Received',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),

         // Category Element
               Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: categoryController,
                  onChanged: (value){
                    updateCategory();
                  },
                  decoration: InputDecoration(
                    labelText: 'Category',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),

               // Asset Number Element
               Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: numberController,
                  onChanged: (value){
                    updateNumber();
                  },
                  decoration: InputDecoration(
                    labelText: 'Number',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),  

                // User Element
               Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: userController,
                  onChanged: (value){
                    updateUser();
                  },
                  decoration: InputDecoration(
                    labelText: 'User',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),    

                  //  Description element
                     Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: descriptionController,
                  onChanged: (value){
                    updateDescription();
                  },
                  decoration: InputDecoration(
                    labelText: 'Description',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),   

                    // Purchase Value
                       Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: purchaseValueController,
                  onChanged: (value){
                    updatePurchaseValue();
                  },
                  decoration: InputDecoration(
                    labelText: 'Purchase Value',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ), 

                // Location Element
                   Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: locationController,
                  onChanged: (value){
                    updateLocation();
                  },
                  decoration: InputDecoration(
                    labelText: 'Location',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),  

                    //  Project
                       Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: projectController,
                  onChanged: (value){
                    updateProject();
                  },
                  decoration: InputDecoration(
                    labelText: 'Project',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),       

                  // Chasis Number
                   Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: chasisNumberController,
                  onChanged: (value){
                    updateChasisNumber();
                  },
                  decoration: InputDecoration(
                    labelText: 'Chasis Number',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),   

                    // Engine Number
                       Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: engineNumberController,
                  onChanged: (value){
                    updateEngineNumber();
                  },
                  decoration: InputDecoration(
                    labelText: 'Engine Number',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),  

                    //  Licence Plate element
                       Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: licencePlateController,
                  onChanged: (value){
                    updateLicencePlate();
                  },
                  decoration: InputDecoration(
                    labelText: 'Licence Plate',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),  

                    //  Serial Number element
                       Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: serialNumberController,
                  onChanged: (value){
                    updateSerialNumber();
                  },
                  decoration: InputDecoration(
                    labelText: 'Serial Number',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
                  ),
                ),
                ),    

                  //  Date commissioned element

                     Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: TextField(
                  controller: dateCommissionedController,
                  onChanged: (value){
                    updateDateCommissioned();
                  },
                  decoration: InputDecoration(
                    labelText: 'Date Commissioned',              
                    // border: OutlineInputBorder(
                    //   borderRadius: BorderRadius.circular(0.1)),
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
                builder: (context)=> InspectionList())); 
  }

  void updateStageAsInt(String value)
    {
      switch(value)
        {
          case 'In':
            inspection.stage = 1;
            break;

          case 'Out':
          inspection.stage = 2;
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
  void updateName()
    {
      inspection.name = nameController.text;
    
    }
   void updateDateReceived()
    {
      inspection.date_received = dateReceivedController.text;
    
    }

  void updateCategory()
    {
      inspection.category = categoryController.text;
    
    }

    void updateNumber()
    {
      inspection.number = numberController.text;
    
    }

     void updateUser()
    {
      inspection.user = userController.text;
    
    }

    void updateDescription()
    {
      inspection.description = descriptionController.text;
    }

    void updatePurchaseValue()
    {
      inspection.purchase_value = purchaseValueController.text;
    }

    void updateLocation()
    {
      inspection.location = locationController.text;
    }

    void updateProject()
    {
      inspection.project = projectController.text;
    }

    void updateChasisNumber()
    {
      inspection.chasis_number = chasisNumberController.text;
    }

    void updateEngineNumber()
    {
      inspection.engine_number = engineNumberController.text;    
    }

    void updateLicencePlate()
    {
      inspection.licence_plate = licencePlateController.text;
    }

    void updateSerialNumber()
    {
      inspection.serial_number = serialNumberController.text;
    }

    void updateDateCommissioned()
    {
      inspection.date_commissioned = dateCommissionedController.text;
    }

    // save data to the database
    void _save() async
      {
        movetoHomeScreen();
        inspection.date = DateFormat.yMMMd().format(DateTime.now());
         int result;
        if(inspection.id != null)       
          {
           result = await helper.updateInspection(inspection);        
          }
          else{
            result = await helper.insertInspection(inspection);
          }
        
        if(result !=0)
          {
            _showAlterDialog('Status', 'Inspection Saved Successfully');
          } else{
            _showAlterDialog('Status', 'Problem Saving Inspection');
          }
      }

    void _delete() async
      {
        movetoHomeScreen();     
        if(inspection.id == null)
          {
            _showAlterDialog('Status', 'No Inspection was deleted');
			      return;
          } 

          int result = await helper.deleteInspection(inspection.id);
          if (result != 0) {
			      _showAlterDialog('Status', 'Inspection Deleted Successfully');
          } else {
            _showAlterDialog('Status', 'Error Occured while Deleting Inspection');
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