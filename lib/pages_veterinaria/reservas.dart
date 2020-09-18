import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ReservasPage extends StatefulWidget {
  ReservasPage({Key key}) : super(key: key);

  @override
  _ReservasPageState createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reservas')
      ),
      body: cards(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'crearservico');
        },
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF6600FF),
      ),
       
    );
  }

  Widget cards(){
    final String id = FirebaseAuth.instance.currentUser.uid;

    return StreamBuilder(      
      stream: FirebaseFirestore.instance.collection('veterinarias').doc(id).collection('servicios').snapshots(),
      builder: (_ , snapshot){
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
              
              width: MediaQuery.of(context).size.width*0.93,
              height: MediaQuery.of(context).size.height * 0.85,
              
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index){
                  DocumentSnapshot data= snapshot.data.documents[index];
                  return card(data);

                },
                 ),
            ),
          );
        }

      }
    
    );
  }

  Widget card(DocumentSnapshot data){

    return GestureDetector(
          child: Card(  
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,       
        child: Column(
          children: [
            SizedBox(height: 10),
            Text(      
              data.data()['nombre'], 
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize:18, fontWeight: FontWeight.bold)
              ),

              SizedBox(height: 20),
            
            Image.network(data.data()['icono'], height:80, color: Colors.white),
          ],
        ),      
        color: Color(0xFFFDD400) ,
      ),

      onTap: () {
        Navigator.pushNamed(context, 'calendarevents', arguments: data.id);
      },
    );

  }
}