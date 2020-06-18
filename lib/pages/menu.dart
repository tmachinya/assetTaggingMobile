import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.grey[200],
    appBar: AppBar(
      title: Text('Sangana Africa'),
      backgroundColor: Colors.green[600],
    ));
  }
}

