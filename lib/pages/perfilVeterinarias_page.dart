import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PerfilVeterinariaPage extends StatefulWidget {
  @override
  _PerfilVeterinariaPageState createState() => _PerfilVeterinariaPageState();
}

class _PerfilVeterinariaPageState extends State<PerfilVeterinariaPage> {
  var veterinaria;
  @override
  Widget build(BuildContext context) {
    final prodData = ModalRoute.of(context).settings.arguments;
    return SafeArea(
      child: Scaffold(
        floatingActionButton: Column(
          children: [
            SizedBox(height: 70),
            Row(
              children: [
                SizedBox(
                  width: 25,
                ),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  backgroundColor: Color(0xFF6600FF),
                  child:
                      Icon(Icons.chevron_left, color: Colors.white, size: 50),
                ),
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

  getData() async {
    await FirebaseFirestore.instance
        .collection('veterinarias')
        .doc('Z9Pk1RL7ZyPcuHWZDcbW')
        .get()
        .then((value) {
      print(value.data()['nombre']);
    });
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
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: MediaQuery.of(context).size.height * 0.785,
                decoration: BoxDecoration(
                  color: Colors.white,
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
                ));
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
                child: CircularProgressIndicator(),
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
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                data.data()['descripcion'],
                                textAlign: TextAlign.center,
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
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
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
        Navigator.pushNamed(context, 'calendarPage', arguments: [
          data.data()['nombre'],
          data.data()['duracioncita'],
          data.data()['horarios'],
          data.id,
          prodData,
          data.data()['precio'],
          veterinaria,
        ]);
      },
      child: Card(
          color: Color(0XFFFDD400),
          elevation: 4,
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
                      Padding(
                        padding: const EdgeInsets.only(right: 6.5, bottom: 10),
                        child: Container(
                          height: 40,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            /* color: Theme.of(context).primaryColor, */
                            border: Border.all(
                                color: Color(0xffed278a), width: 0.8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "S/.",
                                style: TextStyle(
                                    color: Color(0xffed278a),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 10),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 1),
                                child: Text(
                                  '$precioservicio.00',
                                  style: TextStyle(
                                      color: Color(0xffed278a),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          ),
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
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Image.network(
                    data.data()['icono'],
                    width: 80,
                    height: 80,
                    color: Colors.white,
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
