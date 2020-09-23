import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveDemoHomePage extends StatefulWidget {
  @override
  _WaveDemoHomePageState createState() => _WaveDemoHomePageState();
}

class _WaveDemoHomePageState extends State<WaveDemoHomePage> {
  _buildCard({
    Config config,
    Color backgroundColor = Colors.transparent,
  }) {
    return WaveWidget(
      config: config,
      backgroundColor: backgroundColor,
      size: Size(
        double.infinity,
        200.0,
      ),
      waveAmplitude: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFFFFFFF),
      body: Center(
          child: Stack(
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Text('hi'),
                  _buildCard(
                    config: CustomConfig(
                      colors: [
                        Colors.white70,
                        Colors.white54,
                        Colors.white30,
                        Colors.white,
                      ],
                      durations: [32000, 21000, 18000, 5000],
                      heightPercentages: [0.35, 0.36, 0.38, 0.41],
                    ),
                    backgroundColor: Colors.blue[600],
                  ),
                ],
              ),
            ],
          ),
        ],
      )),
    );
  }
}
