import 'package:flutter/material.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petpaws/page_administrador/menu.dart';

import 'package:petpaws/providers/ubicacion.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:geocoder/geocoder.dart';



class ActualizarVeterinaria extends StatefulWidget {
  final String id;
  ActualizarVeterinaria(this.id);

  @override
  _ActualizarVeterinariaState createState() => _ActualizarVeterinariaState();
}

class _ActualizarVeterinariaState extends State<ActualizarVeterinaria> {

  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController descripCtrl = new TextEditingController();
  TextEditingController direccionCtrl = new TextEditingController();
  TextEditingController direCtrl = new TextEditingController();

  TextEditingController responCtrl = new TextEditingController();
  TextEditingController correoCtrl = new TextEditingController();
  TextEditingController telefonoCtrl = new TextEditingController();
  TextEditingController contrasenaCtrl = new TextEditingController();

//este  campo es para pedir la contraseña
TextEditingController admincontrasenaCtrl = new TextEditingController();




  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  final _alertKey = GlobalKey<FormState>();

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

  String _urllogo='';
  String _urlimage='';

  String _ubicacion='';

  

  var _ubicacioninfo;

  final picker = ImagePicker();

  ProgressDialog progressDialog;


  @override
  void initState() { 

    getdata(widget.id);   
    getdatauser(widget.id);
    super.initState();
    
  }

  getdata(String id){
    FirebaseFirestore.instance.collection('veterinarias').doc(id).get().then((value){
      setState(() {
        nombreCtrl.text = value.data()['nombre'];
        descripCtrl.text=value.data()['descripcion'];
        direccionCtrl.text = value.data()['direccion'];
        _urllogo= value.data()['logo'];
        _urlimage= value.data()['imagen'];
        var ubicacion= value.data()['ubicacion'];
        _ubicacioninfo.latitud=ubicacion.latitude;
        _ubicacioninfo.longitud=ubicacion.longitude;
        

      });
       getadress(value.data()['ubicacion']);
       getHorario(value.data()['horario']);
       getHorarioatencion(value.data()['horarioatencion']);

    });
    
  }

  getHorario(String value){

   var valor= value.split('-');
   
   for (var i = 0; i < 2; i++) {
      
      var dia= valor[i];
      var index= dias.indexOf(dia);
      if (index != -1 && i == 0 ) {
        _value= index;
        
      } else {
        if (index!= -1 && i ==1) {
          _value1= index;
        }
        
      }      
     
   }
   


  }

  getHorarioatencion(String value){
    var valor= value.split('-');
    
     for (var i = 0; i < 2; i++) {
      
      var hora=valor[i];
      var index= horas.indexOf(hora);
      
      if (index != -1 && i == 0 ) {        
         _horainicio= index;        
      } else {
        if (index!= -1 && i ==1) {
          
          _horafinal= index;
        }
        
      }      
     
   }
    


  }


  getdatauser(String id){
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value){

      setState(() {
        responCtrl.text= value.data()['nombre'];
        telefonoCtrl.text= value.data()['telefono'];

      });
      

    });

  }

  getadress(GeoPoint ubicacion) async{
    print('obteniendo direcciones');
    final coordinates = new Coordinates(ubicacion.latitude, ubicacion.longitude);
    var direcciones =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    // print(direcciones.first.featureName);
    print(direcciones.first.addressLine);

    setState(() {
     _ubicacion= direcciones.first.addressLine;
    });
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
    

    

     _ubicacioninfo= Provider.of<Ubicacioninfo>(context);
    

    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Actualizar veterinaria'),
          ),
          body: Container(
              
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal:20),
              child: formulario(_ubicacioninfo),
          

        ),
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
              controller: telefonoCtrl,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.phone),
                labelText: 'telefono de responsable',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
                if (value.length < 9) {
                  return 'telefono invalido';
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
                              ? Image.network(_urlimage, height:50)
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
                              ? Image.network(_urllogo, height: 50)
                              : Image.file(_logo, height: 100),
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
                          width: MediaQuery.of(context).size.width * 0.85,
                          padding: EdgeInsets.all(20),
                          child: ubicacioninfo.direccion.length == 0
                               ? Text(_ubicacion)
                              : Text(ubicacioninfo.direccion),  
                        ),
                      ),
                  


                ),
              ],
            ),

            

            SizedBox(height:20),

            RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Color(0xFFED278A),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  
                  main();
                  
                }
              },
              child: Text('Actualizar Veterinaria',
                  style: TextStyle(color: Colors.white, fontSize: 18)),
            ),

            SizedBox(height:50),

            





          ]

        ),


      ),
    );

  }



 main() async{
    

    progressDialog = ProgressDialog(context,type: ProgressDialogType.Normal);
    progressDialog.style(message: 'Creando..');
    progressDialog.show();

    var ubicacion= new GeoPoint(_ubicacioninfo.latitud,_ubicacioninfo.longitud);

    try {
           
      var image= await uploadImage();
      var logo = await uploadLogo();
      await  updateVeterinario(ubicacion,image,logo);
      await  updateUser();
      progressDialog.hide();    
      Navigator.push(context, MaterialPageRoute(builder: (context) => MenuAdministrador()));

     

      
      
    } catch (e) {
      print('error');

      
    }
    
  }

  //actualizar cantidad
  updateVeterinario(GeoPoint ubicacion, String image, String logo)async{

    await FirebaseFirestore.instance.collection('veterinarias').doc(widget.id).update({
      'nombre': nombreCtrl.text,
      'descripcion': descripCtrl.text,
      'direccion': direccionCtrl.text,
      'horario':dias[_value]+'-'+dias[_value1],
      'horarioatencion':horas[_horainicio]+'-'+horas[_horafinal],
      'ubicacion':ubicacion,
      'imagen':image,
      'logo':logo
      



    });

  }

  updateUser() async{

    await FirebaseFirestore.instance.collection('users').doc(widget.id).update({
      'nombre': responCtrl.text,
      'telefono':telefonoCtrl.text,
      

    });
    

  }



  //funcion para cargar la imagen a firestore y recuerar la url
  Future<String> uploadImage() async {
     var url;
     if (_image!=null) {
        final StorageReference postImgRef =
            FirebaseStorage.instance.ref().child('portada');
        var timeKey = DateTime.now();

        //carguemos a storage
        final StorageUploadTask uploadTask =
            postImgRef.child(timeKey.toString() + ".png").putFile(_image);

        // recuperamos la  url esperamos que termine de cargar
        var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

        url = imageUrl.toString();

        
      
      }else{
      if (_image==null) {

         url= _urlimage;
        
      }
    }

    return url;
     
   
  }

   //funcion para cargar la imagen a firestore y recuerar la url
 Future<String>  uploadLogo() async {
   var url;
   if (_logo!=null) {

      final StorageReference postImgRef =
          FirebaseStorage.instance.ref().child('logo');
      var timeKey = DateTime.now();

      //carguemos a storage
      final StorageUploadTask uploadTask =
          postImgRef.child(timeKey.toString() + ".png").putFile(_logo);

      // recuperamos la  url esperamos que termine de cargar
      var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();      

      url = imageUrl.toString();      

     
   } else {
     if (_logo==null) {

       url= _urllogo;
       
     }


   }

   return url;
    
  }






}






 






