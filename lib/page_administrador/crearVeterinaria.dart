import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class CrearVeterinaria extends StatefulWidget {
  CrearVeterinaria({Key key}) : super(key: key);

  @override
  _CrearVeterinariaState createState() => _CrearVeterinariaState();
}

class _CrearVeterinariaState extends State<CrearVeterinaria> {
  TextEditingController nombreCtrl = new TextEditingController();
  TextEditingController descripCtrl = new TextEditingController();
  TextEditingController direccionCtrl = new TextEditingController();
  TextEditingController direCtrl = new TextEditingController();

  //creamos la llave para el control de formulario
  final _formKey = GlobalKey<FormState>();


  //variables para los dias
  int _value = 0;
  int _value1= 4;

  //variables para las horas
  int  _horainicio= 8;
  int  _horafinal= 17;

  //vavriable para la imagen

  File  _image;

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
    return Container(
            
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal:20),
            child: formulario(),
        

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
                          child: Text('00:00'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('01:00'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('02.00'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('03:00'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('04:00'),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text('05:00'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('06:00'),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text('07:00'),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text('08:00'),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text('09:00'),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00'),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00'),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Text('12:00'),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Text('13:00'),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Text('14:00'),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Text('15:00'),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text('16:00'),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Text('17:00'),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Text('18:00'),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Text('19:00'),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Text('20:00'),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text('21:00'),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Text('22:00'),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Text('23:00'),
                          value: 23,
                        ),
                        DropdownMenuItem(
                          child: Text('24:00'),
                          value: 24,
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
                          child: Text('00:00'),
                          value: 0,
                        ),
                        DropdownMenuItem(
                          child: Text('01:00'),
                          value: 1,
                        ),
                        DropdownMenuItem(
                          child: Text('02.00'),
                          value: 2,
                        ),
                        DropdownMenuItem(
                          child: Text('03:00'),
                          value: 3,
                        ),
                        DropdownMenuItem(
                          child: Text('04:00'),
                          value: 4,
                        ),
                        DropdownMenuItem(
                          child: Text('05:00'),
                          value: 5,
                        ),
                        DropdownMenuItem(
                          child: Text('06:00'),
                          value: 6,
                        ),
                        DropdownMenuItem(
                          child: Text('07:00'),
                          value: 7,
                        ),
                        DropdownMenuItem(
                          child: Text('08:00'),
                          value: 8,
                        ),
                        DropdownMenuItem(
                          child: Text('09:00'),
                          value: 9,
                        ),
                        DropdownMenuItem(
                          child: Text('10:00'),
                          value: 10,
                        ),
                        DropdownMenuItem(
                          child: Text('11:00'),
                          value: 11,
                        ),
                        DropdownMenuItem(
                          child: Text('12:00'),
                          value: 12,
                        ),
                        DropdownMenuItem(
                          child: Text('13:00'),
                          value: 13,
                        ),
                        DropdownMenuItem(
                          child: Text('14:00'),
                          value: 14,
                        ),
                        DropdownMenuItem(
                          child: Text('15:00'),
                          value: 15,
                        ),
                        DropdownMenuItem(
                          child: Text('16:00'),
                          value: 16,
                        ),
                        DropdownMenuItem(
                          child: Text('17:00'),
                          value: 17,
                        ),
                        DropdownMenuItem(
                          child: Text('18:00'),
                          value: 18,
                        ),
                        DropdownMenuItem(
                          child: Text('19:00'),
                          value: 19,
                        ),
                        DropdownMenuItem(
                          child: Text('20:00'),
                          value: 20,
                        ),
                        DropdownMenuItem(
                          child: Text('21:00'),
                          value: 21,
                        ),
                        DropdownMenuItem(
                          child: Text('22:00'),
                          value: 22,
                        ),
                        DropdownMenuItem(
                          child: Text('23:00'),
                          value: 23,
                        ),
                        DropdownMenuItem(
                          child: Text('24:00'),
                          value: 24,
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
            





          ]

        ),


      ),
    );

  }


}