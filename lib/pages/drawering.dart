

import 'package:flutter/material.dart';
import 'package:champion/pages/drawer.dart';


class navDrawer extends StatelessWidget {
  navDrawer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        child: Image.asset('assets/logo.png',width: 80, height: 80,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Sangana Africa', style: TextStyle(color: Colors.white,fontSize: 20.0),),
                    )
                  ],
                ),
              )),
           
           CustomListTile(Icons.person,'Profile',()=>{}),
           CustomListTile(Icons.notifications,'Notifications', ()=>{}),
           CustomListTile(Icons.settings,'Settings',()=>{}),
           CustomListTile(Icons.lock,'Logout',()=>{}),
          
          ],
        ),
      ),
    );
  }
}