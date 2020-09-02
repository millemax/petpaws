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
      body: Center(
        child: SafeArea(
          child: Stack(
            children: [
              fondoService(),
              campoFormulario(),
            ],
          ),
        ),
      ),
    );
  }
  //---------------------imagen y color de fondo---------

  Widget fondoService() {
    return Container(
      padding: EdgeInsets.only(bottom: 500),
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Stack(
        children: [
          Image.asset(
            'assets/images/perritonegro.gif',
            width: double.infinity,
          ),
          Container(),
        ],
      ),
    );
  }

//----------------------------campo de los formularios-------
  Widget campoFormulario() {
    return ListView(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 250),
          child: Container(
            height: 800,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(60),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                children: [
                  //--------------------titulo para rellenar formulario--
                  Text(
                    "RELLENE EL FORMULARIO",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  campoCard(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget campoCard() {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Container(
        height: 500,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          elevation: 10,
          child: ListView(
            children: [
              //---------------nombre del dueño
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    prefixIcon: Icon(Icons.person_outline),
                    labelText: "Nombre dueño",
                    hintText: "Nombres sdueño",
                  ),
                ),
              ),
              //---------------celular del propietario---
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextFormField(
                  controller: TextEditingController(),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(40)),
                    prefixIcon: Icon(Icons.smartphone),
                    labelText: "Celular",
                    hintText: "Celular",
                  ),
                ),
              ),
              //---------------direccion  del propietario---
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    prefixIcon: Icon(Icons.location_on),
                    labelText: "Direccion",
                    hintText: "Direccion",
                  ),
                ),
              ),
              //-------------------nombre del paciente---
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                child: TextField(
                  controller: TextEditingController(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    prefixIcon: Icon(Icons.live_help),
                    labelText: "Paciente",
                    hintText: "Nombre paciente",
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
