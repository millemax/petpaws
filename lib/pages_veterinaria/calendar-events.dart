import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MyCalendar extends StatefulWidget {
  MyCalendar({Key key}) : super(key: key);

  @override
  _MyCalendarState createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
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

  CalendarController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //inicalizamos el calendario
    _controller = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    final serviceId = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
          /* appBar: AppBar(title: Text('Reservaciones')), */
          body: Stack(
        children: [
          titulo(),
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFFED278A), width: 2),
                    ),
                    child: TableCalendar(
                      calendarController: _controller,
                      locale: 'es_ES',
                      calendarStyle: CalendarStyle(
                        todayColor: Color(0xFF6600FF),
                        selectedColor: Color(0xFFFDD400),
                      ),
                      onDaySelected: (date, events) {
                        print(date.toIso8601String());
                        print("EL ID SERVICE : " + serviceId);
                        //getData(serviceId);
                      },
                      initialCalendarFormat: CalendarFormat.week,
                      //availableCalendarFormats: {CalendarFormat.week: 'Semana'},
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }

  //funcion para recuperar todas las reservas

  Widget getData(String serviceId) {
    print('obteniendo a la bd');

    final String id = FirebaseAuth.instance.currentUser.uid;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('reservas').snapshots(),
      builder: (_, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            width: MediaQuery.of(context).size.width * 0.93,
            child: Center(child: CircularProgressIndicator()),
          );
        } else {
          return Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.85,
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return card(data);
                },
              ),
            ),
          );
        }
      },
    );
  }

  Widget card(data) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
          leading: Icon(Icons.access_alarm),
          title: Text(data.data()['nombredueno'],
              style: TextStyle(color: Colors.black))),
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
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
}
