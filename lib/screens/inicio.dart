import 'package:flutter/material.dart';

class Inicio extends StatefulWidget {
  Inicio({Key key}) : super(key: key);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          imagenFondo(),
          fondooscuro(),
          logo(),
        ]
      )

       
    );
  }

  Widget imagenFondo(){
    return Container(
            height: double.infinity,
            width: double.infinity,
            
             child: Image.asset('assets/images/dog.jpg', fit: BoxFit.cover),
            
          );
  }

  Widget fondooscuro() {
    return Container(
      color: Color.fromRGBO(102, 0, 255, 90)
    );
  }

  Widget logo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Image.asset('assets/images/logoblanco.png', height:250)],
          )
      ]
    );
  }
}