import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CreateServices extends StatefulWidget {
  CreateServices({Key key}) : super(key: key);

  @override
  _CreateServicesState createState() => _CreateServicesState();
}

class _CreateServicesState extends State<CreateServices> {

  TextEditingController nameCtrl= new TextEditingController();
  TextEditingController precioCtrl= new TextEditingController();
  TextEditingController descripCtrl= new TextEditingController();


  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

 int _value =60;
 int _value1=0;
 int _aforo=1;

final servicearray= new List();

 //variables para la camara 
File _image;
final picker = ImagePicker();


//funcion para obtener las imagenes de la camara
Future getImage() async {
  final pickedFile= await picker.getImage(source: ImageSource.gallery);
  setState(() {
    _image = File(pickedFile.path);
  });
}



 


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crear Servicio')

      ),

      body: Container(
        padding: EdgeInsets.symmetric(horizontal:20),
        child: formulario(),
      ),
       
    );
  }


  Widget formulario(){
    return SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            SizedBox(height: 20),
            TextFormField(    
              controller: nameCtrl,                    
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.store_mall_directory),
                labelText: 'Nombre del servicio',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
                
              ),
              validator: (value){
                if (value.isEmpty) {
                  return 'Por favor ingrese un nombre';
                  
                } else {

                  return null;
                }
              },

              
            ),
            SizedBox(height: 10),


             TextFormField(     
               controller: precioCtrl,                   
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Precio en soles',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(40)
                ),
                
              ),
              validator: (value){
                if (value.isEmpty) {
                  return 'Por favor ingrese un precio';
                  
                } else {

                  return null;
                }
              },

              
            ),
            SizedBox(height: 10),


             TextFormField(             
              controller: descripCtrl,            
              decoration: InputDecoration(              
                labelText: 'Descripción',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                
              ),
              maxLines: 4,
              validator: (value){
                if (value.isEmpty) {
                  return 'Ingrese una descripcion';
                  
                } else {

                  return null;
                }
              },

              
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text('Duracion de cita :',style: TextStyle(fontSize:15,)),
              ],
            ),
            
             Row(
               children: [
                 Container(                  

                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: DropdownButton(                     
                             iconSize: 40,                   
                             value: _value,
                             items: [     
                               DropdownMenuItem(
                                  child: Text('0 horas'),
                                  value:0,                     
                                ),                         
                                DropdownMenuItem(
                                  child: Text('1 hora'),
                                  value:60,                     
                                ),
                                DropdownMenuItem(
                                  child: Text('2 horas'),  
                                  value:120,                   
                                ),
                                DropdownMenuItem(
                                  child: Text('3 horas'), 
                                  value:180,                    
                                ),
                                DropdownMenuItem(
                                  child: Text('4 horas'), 
                                  value:240,                   
                                ),
                                
                             ],
                              onChanged: (value){
                                setState(() {
                                  _value=value;
                                });
                              },
                             ),
                         ),
                       ),

                  SizedBox(width: 10),

                  Container(                  

                         decoration: BoxDecoration(
                           border: Border.all(color: Colors.black),
                           borderRadius: BorderRadius.circular(10),
                         ),
                         child: Padding(
                           padding: const EdgeInsets.only(left: 10),
                           child: DropdownButton(                     
                             iconSize: 40,                   
                             value: _value1,
                             items: [     
                               DropdownMenuItem(
                                  child: Text('0 minutos'),
                                  value:0,                     
                                ),                         
                                DropdownMenuItem(
                                  child: Text('15 minutos'),
                                  value:15,                     
                                ),                               
                                DropdownMenuItem(
                                  child: Text('30 minutos'), 
                                  value:30,                    
                                ),
                                DropdownMenuItem(
                                  child: Text('45 minutos'), 
                                  value:45,                   
                                ),
                                
                             ],
                              onChanged: (value){
                                setState(() {
                                  _value1=value;
                                });
                              },
                             ),
                         ),
                       ),
                  

               ],
             ),
             SizedBox(height: 10),
             Row(
                children: [
                Text('Aforo por cita :',style: TextStyle(fontSize:15,)),
                 ],
             ),

             Row(
               children: [
                 Container(                  

                             decoration: BoxDecoration(
                               border: Border.all(color: Colors.black),
                               borderRadius: BorderRadius.circular(10),
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 10),
                               child: DropdownButton(                     
                                 iconSize: 40,                   
                                 value: _aforo,
                                 items: [     
                                   DropdownMenuItem(
                                      child: Text('1'),
                                      value:1,                     
                                    ),                         
                                    DropdownMenuItem(
                                      child: Text('2'),
                                      value:2,                     
                                    ),                               
                                    DropdownMenuItem(
                                      child: Text('3'), 
                                      value:3,                    
                                    ),
                                    DropdownMenuItem(
                                      child: Text('4'), 
                                      value:4,                   
                                    ),
                                    
                                 ],
                                  onChanged: (value){
                                    setState(() {
                                      _aforo=value;
                                    });
                                  },
                                 ),
                             ),
                           ),
               ],

             ),





            SizedBox(height: 12),
            Row(
              children: [
                Text("Icono :",style:TextStyle(fontSize:15) ),
              ],            
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    getImage();
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
                      padding:EdgeInsets.all(20),
                      child: _image == null
                      ?Image.asset('assets/images/plus.png', height: 50)
                      :Image.file(_image, height: 100),
                    ),
                    
               ),
                ),
                
              ],
            ),

            SizedBox(height: 25),
            RaisedButton(
               padding: EdgeInsets.symmetric(horizontal:30, vertical:15),
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
               color: Color(0xFFED278A),
               onPressed: (){
                 if (_formKey.currentState.validate()) {
                   print('nombre ${nameCtrl.text}');
                   print('nombre ${precioCtrl.text}');
                   print('nombre ${descripCtrl.text}');
                   print('tiempo de cita ${_value+_value1} minutos');
                   

                  


                      
                   
                 }
                 
               },
               child:Text('Crear Servicio', style: TextStyle(color: Colors.white, fontSize:18)),
              ),




          ],
        ),
      ),
    );
  }
}
