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
        backgroundColor: Color(0xFF6600FF),
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

  
  

  //---------------------no-------
}
