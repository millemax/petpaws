import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsuriosList extends StatefulWidget {
  UsuriosList({Key key}) : super(key: key);

  @override
  _UsuriosListState createState() => _UsuriosListState();
}

class _UsuriosListState extends State<UsuriosList> {

  


  @override
  Widget build(BuildContext context) {

     CollectionReference users = FirebaseFirestore.instance.collection('users');
     
    return StreamBuilder(
      stream: users.snapshots(),
      builder: (_, snapshot){
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
              width: MediaQuery.of(context).size.width * 0.95,
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];

                  return Card(
                      elevation: 5,
                      child: ListTile(
                      title: Text(data.data()['correo']),
                      subtitle: Text(data.data()['nombre']),
                      trailing:  GestureDetector(
                        onTap: () {
                          
                          suspender(data.id);
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: data.data()['estado']==true ? Colors.green : Colors.red,
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(
                                    2.0, 2.0), // shadow direction: bottom right
                              )
                            ],
                          ),
                          child: Icon(
                            Icons.power_settings_new,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          );
        }
      }

    );
  }

 suspender(String id){

   final fire= FirebaseFirestore.instance.collection('users');

    fire.doc(id).get().then((value) {
     if (value.data()['estado']==true) {
    
        fire.doc(id).update({
          'estado': false
        });

      
       
     } else {
       fire.doc(id).update({
         'estado': true
       });
       


     }
   });


  



 }




}

