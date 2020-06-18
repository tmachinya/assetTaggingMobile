import 'dart:convert';
import 'package:champion/api/api.dart';
import 'package:champion/pages/inspection_list.dart';
import 'package:flutter/material.dart';
import 'package:champion/pages/signup.dart';
import 'package:champion/pages/submit_email.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isloading = false;

  TextEditingController mailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(label: 'Close', onPressed: () {}),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 80, left: 30, right: 30),
          child: ListView(
            children: <Widget>[
              Image(
                image: AssetImage('assets/sangana.png'),
                width: 100,
                height: 100,
              ),
              TextField(
                controller: mailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    prefixIcon: new Icon(
                      Icons.email,
                      color: Colors.green,
                    )),
              ),
              TextField(
                // onChanged: (value){
                //   debugPrint('Pane Zvachinja munomu');
                // },
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    labelText: 'Password',
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.green)),
                    prefixIcon: new Icon(
                      Icons.lock,
                      color: Colors.green,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
                child: RaisedButton(
                    color: Colors.green,
                    child: Text(
                      'Login',
                    ),
                    onPressed: _isloading ? null : _login),
              ),
              ////////////   new account///////////////
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => Signup()));
                      },
                      child: Center(
                        child: Text(
                          'Create new Account',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => SubmitEmail()));
                      },
                      child: Center(
                        child: Text(
                          'Forgot My Password',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 10.0,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _isloading = true;
    });

    var data = {
      'email': mailController.text,
      'password': passwordController.text,
    };

    var res = await callAPi().postData(data, 'login');    
    var body = json.decode(res.body);
    // print(body);
    if (body['success']) {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));

      // var userJason = localStorage.getString('user');
      // var user = json.decode(userJason);
      // print(user);

      Navigator.push(context,
          new MaterialPageRoute(builder: (context) => InspectionList()));
    } else {
      _showMsg(body['error']);
    }

    setState(() {
      _isloading = false;
    });
  }
}
