import 'package:flutter/material.dart';
import 'package:petpaws/bloc/login_bloc.dart';
import 'package:petpaws/screens/inicio.dart';
import 'package:provider/provider.dart';
//import 'package:petpaws/screens/login_screen.dart';
//import 'package:petpaws/screens/splash_screen.dart';

//import 'package:petpaws/screens/inicio.dart';

import 'package:firebase_core/firebase_core.dart';

// importamos wavesanimaction

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => LoginBloc(),
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Color(0xFF6600FF),
        ),
        title: 'login iu',
        debugShowCheckedModeBanner: false,
        //home: LoginScreen(),
        home: Inicio(),
        // home: LoginPage(),
      ),
    );
  }
}
