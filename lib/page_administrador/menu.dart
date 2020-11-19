import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:petpaws/page_administrador/crearVeterinaria.dart';
import 'package:petpaws/page_administrador/usuariosPage.dart';
import 'package:petpaws/page_administrador/veterinariasPage.dart';
import 'package:petpaws/screens/inicio.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class MenuAdministrador extends StatefulWidget {
  MenuAdministrador({Key key}) : super(key: key);

  @override
  _MenuAdministradorState createState() => _MenuAdministradorState();
}

class _MenuAdministradorState extends State<MenuAdministrador> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  //...variables para recuperar datos el usuarios
  String _correoUser = '';
  String _nombreUser = '';
  bool _estadouser = false;

  @override
  void initState() {
    super.initState();
    getUser();
  }

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

  getUser() {
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      setState(() {
        _correoUser = value.data()['correo'];
        _nombreUser = value.data()['nombre'];
        _estadouser = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        drawer: _estadouser == false
            ? Container()
            : ClipPath(
                clipper: _ContainerCurvoPainter(),
                child: _drawer(context),
              ),
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                child: Stack(children: [
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
                    child: Row(children: [
                      GestureDetector(
                        onTap: () {
                          _scaffoldKey.currentState.openDrawer();
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 100),
                        child: Text('Administrador',
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ]),
                  ),
                ]),
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
      ),
    );
  }

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: ListView(
          // Important: Remove any padding from the ListView.

          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(_nombreUser),
              accountEmail: Text(_correoUser),
              currentAccountPicture: CircleAvatar(
                backgroundColor:
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Colors.blue
                        : Colors.white,
                child: Text(
                  _nombreUser[0].toUpperCase(),
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.73,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                          width: 1, color: Theme.of(context).primaryColor),
                    )),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text('Cerrar sesion'),
                        trailing: Icon(Icons.exit_to_app),
                        onTap: () {
                          FirebaseAuth.instance.signOut().then((value) => {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Inicio()),
                                )
                              });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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

//-----bibujar el curvo del container sidebar---------
class _ContainerCurvoPainter extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.moveTo(0, 0);
    path.lineTo(size.width * 0.95, 0);
    path.quadraticBezierTo(
        size.width, size.height / 4, size.width, size.height / 2);
    path.quadraticBezierTo(
        size.width, size.height / 1.5, size.width * 0.92, size.height);

    path.lineTo(0, size.height);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
