import 'dart:async';
import 'dart:convert';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:champion/api/api.dart';
import 'package:champion/checkins/checkin_detail.dart';
import 'package:champion/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:champion/models/checkin.dart';
import 'package:champion/utils/database_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';
import 'package:champion/pages/drawer.dart';

class CheckinList extends StatefulWidget {
  @override
  _CheckinListState createState() => _CheckinListState();
}

class _CheckinListState extends State<CheckinList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Checkin> checkinList;
  int count = 0;
  String owner = '';
  String serial = '';
  // String department = '';
  String color = '';  

    var userData;
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    if(checkinList==null)
      {
        checkinList = List<Checkin>();
        updateListView();
      }
      //+++++++++++++++++BEGIN SCAFFOLDING+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
    return Scaffold(

      // *************Application Bar******************//
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('List Of All Checkins'),
            IconButton(
              icon: Icon(Icons.exit_to_app), 
              color: Colors.white,
              onPressed: ()=>{ 
                _logout()             
              })
          ],
        ),   
        backgroundColor: Colors.green[600],
      ),

// *************end of Application Bar******************//


// ***************starting of Drawer*******************//
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Colors.green,
                  Colors.greenAccent
                ]),
              ),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Material(
                      elevation: 10,
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/sangana.png',width: 80, height: 80,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Asset Tagging', style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    )
                  ],
                ),
              )),
           
           CustomListTile(Icons.person,userData!=null? '${userData['name']}': '',()=>{}),
           CustomListTile(Icons.notifications,'Notifications', ()=>{}),
           CustomListTile(Icons.settings,'Settings',()=>{}),
           CustomListTile(Icons.lock,'Logout',()=>{}),          
          ],
        ),
      ),

      // ******************end of Drawer*********************************************//

      //**************** Start of Body***********************************//
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: getCheckinListView()),
      ),
      // ***************End of Body**************************************//
    
       floatingActionButton: FloatingActionButton.extended(
           onPressed:() async{
             await _scanQR();
          navigatorToDetail(Checkin(owner, serial, '', 1, 2, color),'New Checkin');
           }, 
           icon: Icon(Icons.fingerprint),
           label: Text("Scan The Asset"),
           backgroundColor: Colors.red,
           ),
         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        // *****************floating bar end*****************************//



      //**************** */ bottom nav bar start**************************//
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top:5.0,left:15.0, right:15.0, bottom: 10.0),
        child: RaisedButton(
                          color: Colors.green,
                         textColor: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.arrow_right),
                              Text(
                                'send data to the server',
                                textScaleFactor: 1.5,
                              ),
                              Icon(
                                Icons.arrow_left),
                            ],
                          ),                
                          onPressed: () async{                                                          
                            var data = await databaseHelper.getCheckinMapList(); 
                            // print(data) ;                            
                            for(var n in data) 
                            {                               
                                var res = await callAPi().postanyData(n, 'audit'); 
                                var body = json.decode(res.body);  
                                print(body);                    
                                
                            } 
                             _showAlterDialog('Status', 'You have successfully send data to the database'); 


                          }),
      ),

      //***************************** */ bottom nav bar end*****************************//


    );

     //+++++++++++++++++END SCAFFOLDING+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
  }


// OTHER FUNCTIONS SUPPORTING THE SCAFFOLDING

  Future _scanQR() async
  {
   var qrResult = await BarcodeScanner.scan() ;  
   var ans = qrResult.rawContent;
   var ans2 = json.decode(ans);  
   try{
      setState(() {
        this.owner = ans2['user'];
        this.serial = ans2['number']; 
        this.color = ans2['description'] ;               
      });
   }on PlatformException catch (ex){
     if(ex.code == BarcodeScanner.cameraAccessDenied){
      setState(() {
         this.owner = 'Permission was denied';         
      });
     } else{
       setState(() {
          this.owner = "Unknown Error $ex";          
       });
     }
   } on FormatException{
     setState(() {
        this.owner = "You did not scan anything";        
     });
   } catch(ex) {
     setState(() {
          this.owner = "Unknown Error $ex";          
       });
   }
   
  
  }

    void _showAlterDialog(String title, String message)
    {
      AlertDialog alertDialog = AlertDialog(
        title: Text('Title'),
        content: Text(message),
      );
      showDialog(
        context: context,
        builder: (_) => alertDialog
      );
    }

// first one: Listview
  ListView getCheckinListView(){
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position)
      {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: getStageColor(this.checkinList[position].stage),
              child: getStageIcon(this.checkinList[position].stage),              
            ),
            title: Text(this.checkinList[position].owner),
            subtitle: Text(this.checkinList[position].date),    
            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.red),onTap: () {
								_delete(context, checkinList[position]);
							},
              ), 
            onTap: (){             
              navigatorToDetail(this.checkinList[position],'Editting Audit');
            },       
          ),
        );
      }
      );
  }

  //second one: returns stage color
  Color getStageColor(int stage)
    {
      switch(stage)
      {
        case 1: 
          return Colors.red;
          break;
        case 2: 
          return Colors.green;
          break;
        default:
          return Colors.green;
      }
    }

    //third one:  returns the stage icon
  Icon getStageIcon(int stage)
    {
      switch(stage)
      {
        case 1: 
          return Icon(Icons.shopping_cart);
          break;
        case 2: 
          return Icon(Icons.shopping_cart);
          break;
        default:
          return Icon(Icons.add_call);
      }
    }

    // fourth one: delete a record on clicking the delete icon
    void _delete(BuildContext context, Checkin checkin) async
      {
        int result = await databaseHelper.deleteCheckin(checkin.id);
        if(result !=0)
          {
            _showSnackBar(context, 'Checkin deleted successfully');
            updateListView();
          }
      }
// fifth one:  show snackbar function
      void _showSnackBar(BuildContext context, String message)
      {
        final snackBar = SnackBar(content: Text(message));
        Scaffold.of(context).showSnackBar(snackBar);
        
      }

      // sixth one : Navigate to checkin deatail
  void navigatorToDetail(Checkin checkin,String make) async
    {
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context){
              return CheckinDetail(checkin,make);
          }));

          if(result == true)
          {
            updateListView();
          }
    }
  
  // seventh one: Update list view
  void updateListView()
    {
      final Future<Database> dbFuture = databaseHelper.initialiseDatabase();
      dbFuture.then((database)
      {
        Future<List<Checkin>> checkinListFuture = databaseHelper.getCheckinList();
        checkinListFuture.then((checkinList)
        {
          setState(() {
            this.checkinList = checkinList;
            this.count = checkinList.length;
          });
        });
      });
    }
    
    // eighth one: Logout
    void _logout () async
      {
         var res = await callAPi().getData('logout');   
         var body = json.decode(res.body); 
         if(body['success'])
          {
            SharedPreferences localStorage = await SharedPreferences.getInstance();
            localStorage.remove('user');
            localStorage.remove('token');
            Navigator.push(
              context, 
              new MaterialPageRoute(
                builder: (context)=> Login()));          
          }
        
      }

      void _getUserInfo() async
   {
     SharedPreferences localStorage = await SharedPreferences.getInstance();
     var userJason = localStorage.getString('user');
     var user = json.decode(userJason);
     setState(() {
       userData = user;
     });
   }

}

