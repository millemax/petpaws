import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  //final dbref = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: (){
            _getdata();
            },
          child: Text('OBTENER DE FIREBASE')
          ) ,       
      ),
    );
  }

  _getdata() async{
    await FirebaseFirestore.instance.collection('veterinarias').get().then((data){
      print('estos son los datos $data');
      data.docs.forEach((document){
        print(document.data());


      });

    });
    
   

  }


}
