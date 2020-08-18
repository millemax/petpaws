import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(

                colors: [
                  Color(0xFFD7C0F9),
                  Color(0xFFB991F6),
                  Color(0xFF822EFF),
                  Color(0xFF6600FF),
                ],
                stops: [0.1, 0.4, 0.7, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,

              ),
            ),
          ),
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 120.0,                
                ),
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'login',
                     style: TextStyle(
                       color: Colors.white,
                       fontFamily: 'OpenSans',
                       fontSize: 30.0,
                       fontWeight: FontWeight.bold,
                        )
                  
                  ),
                  SizedBox(
                    height: 30.0,                    
                  ),
                  
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Email', )
                    ],
                  ),


                  

                ],
              ),
            
              
            ),
          ),
        ],

      ),

       
    );
  }
}