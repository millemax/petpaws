import 'package:flutter/material.dart';
import 'dart:async';
import 'package:petpaws/pages/login_page.dart';
import 'package:petpaws/pages/reservaService_page.dart';

import '../pages_veterinaria/reservas.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 11),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => ReservaService())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: <Widget>[
      imagen(),
    ]));
  }
}

Widget imagen() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    child: Image.asset('assets/images/inicio.gif', fit: BoxFit.cover),
  );
}

/* Widget imagenFondo() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    child: Image.asset('assets/images/dog.jpg', fit: BoxFit.cover),
  );
}

Widget fondooscuro() {
  return Container(color: Color.fromRGBO(102, 0, 255, 90));
}

Widget logo() {
  return Column(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset('assets/images/logoblanco.png', height: 250)
      ],
    )
  ]);
} */
