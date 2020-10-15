import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//--waves---
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
//--slimy card
import 'package:slimy_card/slimy_card.dart';
//---badges notification
import 'package:badges/badges.dart';

import 'calendar_reservation_page.dart';

class MisReservas extends StatefulWidget {
  @override
  _MisReservasState createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  //variable para obtener la fecha hora actual
  String _fecha;
  int _timeunix;

  List reservasRecuperado = [];
  bool control = false;
  @override
  void initState() {
    super.initState();

    //variables de fecha y hora actual
    var fecha = DateTime.now();
    var horaactual = fecha.toUtc().millisecondsSinceEpoch;

    setState(() {
      _fecha = DateFormat('EEEE, d MMMM, ' 'yyyy', 'es_ES').format(fecha);
      _timeunix = horaactual;
    });

    getData();
  }

  DocumentSnapshot data;
  //-----waves------
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

  @override
  Widget build(BuildContext context) {
    print(reservasRecuperado);
    print("contandooooooooooooooooooooooooooooooo");
    print(reservasRecuperado.length);
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: SafeArea(
        child: control == false
            ? Container(
                color: Colors.white,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: [
                  titulo(),
                  Padding(
                    padding: EdgeInsets.only(top: 90.0),
                    child: reservaCards(),
                  )
                ],
              ),
      ),
    );
  }

  //recuperamos los servicios de la base de datos de firebase
  Widget reservaCards() {
    return ListView.builder(
      itemCount: reservasRecuperado.length,
      itemBuilder: (context, index) {
        //data = snapshot.data.documents[index];
        return Column(
          children: <Widget>[
            SizedBox(height: 10),
            SlimyCard(
              topCardHeight: 195,
              bottomCardHeight: 150,
              width: 380,
              color: Colors.grey,
              topCardWidget: _containerTop(reservasRecuperado[index]),
              bottomCardWidget: _containerBottom(reservasRecuperado[index]),
            ),
          ],
        );
      },
    );
  }

  //-------SlimyCard
  /*  Widget slimyCard(DocumentSnapshot data) {
    return Column(
      children: <Widget>[
        SizedBox(height: 10),
        SlimyCard(
          topCardHeight: 195,
          bottomCardHeight: 150,
          width: 380,
          color: Colors.grey,
          topCardWidget: _containerTop(),
          bottomCardWidget: _containerBottom(),
        ),
      ],
    );
  } */

//------------contenedor de la parte superior---
  Widget _containerTop(data) {
    print(data['nombreveterinaria']);
    var precioservicio = data['precio'].toString();
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffffffff), width: 0.8),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 105,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //-----------------container circular --
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfffdd400),
                      //---widget para convertir en circulo
                      shape: BoxShape.circle,
                    ),
                    height: 62,
                    width: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "S/.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: Colors.purpleAccent[300],
                          ),
                        ),
                        Text(
                          '$precioservicio.00',
                          /*  data.data()['precio'], */
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                            color: Color(0xffed278a),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 3, left: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Fecha de Reserva",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Text(
                        data['fechainicioreserva'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //------------servicio----
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Servicio:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 21,
                      ),
                      Text(
                        data['nombreservicio'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                //---------duracion de servicio----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Veterinaria:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['nombreveterinaria'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //-----------hora de servicio -----
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hora de inicio del servicio:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['horainicioreserva'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //------------celular------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Celular del dueño:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 53,
                      ),
                      Text(
                        data['celular'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //-------------nombre del dueño
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nombre del dueño:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 48,
                      ),
                      Text(
                        data['nombredueno'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //-------------Nombre de la mascota
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Nombre de mascota:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Text(
                        data['nombremascota'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //-------------especie de la mascota
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Especie de mascota:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 38,
                      ),
                      Text(
                        data['especie'],
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
                //-------------correo
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Número de mascotas:",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 15),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Text(
                        "1",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.white,
                            letterSpacing: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ));
  }

//-----------contenedor de laparte superior---
  Widget _containerBottom(data) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0xffffffff), width: 0.8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RaisedButton(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Color(0xfffdd400),
            onPressed: () {
              Navigator.pushNamed(context, 'CalendarPostegar', arguments: [
                data['veterinaria'],
                data['servicio'],
                data['nombreveterinaria'],
                data['nombreservicio'],
                data['idreserva'],
                data['nombremascota'],
              ]);
            },
            child: Row(
              children: [
                Text('Postergar',
                    style: TextStyle(
                        color: Colors.deepPurpleAccent[400], fontSize: 18)),
              ],
            ),
          ),
        ],
      ),
    );
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
                  "Reservaciones",
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

  getData() async {
    print('*******************************');
    print(_timeunix);
    var contador = 0;
    var tamano = 0;

    final String id = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('reservas')
        .where("usuario", isEqualTo: id)
        .where('fechareservaunix', isGreaterThanOrEqualTo: _timeunix)
        .get()
        .then((value) {
      tamano = value.docs.length;

      value.docs.forEach((element) {
        contador += 1;
        reservasRecuperado.add(element.data());
        print(reservasRecuperado);

        if (contador >= tamano) {
          setState(() {
            control = true;
          });
        }
      });
    });
  }
}
