import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MisReservas extends StatefulWidget {
  MisReservas({Key key}) : super(key: key);

  @override
  _MisReservasState createState() => _MisReservasState();
}

class _MisReservasState extends State<MisReservas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Stack(children: [
              Container(
                child: WaveWidget(
                  duration: 1,
                  config: CustomConfig(
                    gradients: [
                      [Color(0xFF3A2DB3), Color(0xFF3A2DB1)],
                      [Color(0xFFEC72EE), Color(0xFFFF7D9C)],
                      [Color(0xFFfc00ff), Color(0xFF00dbde)],
                      [Color(0xFF396afc), Color(0xFF2948ff)]
                    ],
                    durations: [35000, 19440, 10800, 6000],
                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    blur: MaskFilter.blur(BlurStyle.inner, 5),
                    gradientBegin: Alignment.centerLeft,
                    gradientEnd: Alignment.centerRight,
                  ),
                  waveAmplitude: 1.0,
                  backgroundColor: Colors.white,
                  size: Size(double.infinity, 50.0),
                ),
              ),
              Text(
                "Mis resesrvas",
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
