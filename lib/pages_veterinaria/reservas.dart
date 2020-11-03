import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petpaws/pages_veterinaria/actualizar-service.dart';
import 'package:petpaws/pages_veterinaria/calendar-events.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:badges/badges.dart';

class ReservasPage extends StatefulWidget {
  ReservasPage({Key key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  bool _estado = false;

  //el objeto que contiene cuanto tiene cada servicio
  var cantReservas = {};
  var prueba1 = {'romel': '5', 'windows': 'hola'};
  var prueba = {
    '1MU8gYWJBTHyYRHcmCv6': '1',
    '5Up6ZXj2ERJvyghxPGHc': '0',
    '81TsqrIbGxrI3C0ed9cs': '2',
    '8lLwrdzGYw7rnxh7ukdV': '0',
    'Li1iY3HZqpp8i8JgpMhP': '1',
    'RIYruWDRNuD0MsnjYPrZ': '0',
    'WLELKtLJrnsi3WZjwXcV': '0',
    'agBAeUnxZ2QCRRTwVP6x': '0',
    'gfqsZBt3KLjCjgwzVON2': '0',
    'ywAbi6WvchEpF2vnczdT': '0'
  };

  @override
  void initState() {
    obtenerservicios();

    super.initState();
  }

  //funcion para obtener los servicios
  obtenerservicios() {
    //variables de fecha y hora actual
    var fecha = DateTime.now();
    var horaactual = fecha.toUtc().millisecondsSinceEpoch;
    var contador = 0;
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('veterinarias')
        .doc(id)
        .collection('servicios')
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        contador = contador + 1;
        cantReservas[doc.id.toString()] = '';
        cantidadReservas(
            doc.id.toString(), contador, value.docs.length, horaactual);
      });
    });
  }

  //funcion para obtener la cantidad que tiene cada reserva
  cantidadReservas(String idservicio, int contar, int tamano, int horaactual) {
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('reservas')
        .where('veterinaria', isEqualTo: id)
        .where('servicio', isEqualTo: idservicio)
        .where('fechareservaunix', isGreaterThanOrEqualTo: horaactual)
        .get()
        .then((value) {
      cantReservas[idservicio] = value.docs.length.toString();

      print(cantReservas);
      print('contador, tamano' + contar.toString() + tamano.toString());
      if (contar == tamano) {
        setState(() {
          _estado = true;
        });
      }
    });
  }

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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        /* appBar: AppBar(title: Text('Reservas')), */
        body: _estado == false
            ? Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
            : Stack(
                children: [
                  titulo(),
                  Padding(
                    padding: EdgeInsets.only(top: 80.0),
                    child: cards(),
                  )
                ],
              ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'crearservico');
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).primaryColorLight,
        ),
      ),
    );
  }

//recuperamos los servicios de la base de datos de firebase
  Widget cards() {
    final String id = FirebaseAuth.instance.currentUser.uid;
    print('el id : ' + id);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('veterinarias')
            .doc(id)
            .collection('servicios')
            .snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.93,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: MediaQuery.of(context).size.height * 0.85,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot data = snapshot.data.documents[index];
                    return card(data);
                  },
                ),
              ),
            );
          }
        });
  }

  //es le card que se genera de acuerdo a los servicios que tenga
  Widget card(DocumentSnapshot data) {
    return GestureDetector(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 4,
        child: Column(
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 0.5, right: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Badge(
                        badgeContent: Text(cantReservas[data.id],
                            style: TextStyle(color: Colors.black)),
                        badgeColor: Theme.of(context).canvasColor,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.38,
                          child: Text(data.data()['nombre'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.019,
                                  fontWeight: FontWeight.bold)),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(
                            data.data()['icono'],
                            width: MediaQuery.of(context).size.width * 0.15,
                            color: Colors.black.withOpacity(0.55),
                          ),
                        ),
                        // SizedBox(height: 15),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                PopupMenuButton<int>(
                  color: Colors.white,
                  icon: Icon(Icons.more_vert, color: Color(0xffFE5F55)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  onSelected: (value) {
                    print("es el valor " + value.toString());
                    switch (value) {
                      case 1:
                        {
                          print('Actualizar');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ActualizarService(data.id)));
                        }
                        break;
                      case 2:
                        {
                          //con esta funcion se va eliminar servicio de base de datos

                          final String iud = data.id;
                          deleteservice(iud);
                        }
                        break;

                      default:
                        {
                          print('no coonozco este numero');
                        }
                        break;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 1,
                      child: Text(
                        "Actualizar",
                        style: TextStyle(
                          color: Theme.of(context).accentColor.withGreen(180),
                        ),
                      ),
                    ),
                    PopupMenuItem(
                      value: 2,
                      child: Text(
                        "Eliminar",
                        style: TextStyle(
                          color: Color(0xffFE5F55),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
      onTap: () {
        //estamos enviando el iddel servicio
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyCalendar(data.id)));
        // Navigator.pushNamed(context, 'calendarevents', arguments: data.id);
      },
    );
  }

  //esta es una funcion para borrar en la base de datos
  deleteservice(String idService) {
    final String id = FirebaseAuth.instance.currentUser.uid;

    FirebaseFirestore.instance
        .collection('veterinarias')
        .doc(id)
        .collection('servicios')
        .doc(idService)
        .delete()
        .then((value) {
      print("eliminado en la red");
    }).catchError((error) {
      print('Ha ocurrido un error');
    });
  }

  //----encabezado de la pagina ---
  Widget titulo() {
    return Container(
      child: Stack(
        children: [
          _buildCard(
            config: CustomConfig(
              colors: [
                Colors.white70,
                Colors.white54,
                Colors.white30,
                Colors.white,
              ],
              durations: [32000, 21000, 18000, 5000],
              heightPercentages: [0.31, 0.35, 0.40, 0.41],
            ),
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "Reservas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
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
