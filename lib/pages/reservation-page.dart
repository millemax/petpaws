import 'package:flutter/material.dart';

class Reservation extends StatefulWidget {
  Reservation({Key key}) : super(key: key);

  @override
  _ReservationState createState() => _ReservationState();
}

class _ReservationState extends State<Reservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservar'),
      ),
      body: Center(
        child: Text('Soy la pagina de reservas'),
      ),

      
       
    );
  }
}