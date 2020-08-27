import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'perfilVeterinarias_page.dart';
//--
import './waves.dart';

class HomeVeterinariasPage extends StatefulWidget {
  @override
  _HomeVeterinariasPageState createState() => _HomeVeterinariasPageState();
}

class _HomeVeterinariasPageState extends State<HomeVeterinariasPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xFFAB47BC),
        body: ListView(
          children: [
            Column(
              children: [
                titulo(),
                lista(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget titulo() {
    return Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "VETERINARIAS",
            style: TextStyle(color: Colors.white),
          ),
          //----campo de busqueda-
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Icon(Icons.search),
                  Text("Busca las veterinarias"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //-----------------prueba con firestore.......................
  Widget lista() {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('veterinarias').snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(75.0),
                ),
              ),
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return veterinarys(data);
                },
              ),
            );
          }
        });
  }

  Widget veterinarys(DocumentSnapshot data) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        shadowColor: Theme.of(context).primaryColor,
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: Theme.of(context).primaryColor,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/veterinario.jpg',
              fit: BoxFit.cover,
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
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
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Veterinaria',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('"San Marcos"',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      radius: 40,
                      backgroundImage: AssetImage('assets/images/logo2.png')),
                )
              ],
            ),
            Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                      '1:00PM-10:00PM',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget veterinary(DocumentSnapshot data) {
    return Container(
      margin: EdgeInsets.all(5),
      child: Card(
        shadowColor: Color.fromRGBO(128, 0, 128, 1),
        elevation: 7,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        clipBehavior: Clip.antiAlias,
        color: Colors.white,
        child: Stack(
          children: [
            Image.asset(
              'assets/images/veterinario.jpg',
              height: 170,
              fit: BoxFit.cover,
            ),
            Container(
              height: 170,
              width: 400,
              decoration: BoxDecoration(),
            ),
            Container(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Veterinaria',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text('"San Marcos"',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.white)),
                  ],
                ),
              ),
            ),
            Positioned(
                top: 20,
                left: 260,
                child: CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage('assets/images/logo2.png'))),
            Positioned(
                top: 130,
                left: 10,
                child: Row(
                  children: [
                    Icon(
                      Icons.access_alarm,
                      color: Colors.white,
                    ),
                    Text(
                      '1PM-10PM',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

//---------------cuerpo donde va a estar las veterianrias--------

  Widget listaVeterinarias() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75.0),
        ),
      ),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 18.0),
              //--------------------contenedor de una veterinaria------
              //veterinaria(),
              veterinaria1(),
              veterinaria2(),
            ],
          )
        ],
      ),
    );
  }

  //------------------veterinaria-------
  Widget veterinaria(DocumentSnapshot data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 240,
      child: Row(
        children: [
          //---contenedor de descripcion de veterinarias--
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Veterinaria",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    data.data()['nombre'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "Horario",
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data.data()['horario'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        data.data()['direccion'],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //---contenedor de imagen de veterinarias----
          Expanded(
              child: Container(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  //--------------------imagen de la veterinaria----
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Stack(
                      children: [
                        Image.network(
                          data.data()['imagen'],
                          fit: BoxFit.contain,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 170),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Color.fromRGBO(107, 27, 154, 60),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                //-----funcion push hacia los perfiles
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => WaveDemoHomePage(),
                                    ),
                                  );
                                },
                                child: Text("Ver perfil"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    //----boton para ir al perfil de veteerinaria--
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  //------------------veterinaria-------
  Widget veterinaria1() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      height: 240,
      child: Row(
        children: [
          //---contenedor de descripcion de veterinarias--
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Veterinaria",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "LOAYZA",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        "Av. Lazaro Carrillo",
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //---contenedor de imagen de veterinarias----
          Expanded(
            child: Container(
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    //--------------------imagen de la veterinaria----
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/boxers.png",
                            fit: BoxFit.contain,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 170),
                                child: FlatButton(
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  color: Color.fromRGBO(107, 27, 154, 60),
                                  textColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PerfilVeterinariaPage(),
                                      ),
                                    );
                                  },
                                  child: Text("Ver perfil"),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      //----boton para ir al perfil de veteerinaria--
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //------------------veterinaria-------
  Widget veterinaria2() {
    return Container(
      margin: EdgeInsets.only(bottom: 100, right: 5, left: 5),
      height: 240,
      child: Row(
        children: [
          //---contenedor de descripcion de veterinarias--
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 60, bottom: 20),
              decoration: BoxDecoration(
                color: Colors.deepPurple[100],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topLeft: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Veterinaria",
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    "CAN & NINOS",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(Icons.location_on),
                      Text(
                        "Av. Lazaro Carrillo",
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          //---contenedor de imagen de veterinarias----
          Expanded(
              child: Container(
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  //--------------------imagen de la veterinaria----
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Stack(
                      children: [
                        Image.asset(
                          "assets/images/perro-1.png",
                          fit: BoxFit.contain,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 170),
                              child: FlatButton(
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                color: Color.fromRGBO(107, 27, 154, 60),
                                textColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PerfilVeterinariaPage(),
                                    ),
                                  );
                                },
                                child: Text("Ver perfil"),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    //----boton para ir al perfil de veteerinaria--
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }

  //---------------------no-------
}
