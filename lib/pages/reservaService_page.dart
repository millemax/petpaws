import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:petpaws/pages/calendar_reservation_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ReservaService extends StatefulWidget {
  ReservaService({Key key}) : super(key: key);

  @override
  _ReservaServiceState createState() => _ReservaServiceState();
}

class _ReservaServiceState extends State<ReservaService> {
//---------wavess-------
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
  }) {
    return WaveWidget(
      config: config,
      backgroundColor: backgroundColor,
      size: Size(
        double.infinity,
        150.0,
      ),
      waveAmplitude: 0,
    );
  }
  //-----fin   waves------

  //----
  var correo;
  var nombres;
  var celular;
  void initState() {
    getData();
    super.initState();
  }

  //----------variables importantes para reserva
  //--fecha de reserva/hora inicio de reserva
  var fechaReserva;
  var horaInicio;

  DateTime fecha;

  var idservicio;
  var idveterinaria;
  var nombreServicio;
  var precio;
  var nombreveterinaria;

  TextEditingController nameduenoCtrl = new TextEditingController();
  TextEditingController emailCtrl = new TextEditingController();
  TextEditingController namemascotaCtrl = new TextEditingController();
  TextEditingController celularCtrl = new TextEditingController();

  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  //---pop on tap para volver--
  void pushRoute(BuildContext context) {
    Navigator.pop(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => CalendarPage()),
    );
  }

  //-----------DropdownButton-------------
  String _especie = 'Canino';
  int _numpets = 1;

  //------------validar usario correo

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) return '*Requerido';
    if (!regex.hasMatch(value))
      return '*Ingresa un correo valido';
    else
      return null;
  }

  bool _autovalidate = false;

  // ----------------------validar nombre
  String nombreduenoValidator(String value) {
    Pattern patronNombre =
        r'^[a-zA-ZàáâäãåąčćęèéêëėįìíîïłńòóôöõøùúûüųūÿýżźñçčšžÀÁÂÄÃÅĄĆČĖĘÈÉÊËÌÍÎÏĮŁŃÒÓÔÖÕØÙÚÛÜŲŪŸÝŻŹÑßÇŒÆČŠŽ∂ð ,.-]+$';
    RegExp regExpName = new RegExp(patronNombre);
    if (value.isEmpty) return '*Requerido';
    if (!regExpName.hasMatch(value))
      return 'Nombre no es correcto';
    else
      return null;
  }

//-----validar nombre mascota
  String nombremascotaValidator(String value) {
    if (value.isEmpty) return '*Requerido';
    if (value.length >= 10)
      return 'Escriba un nombre corto';
    else
      return null;
  }

  //-----------------NUMERO TELEFONICO validar-----

  String phoneValidator(String value) {
    Pattern patronNumero = r'^[9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]';
    RegExp regExpName = new RegExp(patronNumero);
    if (value.isEmpty) return '*Requerido';
    if (!regExpName.hasMatch(value))
      return 'Ingrese un número válido';
    else
      return null;
  }

  //---funciona para recuperar datos de usuario /nombres/correo/celular
  getData() async {
    final String id = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get()
        .then((value) {
      correo = value.data()['correo'];
      nombres = value.data()['nombre'];
      celular = value.data()['telefono'];
      setState(() {
        nameduenoCtrl.text = nombres;
        emailCtrl.text = correo;
        celularCtrl.text = celular;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //-----

    //--funcion recibir datos enviados de perfilveterinarai veterinaria
    final List prodData = ModalRoute.of(context).settings.arguments;
    nombreServicio = prodData[0];
    horaInicio = prodData[1];

    fecha = prodData[2];
    //--convetir fecha datetime a formato general d/m/a
    fechaReserva = DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(fecha);

    final durationCita = prodData[3];
    idservicio = prodData[4];
    idveterinaria = prodData[5];
    precio = prodData[6];
    nombreveterinaria = prodData[7];
    //----metodo recuperar datos de usuario nombre/correo/telefono

    print("-------------------------");
    print("correo:$correo");
    print("correo:$celular");
    print("correo:$nombres");
    print("la fecha:$fecha");
    print("fechareserva:$fechaReserva");
    print("precioservicio:$precio");

    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: SafeArea(

          //--------la columana contenedorrr
          child: Stack(
        children: [
          titulo(),
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: ListView(
              children: [
                Form(
                  key: _formKey,
                  autovalidate: _autovalidate,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
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
                                  nombreServicio,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "$durationCita minutos",
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
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  fechaReserva,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  horaInicio,
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
                        padding: EdgeInsets.only(top: 10, right: 20, left: 15),
                        child: Container(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: celularCtrl,
                            decoration: InputDecoration(
                              labelText: "Celular",
                              hintText: "Celular",
                              //----llama los iconos declarados
                              icon: Icon(
                                Icons.phone_android,
                                color: Theme.of(context).primaryColor,
                                size: 30,
                              ),
                            ),
                            validator: phoneValidator,
                          ),
                        ),
                      ),

                      //--------Nombre del dueño---
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: TextFormField(
                          controller: nameduenoCtrl,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.person_outline),
                            labelText: "Nombre dueño",
                            hintText: "Nombres dueño",
                          ),
                          validator: nombreduenoValidator,
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
                          validator: emailValidator,
                        ),
                      ),
                      //--------Nombre del dueño---
                      Padding(
                        padding: EdgeInsets.only(top: 20, left: 15, right: 15),
                        child: TextFormField(
                          controller: namemascotaCtrl,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                            ),
                            prefixIcon: Icon(Icons.pets),
                            labelText: "Nombre Mascota",
                            hintText: "Nombre Mascota",
                          ),
                          validator: nombremascotaValidator,
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
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('2'),
                                        value: 2,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('3'),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('4'),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('5'),
                                        value: 5,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('6'),
                                        value: 6,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('7'),
                                        value: 7,
                                      ),
                                      DropdownMenuItem(
                                        child: Text('8'),
                                        value: 8,
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
                                solicitarcita();
                              }
                            },
                            child: Text('Reservar',
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
          )
        ],
      )),
    );
  }

  void solicitarcita() {
    //--convitiendo a fecha datetime a formato unix
    var fechaunix = fecha.toUtc().millisecondsSinceEpoch;

    if (_formKey.currentState.validate()) {
      final String id = FirebaseAuth.instance.currentUser.uid;
      FirebaseFirestore.instance.collection('reservas').add({
        'usuario': id,
        'veterinaria': idveterinaria,
        'servicio': idservicio,
        'fechareservaunix': fechaunix,
        'fechainicioreserva': fechaReserva,
        'horainicioreserva': horaInicio,
        'celular': celularCtrl.text,
        'correo': emailCtrl.text,
        'nombredueno': nameduenoCtrl.text,
        'nombremascota': namemascotaCtrl.text,
        'especie': _especie,
        'numeromascotas': _numpets,
        'nombreservicio': nombreServicio,
        'precio': precio,
        'nombreveterinaria': nombreveterinaria,
      }).then((value) => {
            AwesomeDialog(
              context: context,
              animType: AnimType.SCALE,
              dialogType: DialogType.SUCCES,
              body: Center(
                child: Text(
                  ' En hora buena. Ya tienes una reserva',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
              title: 'Felicidades',
              btnOkOnPress: () {
                //------remplazar todas la rutas e ir a perfil usuario
                Navigator.pushReplacementNamed(context, 'HomeVeterinarias');
              },
            )..show()
          });
    }
  }

  //---titulo encabezado de la seccion---
  Widget titulo() {
    return Container(
      child: Stack(
        children: [
          _buildCard(
            config: CustomConfig(
              colors: [
                /* Colors.deepPurpleAccent,
              Colors.deepPurple[400],
              Colors.deepPurple[100],
              Colors.white, */
                Colors.white70,
                Colors.white54,
                Colors.white30,
                Colors.white,
              ],
              durations: [32000, 21000, 18000, 5000],
              heightPercentages: [0.31, 0.35, 0.40, 0.41],
            ),
            backgroundColor: Colors.deepPurpleAccent[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----WIDGET REGRESO A PERFIL VETERINARIA---
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runSpacing: 1.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 18,
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  right: 150,
                ),
                child: Text(
                  "Solicitar cita",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
