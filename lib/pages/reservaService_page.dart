import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:petpaws/pages/calendar_reservation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ReservaService extends StatefulWidget {
  ReservaService({Key key}) : super(key: key);

  @override
  _ReservaServiceState createState() => _ReservaServiceState();
}

class _ReservaServiceState extends State<ReservaService> {
  TextEditingController nameduenoCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController namemascotaCtrl = new TextEditingController();

  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  //---pop on tap para volver--
  void pushRoute(BuildContext context) {
    Navigator.pop(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => CalendarPage()),
    );
  }

  //-------
  //-----------DropdownButton-------------
  String _especie = 'Canino';
  int _numpets = 1;
  //-----------------NUMERO TELEFONICO-----
  String phoneNumber;
  String phoneIsoCode;
  bool visible = false;
  String confirmedNumber = '';

  void onPhoneNumberChange(
      String number, String internationalizedPhoneNumber, String isoCode) {
    print(number);
    setState(() {
      phoneNumber = number;
      phoneIsoCode = isoCode;
    });
  }

  onValidPhoneNumber(
      String number, String internationalizedPhoneNumber, String isoCode) {
    setState(() {
      visible = true;
      confirmedNumber = internationalizedPhoneNumber;
    });
  }
  //------------

  @override
  Widget build(BuildContext context) {
    /* final List prodData = ModalRoute.of(context).settings.arguments;
    final servicio = prodData[0];
    final hora = prodData[1];
    final fecha = prodData[2]; */
    final servicio = 'peluqueria';
    final hora = '09:54';
    final fecha = 'Lunes 21, setiembre';

    return Scaffold(
      /* appBar: AppBar(
        title: Text(
          "Solicitar cita",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Color(0xff572364)),
        ),
      ), */
      body: SafeArea(
        //-----------------container general-----
        child: Container(
          color: Color(0xff757575),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            //--------la columana contenedorrr
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //------------------container de cabecera---
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20.0),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 130),
                                child: GestureDetector(
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Color(0xffFFFFFF),
                                  ),
                                  onTap: () => pushRoute(context),
                                ),
                              ),
                              Text(
                                "Solicitar cita",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color(0xffFFFFFF)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      //---------Nombre del servicio
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  servicio,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "30 minutos",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(102, 0, 161, 0.4)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //------------------fecha de reserva--------
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.today,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fecha,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Hoy",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(102, 0, 161, 0.4)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //---------------hora de incio de al cita
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Row(
                          children: [
                            Icon(
                              Icons.schedule,
                              size: 30,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  hora,
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "Hora de inicio",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromRGBO(102, 0, 161, 0.4)),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      //--------numero de telefono---
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15),
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.start,
                          spacing: 1.0,
                          runSpacing: 10,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, right: 10),
                              child: Icon(
                                Icons.phone_android,
                                size: 30,
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: Column(
                                children: <Widget>[
                                  InternationalPhoneInput(
                                    onPhoneNumberChange: onPhoneNumberChange,
                                    initialPhoneNumber: phoneNumber,
                                    initialSelection: phoneIsoCode,
                                    enabledCountries: ['+51'],
                                    labelText: "Celular",
                                  ),
                                  SizedBox(height: 20),
                                  Visibility(
                                    child: Text(confirmedNumber),
                                    visible: visible,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //--------Nombre del dueño---
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: TextFormField(
                          controller: nameduenoCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: "Nombre dueño",
                            hintText: "Nombres sdueño",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese un nombre';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),

                      //---------correo-------
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: TextFormField(
                          controller: emailCtrl,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.email),
                            labelText: "Correo",
                            hintText: "Correo",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese un correo';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      //--------Nombre del dueño---
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: TextFormField(
                          controller: namemascotaCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.pets),
                            labelText: "Nombre Mascota",
                            hintText: "Nombre Mascota",
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Por favor ingrese un nombre';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                      //-----------------escoger especie / cupos
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 20, right: 15),
                        child: Row(
                          children: [
                            //----------opcion de especies--------
                            Column(
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 5, right: 25),
                                  child: Text("Especie de Mascota:"),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton<String>(
                                    value: _especie,
                                    onChanged: (String newValue) {
                                      setState(() {
                                        _especie = newValue;
                                      });
                                    },
                                    items: <String>[
                                      'Canino',
                                      'Felino',
                                      'Aves',
                                      'Equino',
                                      'Bovino',
                                      'Porcino',
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            //----------escoger cantidad de cupos----
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 25, bottom: 5),
                                  child: Text("Nro. de Mascotas:"),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: DropdownButton(
                                    iconEnabledColor:
                                        Theme.of(context).primaryColor,
                                    iconSize: 40,
                                    value: _numpets,
                                    items: [
                                      DropdownMenuItem(
                                        child: Text('1'),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('2'),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('3'),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('4'),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('5'),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('6'),
                                        value: 5,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('6'),
                                        value: 6,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('6'),
                                        value: 7,
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _numpets = value;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40),
                      //----------------------boton de enviar formulario--
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RaisedButton(
                            padding: EdgeInsets.symmetric(
                                horizontal: 30, vertical: 15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            color: Color(0xFFED278A),
                            onPressed: () {
                              if (_formKey.currentState.validate()) {
                                crearCita();
                              }
                            },
                            child: Text('Solicitar',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  crearCita() {
    //guardar en la bd(nommbre)

    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('veterinarias').doc(id).collection('servicios').doc(nameCtrl.text).set({
      'servicio': servicio,
      'fecha': fecha,
      'Horainicio': hora,
      'celular': phoneNumber,
      'nombredueno': nameduenoCtrl.text,
      'email': emailCtrl.text,
      'namemascota': namemascotaCtrl.text,
      'especiemascota': _especie,
      'numeromascotas': _numpets,
      /* 'duracioncita': duracion,
      'cupo': _aforo,
      'precio': int.parse(precioCtrl.text), */
    });
  }
}
