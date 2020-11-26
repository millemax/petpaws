import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';
import 'package:petpaws/screens/inicio.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:map_launcher/map_launcher.dart';

class HomeVeterinariasPage extends StatefulWidget {
  @override
  _HomeVeterinariasPageState createState() => _HomeVeterinariasPageState();
}

class _HomeVeterinariasPageState extends State<HomeVeterinariasPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //...variables para recuperar datos el usuarios
  String _correoUser = '';
  String _nombreUser = '';
  bool _estadouser = false;

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

  //---------variables para recuperar la cantidad de reservas actuales
  //variable para obtener la fecha hora actual
  String _fecha;
  int _timeunix;
  int numReserva;

  List reservasRecuperado = [];

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
    getUser();
  }

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

  //-----------
  //------------------------
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

  Drawer _drawer(BuildContext context) {
    return Drawer(
      child: Container(
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
              decoration: BoxDecoration(
                  border: Border(
                top:
                    BorderSide(width: 1, color: Theme.of(context).primaryColor),
              )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text('Cerrar sesion'),
                  trailing: Icon(Icons.exit_to_app),
                  onTap: () async {
                    try {
                      await googleSignIn.signOut();
                      print('sign with google');
                      FirebaseAuth.instance.signOut().then((value) => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Inicio()),
                            )
                          });
                      setState(() {});
                    } catch (error) {
                      print(error);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
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
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: Image.asset("assets/images/perrito.gif"),
                ),
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
                  print('holiiiiii');
                  print(data.data()['ubicacion'].latitude);
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
              spreadRadius: 2,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ],
          color: Colors.grey[100],
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
            height: MediaQuery.of(context).size.height * 0.2,
            child: Text(
              data.data()['nombre'],
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1,
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
                  style: TextStyle(
                      fontSize: 17, color: Theme.of(context).canvasColor)),
            ],
          ),
          SizedBox(
            height: 8,
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
              SizedBox(
                width: 5,
              ),
              Text(
                data.data()['horarioatencion'],
                style: TextStyle(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height * 0.0025),
              )
            ],
          ),
        ]));
    //logo del card
    var logo = Container(
        height: MediaQuery.of(context).size.height * 0.25,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * 0.93,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 40,
                    backgroundImage: NetworkImage(data.data()['logo'])),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: () {
                    openMapsSheet(
                        context,
                        data.data()['ubicacion'].latitude,
                        data.data()['ubicacion'].longitude,
                        data.data()['nombre']);
                  },
                  child: Image.asset(
                    'assets/images/ubimap.png',
                    scale: 2.5,
                  ),
                ),
              ],
            )
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
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 1.0,
                  ),
                  child: Text(
                    "VETERINARIAS",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17.0,
                        fontFamily: 'Pumpkin-Soup',
                        letterSpacing: 2),
                  ),
                ),
                Wrap(
                  direction: Axis.vertical,
                  alignment: WrapAlignment.center,
                  runSpacing: 1.0,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        left: 26,
                      ),
                      child: Badge(
                        animationType: BadgeAnimationType.scale,
                        badgeContent: numReserva == null
                            ? Text('0')
                            : Text(
                                numReserva.toString(),
                                style: TextStyle(color: Colors.black87),
                              ),
                        badgeColor: Theme.of(context).canvasColor,
                        child: GestureDetector(
                          child: Image.asset(
                            "assets/images/reserva1.png",
                            height: 23,
                          ),
                          onTap: () {
                            Navigator.pushNamed(context, 'MisReservas');
                          },
                        ),
                      ),
                    ),
                    Text(
                      "Mis reservas",
                      style: TextStyle(
                          color: Colors.white,
                          height: MediaQuery.of(context).size.height * 0.002),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

//--------------------------funcion para obtener reservas actuales
  getData() async {
    print('*******************************');
    print(_timeunix);

    final String id = FirebaseAuth.instance.currentUser.uid;
    await FirebaseFirestore.instance
        .collection('reservas')
        .where("usuario", isEqualTo: id)
        .where('fechareservaunix', isGreaterThanOrEqualTo: _timeunix)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        reservasRecuperado.add(element.data());
        print(reservasRecuperado);
      });
      setState(() {
        numReserva = reservasRecuperado.length;
      });
      print('CONTADOOOOOORRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR');
      print(reservasRecuperado.length);
    });
  }

//esta es la funcion para mostrar el mapa
  openMapsSheet(context, latitude, longitude, nombre) async {
    try {
      final coords = Coords(latitude, longitude);
      final title = nombre;
      final availableMaps = await MapLauncher.installedMaps;

      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Container(
                child: Wrap(
                  children: <Widget>[
                    for (var map in availableMaps)
                      ListTile(
                        onTap: () => map.showMarker(
                          coords: coords,
                          title: title,
                        ),
                        title: Text(map.mapName),
                        leading: Image(
                          image: map.icon,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    } catch (e) {
      print(e);
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
