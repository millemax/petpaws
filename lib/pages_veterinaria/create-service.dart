import 'package:flutter/material.dart';

class CreateServices extends StatefulWidget {
  CreateServices({Key key}) : super(key: key);

  @override
  _CreateServicesState createState() => _CreateServicesState();
}

class _CreateServicesState extends State<CreateServices> {
  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  int _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Crear Servicio')),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: formulario(),
      ),
    );
  }

  Widget formulario() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.store_mall_directory),
              labelText: 'Nombre del servicio',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor ingrese un nombre';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.attach_money),
              labelText: 'Precio en soles',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Por favor ingrese un nombre';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Descripción',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            maxLines: 4,
            validator: (value) {
              if (value.isEmpty) {
                return 'Ingrese una descripcion';
              } else {
                return null;
              }
            },
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Text('Duracion de cita :',
                  style: TextStyle(
                    fontSize: 15,
                  )),
            ],
          ),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    iconSize: 40,
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text('0 horas'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text('1 hora'),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text('2 horas'),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text('3 horas'),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Text('4 horas'),
                        value: 5,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(width: 10),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: DropdownButton(
                    iconSize: 40,
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text('0 minutos'),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text('15 minutos'),
                        value: 2,
                      ),
                      DropdownMenuItem(
                        child: Text('20 minutos'),
                        value: 3,
                      ),
                      DropdownMenuItem(
                        child: Text('30 minutos'),
                        value: 4,
                      ),
                      DropdownMenuItem(
                        child: Text('45 minutos'),
                        value: 5,
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Text("Icono :", style: TextStyle(fontSize: 15)),
            ],
          ),
          Row(
            children: [
              Card(
                  elevation: 10,
                  child: Container(
                      padding: EdgeInsets.all(50),
                      child: Stack(children: [
                        Image.asset('assets/images/plus.png', height: 50),
                      ]))),
            ],
          ),
          SizedBox(height: 25),
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color(0xFFED278A),
            onPressed: () {},
            child: Text('Crear Servicio',
                style: TextStyle(color: Colors.white, fontSize: 18)),
          ),
        ],
      ),
    );
  }
}
