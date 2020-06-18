
import 'dart:convert';
import 'package:champion/api/api.dart';
import 'package:flutter/material.dart';
import 'package:champion/pages/login.dart';
import 'package:champion/pages/inspection_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
     body: Center(
       child: Padding(
         padding: const EdgeInsets.only(top: 90, left: 30,right: 30),
         child: ListView(
           children: <Widget>[    
            //  Name textfield
                    TextField(               
               
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Name',  
                focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.green)
                         ),
                prefixIcon: new Icon(
                          Icons.person,
                          color: Colors.green,
                        )            
                       
              ),
                      ),   

                        //Email textfield  
                      TextField(             
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',  
                focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.green)
                         ),
                prefixIcon: new Icon(
                          Icons.email,
                          color: Colors.green,
                        )            
                       
              ),
                      ),

                      // Password Textfield
                      TextField(              
            controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText:'Password', 
                focusedBorder: UnderlineInputBorder(
                         borderSide: BorderSide(color: Colors.green)
                         ),
                prefixIcon: new Icon(
                          Icons.lock,
                          color: Colors.green,
                        )                            
              ),
            ),

            //Login Button 
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    _loading? 'creating':'Signup',                                         
                  ),                
                  onPressed: _loading ? null: _handleLogin
                  ),
              ),
              // Already have an account
                 Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => Login()));
                        },
                        child: Center(
                          child: Text(
                            'already have an account',
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
       ),
     ),
   
    );
  }

  //  handling login
  void _handleLogin () async
    {   
      var data = {
        'name' : nameController.text,
        'email' : emailController.text,
        'password' : passwordController.text,
      };

      var res = await callAPi().postData(data, 'signup');
      var body = jsonDecode(res.body);

      if(body['success'])
        {
            setState(() {
        _loading = true;
      });
          SharedPreferences localStorage = await SharedPreferences.getInstance();
          localStorage.setString('token', body['token']);
          localStorage.setString('user', json.encode(body['user']));   

          // var userJason = localStorage.getString('user');
          // var user = json.decode(userJason);
          // print(user);  

           Navigator.push(
          context, new MaterialPageRoute(
          builder: (context) => InspectionList()));
        }
          
          setState(() {
        _loading = false;
      });

     
    }
}