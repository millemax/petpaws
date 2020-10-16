
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VeterinariasList extends StatefulWidget {
  VeterinariasList({Key key}) : super(key: key);

  @override
  _VeterinariasListState createState() => _VeterinariasListState();
}

class _VeterinariasListState extends State<VeterinariasList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top:10),
      child: listas(),
    );
  }


  Widget listas() {

    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('veterinarias').snapshots(),
        builder: (_, snapshot) {
          if (!snapshot.hasData){
            return Container(
              width: MediaQuery.of(context).size.width * 0.93,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.85,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot data = snapshot.data.documents[index];
                  return GestureDetector(
                      onTap: () {
                        /* Navigator.pushNamed(context, 'perfilveterinarias',
                            arguments: data.id); */
                      },
                      child: Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          cards(data),
                        ],
                      ));
                },
              ),
            );
          }
        });
   }

   Widget cards(data){

     return Card(
       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
       elevation: 10,       
       child: Container(
         width: MediaQuery.of(context).size.width * 0.95,
         child: Row(         
           children: [
             Column(
               children: [
                 Image.network(data.data()['logo'], height: 80, width: 80),
               ]
             ),
             Column(
               children: [
                 Text(data.data()['nombre'], style: TextStyle(fontWeight: FontWeight.bold)),
                 SizedBox(height:5),
                 Container(
                   padding: EdgeInsets.only(left: 20),
                   width: MediaQuery.of(context).size.width * 0.72,
                   child: Text(data.data()['descripcion'],
                    
                    

                    ),
                 ),
                 SizedBox(height: 10),
                 Row(
                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                   children: [

                     SizedBox(width: 120),
                     
                     GestureDetector(
                       onTap: () {
                         print('suspender');
                         suspenderUser(data.id);
                       },
                         child: Container(                       
                         padding: EdgeInsets.symmetric(horizontal:8 , vertical: 8),
                         decoration: BoxDecoration(
                           color: Colors.grey[300],
                           borderRadius: BorderRadius.circular(10),
                           boxShadow: [
                             BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), // shadow direction: bottom right
                             )
                           ],                        
                           ),
                         child: Icon(Icons.power_settings_new) ,
                       ),
                     ),
                     SizedBox(width: 10),


                   // boton para actualizar una veterinaria 
                     GestureDetector(
                       onTap: () {
                         print("actualizar");
                       },
                         child: Container(                       
                         padding: EdgeInsets.symmetric(horizontal:8 , vertical: 8),
                         decoration: BoxDecoration(
                           color: Colors.grey[300],
                           borderRadius: BorderRadius.circular(10),  
                           boxShadow: [
                             BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), // shadow direction: bottom right
                             )
                           ],                        
                           ),
                         child: Icon(Icons.sync) ,
                       ),
                     ),
                     SizedBox(width: 10),


                  // este es el boton para borrar
                     GestureDetector(
                       onTap: (){
                         print('borrar');
                         _showDialogDelete('¿Seguro que quiere eliminar ?', 'Esta accion hará que la veterinaria se elimine permanentemente', data.id);
                       },
                         child: Container(                       
                         padding: EdgeInsets.symmetric(horizontal:8 , vertical: 8),
                         decoration: BoxDecoration(
                           color: Colors.grey[300],
                           borderRadius: BorderRadius.circular(10),  
                           boxShadow: [
                             BoxShadow(
                                color: Colors.grey[600],
                                blurRadius: 2.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0), // shadow direction: bottom right
                             )
                           ],                        
                           ),
                         child: Icon(Icons.delete) ,
                       ),
                     ),
                    

                    
                                       
                     
                    

                   ]
                 ),

                 SizedBox(height: 10),
               ]
             ),

           ],
         ),
       )
     );
     


   }

 //show alert dialog para las notificaciones
   _showMaterialDialog(String titulo, String contenido) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: new Text(titulo),
              content: new Text(contenido),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ));
  }

  //show alert dialog para las notificaciones
   _showDialogDelete(String titulo, String contenido, String idVeterinaria) {

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: new Text(titulo),
              content: new Text(contenido),
              actions: <Widget>[
                 FlatButton(
                  child: Text('NO'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('SI'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    deleteVeterinaria(idVeterinaria);

                  },
                )
              ],
            ));
  }

//es la funcion para actualizar es estado del usuario
  suspenderUser(String id){
    var user= FirebaseFirestore.instance.collection('users').doc(id);
    user.get().then((value){
      var estado = value.data()['estado'];
      
      if (estado == true) {

          user.update({'estado': false}).then((value) {
            _showMaterialDialog('Usuario Suspendido', 'La cuenta asociada a esta veterinaria a sido suspendida.');
          }).catchError((err){

          });

        
      } else {
        if (estado == false) {
          user.update({'estado': true}).then((value) {
            _showMaterialDialog('Usuario Activado', 'La cuenta asociada ha sido activado');
          }).catchError((err){

          });

          
        }



      }
      


    }).catchError((err){
      _showMaterialDialog('Error', 'No podemos ejecutar esta accion');

    });   

  }


// funcion para eliminar la veterinaria
  deleteVeterinaria(String idveterinaria){    

  /*  FirebaseFirestore.instance.collection('veterinarias').doc(idveterinaria).delete().then((value) {
        FirebaseFirestore.instance.collection('users').doc(idveterinaria).update({'estado': false}).then((resp){
             _showMaterialDialog('Eliminado','La veterinaria ha sido eliminado correctamente');

        });
    
    

  }).catchError((err){

    _showMaterialDialog('Error', 'No podemos ejecutar esta accion');


  });  */
 

}







}