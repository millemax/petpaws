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
        backgroundColor: Color(0xFF6600FF),
        body: ListView(
          children: [
            Column(
              children: [
                titulo(),
                listaVeterinarias(),
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

//---------------cuerpo donde va a estar las veterianrias--------

  Widget listaVeterinarias() {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        /* borderRadius: BorderRadius.only(
          topLeft: Radius.circular(75.0),
        ), */
      ),
      child: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: 18.0),
              //--------------------contenedor de una veterinaria------
              veterinaria(),
              veterinaria1(),
              veterinaria2(),
            ],
          )
        ],
      ),
    );
  }

  //------------------veterinaria-------
  Widget veterinaria() {
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
                          "assets/images/perros2.png",
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
