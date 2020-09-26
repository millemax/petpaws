import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:badges/badges.dart';

class ReservasPage extends StatefulWidget {
  ReservasPage({Key key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffffffff),
        /* appBar: AppBar(title: Text('Reservas')), */
        body: Stack(
          children: [
            titulo(),
            Padding(
              padding: EdgeInsets.only(top: 80.0),
              child: cards(),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, 'crearservico');
          },
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF6600FF),
        ),
      ),
    );
  }

//recuperamos los servicios de la base de datos de firebase
  Widget cards() {
    final String id = FirebaseAuth.instance.currentUser.uid;
    print('el id de san marcos'+ id);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('veterinarias')
            .doc(id)
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
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.93,
                height: MediaQuery.of(context).size.height * 0.85,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    DocumentSnapshot data = snapshot.data.documents[index];
                    return card(data);
                  },
                ),
              ),
            );
          }
        });
  }

  Widget card(DocumentSnapshot data) { 

    return GestureDetector(
      child: Badge( 
                
          badgeContent: Text('2', style: TextStyle(color: Colors.white)),
          badgeColor: Color(0xFFED278A),
          child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 5,
          child: Column(

            children: [
              SizedBox(height: 10),
              Text(data.data()['nombre'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Image.network(data.data()['icono'],
                  height: 75, color: Colors.white),
             // SizedBox(height: 15),
              Row(
                children:[
                   PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert, color: Colors.white),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 10,
                    onSelected: (value){
                    print("es el valor "+ value.toString());
                    switch (value) {
                      case 1:{
                          print('Actualizar');
                          Navigator.pushNamed(context, 'actualizarservicio');
                      }                
                      break;
                      case 2:{
                        //con esta funcion se va eliminar servicio de base de datos
                        
                        
                        final String iud = data.id;
                        deleteservice(iud);

                         
                      }                
                      break;


                      default:{
                        print('no coonozco este numero');
                      }
                      break;

                    }

                  },

                  itemBuilder: (context) => [
                        PopupMenuItem(
                          value: 1,
                          child: Text("Actualizar"),
                        ),
                        PopupMenuItem(
                          value: 2,
                          child: Text("Eliminar"),
                        ),
                      ],
                )
                  

                ]
              )


            ],
          ),
          color: Color(0xFFFDD400),
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, 'calendarevents', arguments: data.id);
      },
    );
  }

 //esta es una funcion para borrar en la base de datos
deleteservice(String idService)  {
        final String id = FirebaseAuth.instance.currentUser.uid;
           
        
        FirebaseFirestore.instance.collection('veterinarias').doc(id).collection('servicios').doc(idService).delete().then((value){
           print("eliminado en la red");
        }).catchError((error){
          print('Ha ocurrido un error');
        });
        
          
        
      

        

    }



  //----encabezado de la pagina ---
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
            backgroundColor: Colors.deepPurpleAccent[400],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                ),
                child: Text(
                  "Reservas",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }



}
