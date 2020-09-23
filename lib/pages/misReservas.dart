import 'package:flutter/material.dart';
//--waves---
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
//--slimy card
import 'package:slimy_card/slimy_card.dart';

class MisReservas extends StatefulWidget {
  MisReservas({Key key}) : super(key: key);

  @override
  _MisReservasState createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFFFFFF),
        body: Stack(
          children: [
            titulo(),
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: ListView(
                children: <Widget>[
                  SlimyCard(
                    topCardWidget: ContainerTop(),
                    bottomCardWidget: ContainerBottom(),
                  ),
                ],
              ),
            )
          ],
        ),
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
}

class ContainerTop extends StatelessWidget {
  const ContainerTop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("hola windito"),
    );
  }
}

class ContainerBottom extends StatelessWidget {
  const ContainerBottom({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("como estas"),
    );
  }
}
