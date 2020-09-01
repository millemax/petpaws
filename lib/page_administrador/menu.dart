import 'package:flutter/material.dart';

class MenuAdministrador extends StatefulWidget {
  MenuAdministrador({Key key}) : super(key: key);

  @override
  _MenuAdministradorState createState() => _MenuAdministradorState();
}

class _MenuAdministradorState extends State<MenuAdministrador> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('hola soy el administrador')
      ),
      body: Center(
        child: Text('adminsitrador'),
      ),
       
    );
  }
}