import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



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
      child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'perfilveterinarias');

          },
          child: Card(
          shadowColor: Colors.black,
          elevation: 7,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          clipBehavior: Clip.antiAlias,
          color: Theme.of(context).primaryColor,
          child: Stack(
            children: [
              Image.network(
                data.data()['imagen'],
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
                      Container(
                        
                        width:200,
                        child: Text(data.data()['nombre'],
                            maxLines: 2,
                            textAlign:TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.white,)),
                      ),
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
                        backgroundImage: NetworkImage(data.data()['logo']) ),
                  )
                ],
              ),
              Column(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.17,
                  ),
                  Row(                  
                    children: [
                      SizedBox(width:15),
                      Text(data.data()['horario'], style: TextStyle(fontSize: 15, color: Color(0xFFFDD400))),
                    ],
                  ),
                  SizedBox(height: 10),
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
                        data.data()['horarioatencion'],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  
  

  //---------------------no-------
}
