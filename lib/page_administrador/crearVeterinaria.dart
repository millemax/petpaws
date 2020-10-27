import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petpaws/providers/ubicacion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';



class CrearVeterinaria extends StatefulWidget {

  /* final GeoPoint latlong;
  CrearVeterinaria(this.latlong); */

  @override
  _CrearVeterinariaState createState() => _CrearVeterinariaState();
}

class _CrearVeterinariaState extends State<CrearVeterinaria> {
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController descripCtrl = new TextEditingController();
  TextEditingController direccionCtrl = new TextEditingController();
  TextEditingController direCtrl = new TextEditingController();

  TextEditingController responCtrl = new TextEditingController();
  TextEditingController correoCtrl = new TextEditingController();
  TextEditingController telefonoCtrl = new TextEditingController();
  TextEditingController contrasenaCtrl = new TextEditingController();



  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  List dias=['Lunes','Martes','Miercoles','Jueves','Viernes','Sabado','Domingo'];
  List horas=['00:00AM','01:00AM','02:00AM','03:00AM','04:00AM','05:00AM','06:00AM','07:00AM','08:00AM','09:00AM','10:00AM','11:00AM','12:00PM','01:00PM','02:00PM','03:00PM','04:00PM','05:00PM','06:00PM','07:00PM','08:00PM','09:00PM','10:00PM','11:00PM'];

  //variables para los dias
  int _value = 0;
  int _value1= 4;

  //variables para las horas
  int  _horainicio= 8;
  int  _horafinal= 17;

  //vavriable para la imagen

  File  _image;
  File  _logo;

  final picker = ImagePicker();


  @override
  void initState() { 
   
    super.initState();
    
  }
  







  //funcion para obtener las imagenes de la camara
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

    Future getLogo() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _logo = File(pickedFile.path);
    });
  }


  @override
  Widget build(BuildContext context) {

    final ubicacioninfo= Provider.of<Ubicacioninfo>(context);

    return Container(
            
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal:20),
            child: formulario(ubicacioninfo),
        

      );
    
  }


  Widget formulario(ubicacioninfo){
    return SingleChildScrollView(
      child: Form(
        
        key: _formKey,
        child: Column(
          
          
          children: [

            SizedBox(height: 20),
            TextFormField(              
              controller: nombreCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.store_mall_directory),
                labelText: 'Nombre de la veterinaria',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un nombre';
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
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              maxLines: 4,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingrese una descripcion';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 10),
            TextFormField(
              controller: direccionCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.store_mall_directory),
                labelText: 'Dirección',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              
              validator: (value) {
                if (value.isEmpty) {
                  return 'Ingrese una direccion';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 10),
            TextFormField(              
              controller: responCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person_outline),
                labelText: 'Nombre del responsable',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Por favor ingrese un responsable';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 10),
            TextFormField(              
              controller: correoCtrl,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.email),
                labelText: 'correo del responsable',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
                Pattern pattern =r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regex = new RegExp(pattern);
                if (!regex.hasMatch(value)) {
                  return 'Por favor ingrese un correo valido';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 10),
            TextFormField(              
              controller: contrasenaCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                labelText: 'Contraseña del responsable',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              obscureText: true,
              validator: (value) {
                if (value.length > 6) {
                  return 'contraseña debe ser mayor a 6 caracteres';
                } else {
                  return null;
                }
              },
            ),

            SizedBox(height: 10),
            TextFormField(              
              controller: telefonoCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'telefono de responsable',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
                if (value.length > 9) {
                  return 'telefono valido';
                } else {
                  return null;
                }
              },
            ),





            SizedBox(height: 10),
            Row(
              children: [
                Text('Dias de atencion:',
                    style: TextStyle(
                      fontSize: 15,
                    )),
              ],
            ),
            SizedBox(height: 5),
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
                          child: Text('lunes'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('martes'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('miercoles'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('jueves'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('viernes'),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text('sabado'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('domingo'),
                          value: 6,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('a'),
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
                          child: Text('Lunes'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('Martes'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('Miercoles'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('Jueves'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('Viernes'),
                          value: 4,
                        ),

                        DropdownMenuItem(
                          child: Text('Sabado'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('Domingo'),
                          value: 6,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _value1 = value;
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
                Text('horarios de atencion:',
                    style: TextStyle(
                      fontSize: 15,
                    )),
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
                      value: _horainicio,
                      items: [
                        DropdownMenuItem(
                          child: Text('00:00AM'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('01:00AM'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('02.00AM'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('03:00AM'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('04:00AM'),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text('05:00AM'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('06:00AM'),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text('07:00AM'),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text('08:00AM'),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text('09:00AM'),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00AM'),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00AM'),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Text('12:00PM'),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Text('1:00PM'),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Text('2:00PM'),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Text('3:00PM'),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text('4:00PM'),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Text('5:00PM'),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Text('6:00PM'),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Text('7:00PM'),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Text('8:00PM'),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text('9:00PM'),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00PM'),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00PM'),
                          value: 23,
                        ),
                        

                      ],
                      onChanged: (value) {
                        setState(() {
                          _horainicio = value;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text('a'),
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
                      value: _horafinal,
                      items: [
                        DropdownMenuItem(
                          child: Text('00:00AM'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('01:00AM'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('02.00AM'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('03:00AM'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('04:00AM'),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text('05:00AM'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('06:00AM'),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text('07:00AM'),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text('08:00AM'),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text('09:00AM'),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00AM'),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00AM'),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Text('12:00PM'),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Text('1:00PM'),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Text('2:00PM'),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Text('3:00PM'),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text('4:00PM'),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Text('5:00PM'),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Text('6:00PM'),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Text('7:00PM'),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Text('8:00PM'),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text('9:00PM'),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00PM'),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00PM'),
                          value: 23,
                        ),
                        
                        
                      ],
                      onChanged: (value) {
                        setState(() {
                          _horafinal = value;
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
                Text("Portada :", style: TextStyle(fontSize: 15)),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: _image == null
                              ? Image.asset('assets/images/plus.png', height: 50)
                              : Image.file(_image, height: 100),
                        ),
                      ),
                  


                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text("Logo :", style: TextStyle(fontSize: 15)),
              ],
            ),

            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    getLogo();
                  },
                  child: Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: _logo == null
                              ? Image.asset('assets/images/logo.png', height: 50)
                              : Image.file(_image, height: 100),
                        ),
                      ),
                  


                ),
              ],
            ),

             SizedBox(height: 10),
            Row(
              children: [
                Text("Ubicacion :", style: TextStyle(fontSize: 15)),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'obtenerubicacion');
                  },
                  child: Card(
                        elevation: 10,
                        child: Container(
                          padding: EdgeInsets.all(20),
                          child: _logo == null
                              ? Image.asset('assets/images/icomarker.png', height: 50)
                              : Image.file(_image, height: 100),
                        ),
                      ),
                  


                ),
              ],
            ),
            





          ]

        ),


      ),
    );

  }



  main() async{

    var image= await uploadImage();
    var logo = await uploadLogo();

    
  }

  createUser(){
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: correoCtrl.text, password:contrasenaCtrl.text)
    .then((value) {
      
      FirebaseFirestore.instance.collection('users').doc(value.user.uid).set({
        'correo': correoCtrl.text,
        'estado':'true',
        'nombre': responCtrl.text, 
        'rol': 'veterinario',
        'telefono':telefonoCtrl.text,
      }).then((resp){
        


      });


    });  

  }

  //funcion para cargar la imagen a firestore y recuerar la url
  Future<String> uploadImage() async {
    final StorageReference postImgRef =
        FirebaseStorage.instance.ref().child('icons');
    var timeKey = DateTime.now();

    //carguemos a storage
    final StorageUploadTask uploadTask =
        postImgRef.child(timeKey.toString() + ".png").putFile(_image);

    // recuperamos la  url esperamos que termine de cargar
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    final String urlimage = imageUrl.toString();

    return urlimage;
   
  }

   //funcion para cargar la imagen a firestore y recuerar la url
 Future<String>  uploadLogo() async {
    final StorageReference postImgRef =
        FirebaseStorage.instance.ref().child('icons');
    var timeKey = DateTime.now();

    //carguemos a storage
    final StorageUploadTask uploadTask =
        postImgRef.child(timeKey.toString() + ".png").putFile(_logo);

    // recuperamos la  url esperamos que termine de cargar
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();   
      
    

    final String urllogo = imageUrl.toString();

    return urllogo;

  }

  createVeterinaria(){
     FirebaseFirestore.instance.collection('veterinarias').add(
      {
        'descripcion':descripCtrl.text,
        'direccion':direccionCtrl.text,
        'horario':dias[_value]+'-'+dias[_value1],
        'horarioatencion':horas[_horainicio]+'-'+horas[_horafinal],
        'imagen':'',
        'logo':'',
        'nombre':nombreCtrl.text,
        'ubicacion':'',
      }
      ); 

  }

}