import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class CreateServices extends StatefulWidget {
  CreateServices({Key key}) : super(key: key);

  @override
  _CreateServicesState createState() => _CreateServicesState();
}

class _CreateServicesState extends State<CreateServices> {
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

  TextEditingController nameCtrl = new TextEditingController();
  TextEditingController precioCtrl = new TextEditingController();
  TextEditingController descripCtrl = new TextEditingController();

  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();

  int _value = 60;
  int _value1 = 0;
  int _aforo = 1;

  final servicearray = new List();

  //variables para la camara
  File _image;

  final picker = ImagePicker();

//funcion para obtener las imagenes de la camara
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xffffffff),
          /* appBar: AppBar(title: Text('Crear Servicio')), */
          body: Stack(
            children: [
              titulo(),
              Padding(
                padding: EdgeInsets.only(top: 80.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: formulario(),
                ),
              )
            ],
          )),
    );
  }

  Widget formulario() {
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
              controller: precioCtrl,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.attach_money),
                labelText: 'Precio en soles',
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(40)),
              ),
              validator: (value) {
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
            //-------------------duracion de citas horas--------
            Row(
              children: [
                Text('Duracion de cita :',
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
                      dropdownColor: Colors.white,
                      iconSize: 40,
                      value: _value,
                      items: [
                        DropdownMenuItem(
                          child: Text('0 horas'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('1 hora'),
                          value: 60,
                        ),
                        DropdownMenuItem(
                          child: Text('2 horas'),
                          value: 120,
                        ),
                        DropdownMenuItem(
                          child: Text('3 horas'),
                          value: 180,
                        ),
                        DropdownMenuItem(
                          child: Text('4 horas'),
                          value: 240,
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
                //----------------------duracion de cita minutos----------
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton(
                      dropdownColor: Colors.white,
                      iconSize: 40,
                      value: _value1,
                      items: [
                        DropdownMenuItem(
                          child: Text('0 minutos'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('15 minutos'),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text('30 minutos'),
                          value: 30,
                        ),
                        DropdownMenuItem(
                          child: Text('45 minutos'),
                          value: 45,
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
            //-------------a foro de citas-----------
            Row(
              children: [
                Text('Aforo por cita :',
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
                      dropdownColor: Colors.white,
                      focusColor: Colors.red,
                      iconSize: 40,
                      value: _aforo,
                      items: [
                        DropdownMenuItem(
                          child: Text('1'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('2'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('3'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('4'),
                          value: 4,
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _aforo = value;
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
                Text("Icono :", style: TextStyle(fontSize: 15)),
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
                SizedBox(width: 20),
                GestureDetector(
                    child: Text('Buscar Icono',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () {
                      launch(
                          'https://www.flaticon.com/search?search-type=icons&word=veterinary');
                    }),
              ],
            ),
            SizedBox(height: 25),
            RaisedButton(
              splashColor: Theme.of(context).primaryColor,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColorLight,
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  uploadImage();
                }
              },
              child: Text('Siguiente',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

//funcion para cargar la imagen a firestore y recuerar la url
  uploadImage() async {
    final StorageReference postImgRef =
        FirebaseStorage.instance.ref().child('icons');
    var timeKey = DateTime.now();

    //carguemos a storage
    final StorageUploadTask uploadTask =
        postImgRef.child(timeKey.toString() + ".png").putFile(_image);

    // recuperamos la  url esperamos que termine de cargar
    var imageUrl = await (await uploadTask.onComplete).ref.getDownloadURL();

    final String url = imageUrl.toString();

    saveDatabase(url);
  }

  saveDatabase(String url) {
    //guardar en la bd(nombre, precio, descripcion, duracion de cita, cupo, urlicono)
    final int duracion = _value + _value1;
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('veterinarias')
        .doc(id)
        .collection('servicios')
        .add({
      'nombre': nameCtrl.text,
      'icono': url,
      'descripcion': descripCtrl.text,
      'duracioncita': duracion,
      'cupo': _aforo,
      'precio': int.parse(precioCtrl.text),
    }).then((value) {
      print('el id del nuevo servicio' + value.id);
      Navigator.pushNamed(context, 'horariosatencion', arguments: value.id);
    });
  }

  //----encabezado de la pagina ---
  // app bar con waves
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
            backgroundColor: Theme.of(context).primaryColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //----WIDGET REGRESO A PERFIL VETERINARIA---
              Wrap(
                direction: Axis.vertical,
                alignment: WrapAlignment.center,
                runSpacing: 1.0,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 20,
                      left: 18,
                    ),
                    child: GestureDetector(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
              //----TITULO DE LA SECCION---
              Padding(
                padding: const EdgeInsets.only(
                  top: 15.0,
                  right: 130,
                ),
                child: Text(
                  "Crear Servicio",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
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
