import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:petpaws/page_administrador/crearVeterinaria.dart';
import 'package:petpaws/page_administrador/usuariosPage.dart';
import 'package:petpaws/page_administrador/veterinariasPage.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MenuAdministrador extends StatefulWidget {
  MenuAdministrador({Key key}) : super(key: key);

  @override
  _MenuAdministradorState createState() => _MenuAdministradorState();
}

class _MenuAdministradorState extends State<MenuAdministrador> {
  //---------waves-------
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

  //-----------------------
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
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
                        heightPercentages: [0.35, 0.36, 0.38, 0.41],
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, left: 10),
                      child: Row(
                        children: [
                          Icon(Icons.menu, color: Colors.white),
                          
                          
                          Padding(
                            padding: const EdgeInsets.only(left: 100),
                            child: Text('Administrador', style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.bold)),
                          ),
                        ]
                      ),
                    ),
                  
                ]
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 85.0),
              child: Container(
                child: _getPage(currentPage),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Colors.grey[300],
        tabs: [
          TabData(iconData: Icons.store, title: "Veterinarias"),
          TabData(iconData: Icons.add_box, title: "Crear veterinaria"),
          TabData(iconData: Icons.supervised_user_circle, title: "Usuarios")
        ],
        initialSelection: 0,
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
    );
  }

//funcion para navegar entre las distintas paginas
  _getPage(int currentPage) {
    switch (currentPage) {
      case 0:
        return Container(child: VeterinariasList());

        break;

      case 1:
        return CrearVeterinaria();

        break;

      case 2:
        return Container(
          child: UsuriosList(),
        );

        break;
      default:
    }
  }
}
