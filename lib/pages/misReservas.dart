import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//--waves---
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
//--slimy card
import 'package:slimy_card/slimy_card.dart';

class MisReservas extends StatefulWidget {
  @override
  _MisReservasState createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  int numreserva;

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
                child: numreserva == 0
                    ? Center(child: _alertasinreserva())
                    : Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: Image.asset("assets/images/perrito.gif"),
                        ),
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
              width: MediaQuery.of(context).size.width * 0.95,
              color: Theme.of(context).cardColor,
              topCardWidget: _containerTop(reservasRecuperado[index]),
              bottomCardWidget: _containerBottom(reservasRecuperado[index]),
            ),
          ],
        );
      },
    );
  }

  //------------contenedor de la parte superior---
  Widget _containerTop(data) {
    print(data['nombreveterinaria']);
    var precioservicio = data['precio'].toString();
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xffffffff), width: 0.8),
        ),
        child: Stack(
          children: [
            Image.asset("assets/images/iii.png"),
            Padding(
              padding:
                  const EdgeInsets.only(top: 100.0, bottom: 10.0, right: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "S/.",
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Color(0xffFE5F55),
                        ),
                      ),
                      Text(
                        '$precioservicio.00',
                        /*  data.data()['precio'], */
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Color(0xffFE5F55),
                        ),
                      ),
                    ],
                  ),
                  /* ), */
                ],
              ),
            ),
            //----------------fecha inicio reserva ------------
            Padding(
              padding: const EdgeInsets.only(
                top: 60.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100.0),
                    bottomRight: Radius.circular(20.0),
                  ),
                  color: Theme.of(context).cardColor,
                ),
                width: MediaQuery.of(context).size.width * 0.22,
                height: MediaQuery.of(context).size.height * 0.15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 1.5),
                        child: Text(
                          data['fechainicioreserva'].toUpperCase(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).accentColor,
                              fontSize: 13,
                              letterSpacing: 1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Column(
              children: [
                //---------------veterinaria / dueño-----------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: ListTile(
                          title: Text(
                            data['nombreveterinaria'].toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Theme.of(context).accentColor,
                                letterSpacing: 1),
                          ),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(left: 90.0),
                            child: Text(
                              data['nombredueno'],
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 150.0, top: 10.0),
                  child: Column(
                    children: [
                      //--------------inicio reserva--------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Hora:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data['horainicioreserva'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      //--------------nombre servicio--------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Servicio:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data['nombreservicio'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                                letterSpacing: 1),
                          ),
                        ],
                      ),
                      //--------------nombre mascota-------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Mascota:",
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data['nombremascota'],
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: Colors.black,
                                letterSpacing: 1),
                          ),
                        ],
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
            color: Theme.of(context).primaryColorLight,
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
                    style: TextStyle(color: Colors.black, fontSize: 18)),
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
            backgroundColor: Theme.of(context).primaryColor,
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
                  right: 140,
                ),
                child: Text(
                  "Mis Reservas",
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
      if (value.docs.length == 0) {
        setState(() {
          numreserva = value.docs.length;
        });
      } else {
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
      }
    });
  }

  Widget _alertasinreserva() {
    return Container(
        color: Colors.white,
        width: MediaQuery.of(context).size.width * 0.5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'NO TIENE RESERVAS',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black45, wordSpacing: 5),
            ),
            //---------
            Image.asset(
              "assets/images/PER.png",
              width: MediaQuery.of(context).size.width,
            ),
            //---------
            RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 60, vertical: 8),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Colors.greenAccent[200],
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Volver',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 17)),
            ),
          ],
        ));
  }
}
