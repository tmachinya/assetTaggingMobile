
import 'dart:convert';
import 'package:champion/api/api.dart';
import 'package:flutter/material.dart';
import 'package:champion/pages/login.dart';
import 'package:champion/pages/inspection_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SubmitEmail extends StatefulWidget {
  @override
  _SubmitEmailState createState() => _SubmitEmailState();
}

class _SubmitEmailState extends State<SubmitEmail> {
  
  TextEditingController requestemailController = TextEditingController(); 

  bool _loading = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
     body: Center(
       child: Padding(
         padding: const EdgeInsets.only(top: 90, left: 30,right: 30),
         child: ListView(
           children: <Widget>[           
                        //Email textfield  
            TextField
            (               
                onChanged: (value){
                debugPrint('Pane Zvachinja munomu');                    
              },
              controller: requestemailController,
              decoration: InputDecoration(
                labelText: 'Email',                 
                prefixIcon: new Icon(
                          Icons.email,
                          color: Colors.green,
                        ),
                        
                      border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.green)
                      ), 

                      focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(color: Colors.green)
                      ),              
                       
              ),
            ),

            

            //Login Button 
              Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0, 0.0),
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    _loading? 'creating':'Submit Request Password Reset Email',                                         
                  ),                
                  onPressed: _loading ? null: _handleSubmit
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
                            'Go back to login',
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
  void _handleSubmit () async
    {   
      var data = {        
        'email' : requestemailController.text,        
      };
      print(data);
      var res = await callAPi().postData(data, 'sendPasswordResetLink');
      var body = jsonDecode(res.body);
      print(body);

      // if(body['success'])
      //   {
      //       setState(() {
      //   _loading = true;
      // });
      //     SharedPreferences localStorage = await SharedPreferences.getInstance();
      //     localStorage.setString('token', body['token']);
      //     localStorage.setString('user', json.encode(body['user']));   

      //     // var userJason = localStorage.getString('user');
      //     // var user = json.decode(userJason);
      //     // print(user);  

      //      Navigator.push(
      //     context, new MaterialPageRoute(
      //     builder: (context) => InspectionList()));
      //   }
          
      //     setState(() {
      //   _loading = false;
      // });

     
    }
}