import 'package:champion/checkins/checkin_detail.dart';
import 'package:champion/checkins/checkin_list.dart';
import 'package:champion/models/checkin.dart';
import 'package:champion/models/inspection.dart';
import 'package:champion/pages/inspection_detail.dart';
import 'package:champion/pages/inspection_list.dart';
import 'package:flutter/material.dart';
import 'package:champion/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:champion/pages/inspection_list.dart';

void main() => runApp(Champion());


class Champion extends StatefulWidget {

  @override
  _ChampionState createState() => _ChampionState();
}

class _ChampionState extends State<Champion> {
  bool _isLoggedIn = false;

  @override
  void initState() {
    _checkIfLoggedIn();
    super.initState();
  }

   Future<void> _checkIfLoggedIn()
    async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var token = localStorage.getString('token');
      if(token !=null)
        {
          setState(() {
            _isLoggedIn = true;
          });          
        }
      // print(token);  
    }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // body: CheckinDetail(Checkin('Tongesai Machinya', '80-070509-L26', '', 2, 3, 'Black and White'), 'new Checkin'),
        // body: CheckinList(),
        // body: InspectionDetail(Inspection('Car', 'Motor Vehicle', 'June 6 2020', 1, '123456', 'Tongesai Machinya', 'Audi Q3', '90000', 'Waterfalls', 'Project Blessing', '123366pll', '236f59pkf', '2566hfof', 'hfhfu633', 'July 8 2020', ''), 'New Audit'),
        body: _isLoggedIn ? InspectionList() : Login(),
      ),
       theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
    );
  }

 
}
