import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HomeVeterinariasPage extends StatefulWidget {
  @override
  _HomeVeterinariasPageState createState() => _HomeVeterinariasPageState();
}

class _HomeVeterinariasPageState extends State<HomeVeterinariasPage> {
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

  //------------------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          titulo(),
          Padding(
            padding: const EdgeInsets.only(top: 80.0),
            child: listas(),
          ),
        ],
      ),
    ));
  }

  Widget listas() {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('veterinarias').snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.93,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, 'perfilveterinarias',
                            arguments: data.id);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cards(data),
                        ],
                      ));
                },
              ),
            );
          }
        });
  }

  Widget cards(DocumentSnapshot data) {
    //imagen de fondo con contenedor
    var fondo = Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(data.data()['imagen']))),
    );
    //capa semioscura con transparencia
    var capa = Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.93,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
              colors: [
                Color.fromRGBO(0, 0, 0, 0.6),
                Color.fromRGBO(0, 0, 0, 0.3),
              ],
              stops: [
                0.2,
                0.5
              ],
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter)),
    );

    //nombre de veterinaria
    var info = Container(
      margin: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height * 0.25,
      width: MediaQuery.of(context).size.width * 0.93,
      padding: EdgeInsets.all(5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            child: Text(
              data.data()['nombre'],
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    //info del horaraio situado en el pie del card
    var piecard = Container(
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.only(top: 20),
        height: MediaQuery.of(context).size.height * 0.25,
        width: MediaQuery.of(context).size.width * 0.93,
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Row(
            children: [
              SizedBox(width: 15),
              Text(data.data()['horario'],
                  style: TextStyle(fontSize: 15, color: Color(0xFFFDD400))),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SizedBox(
                width: 10,
              ),
              Icon(
                Icons.access_alarm,
                color: Colors.white,
              ),
              Text(
                data.data()['horarioatencion'],
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
        ]));
    //logo del card
    var logo = Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.93,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
                radius: 40, backgroundImage: NetworkImage(data.data()['logo']))
          ],
        ));

    return Stack(
      children: [fondo, capa, info, piecard, logo],
    );
  }

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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "VETERINARIAS",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1),
                ),
              ),

              //----campo de busqueda-a
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runSpacing: 1.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      left: 18,
                    ),
                    child: Badge(
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        '4',
                        style: TextStyle(color: Colors.white),
                      ),
                      badgeColor: Color(0xffed278a),
                      child: GestureDetector(
                        child: Image.asset(
                          "assets/images/calen.png",
                          scale: 17,
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, 'MisReservas');
                        },
                      ),
                    ),
                  ),
                  Text(
                    "Mis reservas",
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
