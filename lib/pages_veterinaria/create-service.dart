import 'package:flutter/material.dart';

class CreateServices extends StatefulWidget {
  CreateServices({Key key}) : super(key: key);

  @override
  _CreateServicesState createState() => _CreateServicesState();
}

class _CreateServicesState extends State<CreateServices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Servicios')

      ),

      body: Center(
        child: Text('Crear Servicios'),
      ),
       
    );
  }
}