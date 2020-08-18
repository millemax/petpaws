import 'package:flutter/material.dart';
//import 'package:petpaws/screens/login_screen.dart';
//import 'package:petpaws/screens/splash_screen.dart';

import 'package:petpaws/screens/inicio.dart';



void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'login iu',
      debugShowCheckedModeBanner: false,
      //home: LoginScreen(),  
      home: Inicio(),

      
    );
  }
}
