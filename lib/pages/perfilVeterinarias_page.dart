import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'calendar_reservation_page.dart';

class PerfilVeterinariaPage extends StatefulWidget {
  @override
  _PerfilVeterinariaPageState createState() => _PerfilVeterinariaPageState();
}

class _PerfilVeterinariaPageState extends State<PerfilVeterinariaPage> {
  bool control = false;

  var veterinaria;
  @override
  Widget build(BuildContext context) {
    final prodData = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: Column(
          children: [
            SizedBox(height: 25),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                //-----------------------------boton de regreso a la anterior pagina
                ClipOval(
                  child: Material(
                    color: Theme.of(context).primaryColor, // button color
                    child: InkWell(
                      splashColor:
                          Theme.of(context).primaryColorLight, // inkwell color
                      child: SizedBox(
                          width: 43,
                          height: 43,
                          child: Icon(
                            Icons.chevron_left,
                            size: 43,
                            color: Colors.white,
                          )),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
        body: Stack(
          children: [cuerpoServicios(prodData)],
        ),
      ),
    );
  }

  Widget cuerpoServicios(prodData) {
    //para recibir la iagen de portada de firebase
    var portada = StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('veterinarias')
          .doc(prodData)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        DocumentSnapshot data = snapshot.data;
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
            height: MediaQuery.of(context).size.height * 0.5,
            width: double.infinity,
            child: Stack(
              children: [
                Image.network(
                  data.data()['imagen'],
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
                Container(
                  color: Color.fromRGBO(0, 0, 0, 0.3),
                ),
              ],
            ),
          );
        }
      },
    );
//cards en grupo de los servicios
    var cards = StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('veterinarias')
            .doc(prodData)
            .collection('servicios')
            .snapshots(),
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
              width: MediaQuery.of(context).size.width * 0.93,
              height: MediaQuery.of(context).size.height * 0.66,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];

                  return card(data, prodData);
                },
              ),
            );
          }
        });
//cuerpo donde van a ir los cards de servicios

    var contenedorCards = StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('veterinarias')
            .doc(prodData)
            .snapshots(),
        builder: (_, snapshot) {
          DocumentSnapshot data = snapshot.data;
          veterinaria = data.data()['nombre'];
          print('************************************');
          print(veterinaria);

          if (!snapshot.hasData) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.93,
              child: Center(
                child: Image.asset("assets/images/perrito.gif"),
              ),
            );
          } else {
            return ListView(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 170),
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60),
                      ),
                    ),
                    child: Column(
                      children: [
                        //-----------------titulo de veterinaria ----
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10, left: 10, bottom: 7),
                          child: Column(
                            children: [
                              Icon(
                                Icons.arrow_drop_up,
                                color: Theme.of(context).primaryColor,
                                size: 35,
                              ),
                              Text(
                                data.data()['nombre'],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                data.data()['descripcion'],
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 13),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                  top: 20,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "NUESTROS SERVICIOS",
                                      style: TextStyle(
                                          color: Color(0xff0100ca),
                                          fontSize: 17,
                                          /* fontWeight: FontWeight.bold, */
                                          fontFamily: 'Pumpkin-Soup',
                                          letterSpacing: 1),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        cards,
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
        });

    return Stack(
      children: [portada, contenedorCards],
    );
  }

  Widget card(DocumentSnapshot data, prodData) {
    var precioservicio = data.data()['precio'].toString();
    print("*+++++++++++++++++++");
    print("$precioservicio");

    return GestureDetector(
      onTap: () {
        print("esta es la veterinaria: $veterinaria");
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CalendarPage(
                      data.data()['nombre'],
                      data.data()['duracioncita'],
                      data.data()['horarios'],
                      data.id,
                      prodData,
                      data.data()['cupo'],
                      data.data()['precio'],
                      veterinaria,
                    )));
      },
      child: Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      //-----------container para mostrar precio de servicios -----
                      Padding(
                        padding: const EdgeInsets.only(right: 6.5, bottom: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "S/.",
                              style: TextStyle(
                                  color: Color(0xffFE5F55),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10),
                            ),
                            Text(
                              '$precioservicio.00',
                              style: TextStyle(
                                  color: Color(0xffFE5F55),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: Text(
                      data.data()['nombre'],
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors. /*white. withOpacity(0.85) */ black,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.network(
                    data.data()['icono'],
                    width: MediaQuery.of(context).size.width * 0.15,
                    color: Colors.black.withOpacity(0.55),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
