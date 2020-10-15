import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class ActualizarHorario extends StatefulWidget {

  final String idService;
  ActualizarHorario(this.idService);

  @override
  _ActualizarHorarioState createState() => _ActualizarHorarioState();
}

class _ActualizarHorarioState extends State<ActualizarHorario> {
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

  // bool _sel=false;
  bool _lunes = false;
  bool _martes = false;
  bool _miercoles = false;
  bool _jueves = false;
  bool _viernes = false;
  bool _sabado = false;
  bool _domingo = false;

  //valores de horarios de Lunes
  int _value1 = 8;
  int _value2 = 17;

  //valores de horariso para Martes
  int _value3 = 8;
  int _value4 = 17;

  //valores de horarios de miercoles
  int _value5 = 8;
  int _value6 = 17;

  //valores de horarios de jueves
  int _value7 = 8;
  int _value8 = 17;

  //valores de horarios de viernes
  int _value9 = 8;
  int _value10 = 17;

  //valores de horarios de sabado
  int _value11 = 8;
  int _value12 = 17;

  //valores de horarios de domingo
  int _value13 = 8;
  int _value14 = 17;

  var horarios = {};

@override
void initState() { 

  getData();
  super.initState();
  
}


//funcion para los horarios desde la base de datos
  getData(){
    final semana=['lunes','martes','miércoles','jueves','viernes','sábado','domingo'];
    
     final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('veterinarias').doc(id).collection('servicios').doc(widget.idService).get().then((value){
      
       for (var i = 0; i < 7; i++) {

        setState(() {

          switch (i) {

            case 0:{
               try {
                 _value1= value.data()['horarios'][semana[i]]['inicio'];
                 _value2= value.data()['horarios'][semana[i]]['final'];
                 _lunes=true;
                 horarios['lunes'] = {
                            'inicio': _value1,
                            'final': _value2
                          };
                  
               } catch (e) {
                 

               }              
              
              }
              break;

            case 1:{
              try {
                _value3= value.data()['horarios'][semana[i]]['inicio'];
                _value4= value.data()['horarios'][semana[i]]['final'];    
                _martes=true;
                horarios['martes'] = {
                            'inicio': _value3,
                            'final': _value4
                          };            
              } catch (e) {

              }
              

              }              
              break;


            case 2:{
              try {
                 _value5= value.data()['horarios'][semana[i]]['inicio'];
                 _value6= value.data()['horarios'][semana[i]]['final'];
                 _miercoles=true;
                 horarios['miércoles']={'inicio':_value5,'final':_value6}; 
                
              } catch (e) {

              }
             

             }    
              break;

            
            case 3:{
              try {
                _value7= value.data()['horarios'][semana[i]]['inicio'];
                _value8= value.data()['horarios'][semana[i]]['final'];
                _jueves=true;
                horarios['jueves'] = {
                            'inicio': _value7,
                            'final': _value8
                          };
                
              } catch (e) {
              }
              

             }              
              break;

            
            case 4:{
              try {
                _value9= value.data()['horarios'][semana[i]]['inicio'];
                _value10= value.data()['horarios'][semana[i]]['final'];
                _viernes=true;
                horarios['viernes'] = {
                            'inicio': _value9,
                            'final': _value10
                          };
                
              } catch (e) {
              }
              

             }              
              break;


            case 5:{
              try {
                _value11= value.data()['horarios'][semana[i]]['inicio'];
                _value12= value.data()['horarios'][semana[i]]['final'];
                _sabado=true;
                horarios['sábado']={'inicio':_value11,'final':_value12}; 
                
              } catch (e) {

              }
              

             }             
              break;

            
            case 6:{              
             
              try {
                _value13= value.data()['horarios'][semana[i]]['inicio'];
                _value14= value.data()['horarios'][semana[i]]['final'];
                _domingo=true;
                horarios['domingo'] = {
                            'inicio': _value13,
                            'final': _value14
                          };
                
              } catch (e) {
                print('no pude encontrar valores');
              }
              

             }              
              break;
            

            default:
              break;
          }
          
          
        

        
         
        });


        
      } 
      


    });
    


  }

  @override
  Widget build(BuildContext context) {
    final nombreService = widget.idService;
    return SafeArea(
          child: Scaffold(
        backgroundColor: Color(0xffffffff),
          /* appBar: AppBar(
          title: Text('Horarios de atencion'),
        ), */
          body: Stack(
        children: [
          titulo(),
          Padding(
            padding: EdgeInsets.only(top: 80.0),
            child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            children: [
              // SizedBox(height:40),
              Divider(color: Colors.black87),
              Row(
                children: [
                  Checkbox(
                    value: _lunes,
                    onChanged: (bool resp) {
                      setState(() {
                        _lunes = resp;
                        if (_lunes == true) {
                          horarios['lunes'] = {
                            'inicio': _value1,
                            'final': _value2
                          };
                        } else {
                          if (_lunes == false) {
                            horarios.remove('lunes');
                          }
                        }
                      });
                    },
                    activeColor: Color(0xFFFDD400),
                  ),
                  Text('Lunes', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 100),
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
                            child: Text('00:00'),
                            value: 0,
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value1 = value;
                            horarios['lunes']['inicio'] = _value1;
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
                        value: _value2,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value2 = value;
                            horarios['lunes']['final'] = _value2;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              Divider(color: Colors.black38),

              Row(
                children: [
                  Checkbox(
                    value: _martes,
                    onChanged: (bool resp) {
                      setState(() {
                        _martes = resp;
                        if (_martes == true) {
                          horarios['martes'] = {
                            'inicio': _value3,
                            'final': _value4
                          };
                        } else {
                          if (_martes == false) {
                            horarios.remove('martes');
                          }
                        }
                      });
                    },
                    activeColor: Color(0xFFFDD400),
                  ),
                  Text('Martes', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 90),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        iconSize: 40,
                        value: _value3,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value3 = value;
                            horarios['martes']['inicio'] = _value3;
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
                        value: _value4,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value4 = value;
                            horarios['martes']['final'] = _value4;
                          });
                        },
                       ),
                   ),
                 ),
                 

               ],
            ),
            
            Divider(color:Colors.black38),


            Row(
               children: [
                 Checkbox(
                   value: _miercoles, 
                   onChanged: (bool resp){
                     setState(() {
                       _miercoles = resp;
                       if (_miercoles==true) {
                         horarios['miércoles']={'inicio':_value5,'final':_value6};                         
                       }else{
                         if(_miercoles==false){
                            
                            horarios.remove('miércoles');

                         }
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Miercoles',style: TextStyle(fontSize:20)),
                 SizedBox(width: 67),
                 Container(                  

                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black),
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: DropdownButton(                     
                       iconSize: 40,                   
                       value: _value5,
                       items: [
                          DropdownMenuItem(
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value5=value;
                            horarios['miércoles']['inicio']=_value5;
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
                        value: _value6,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value6=value;
                            horarios['miércoles']['final']=_value6;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black87),

              Row(
                children: [
                  Checkbox(
                    value: _jueves,
                    onChanged: (bool resp) {
                      setState(() {
                        _jueves = resp;
                        if (_jueves == true) {
                          horarios['jueves'] = {
                            'inicio': _value7,
                            'final': _value8
                          };
                        } else {
                          if (_jueves == false) {
                            horarios.remove('jueves');
                          }
                        }
                      });
                    },
                    activeColor: Color(0xFFFDD400),
                  ),
                  Text('Jueves', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 92),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        iconSize: 40,
                        value: _value7,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value7 = value;
                            horarios['jueves']['inicio'] = _value7;
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
                        value: _value8,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value8 = value;
                            horarios['jueves']['final'] = _value8;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black54),

              Row(
                children: [
                  Checkbox(
                    value: _viernes,
                    onChanged: (bool resp) {
                      setState(() {
                        _viernes = resp;

                        if (_viernes == true) {
                          horarios['viernes'] = {
                            'inicio': _value9,
                            'final': _value10
                          };
                        } else {
                          if (_viernes == false) {
                            horarios.remove('viernes');
                          }
                        }
                      });
                    },
                    activeColor: Color(0xFFFDD400),
                  ),
                  Text('Viernes', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 90),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        iconSize: 40,
                        value: _value9,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value9 = value;
                            horarios['viernes']['inicio'] = _value9;
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
                        value: _value10,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value10 = value;
                            horarios['viernes']['final'] = _value10;
                          });
                        },
                       ),
                   ),
                 ),

               ],
            ),
            Divider(color:Colors.black38),

            Row(
               children: [
                 Checkbox(
                   value: _sabado, 
                   onChanged: (bool resp){
                     setState(() {
                       _sabado = resp;
                       if (_sabado==true) {
                         horarios['sábado']={'inicio':_value11,'final':_value12};                         
                       }else{
                         if(_sabado==false){
                            
                            horarios.remove('sábado');

                         }
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Sabado',style: TextStyle(fontSize:20)),
                 SizedBox(width: 90),
                 Container(                  

                   decoration: BoxDecoration(
                     border: Border.all(color: Colors.black),
                     borderRadius: BorderRadius.circular(10),
                   ),
                   child: Padding(
                     padding: const EdgeInsets.only(left: 10),
                     child: DropdownButton(                     
                       iconSize: 40,                   
                       value: _value11,
                       items: [
                          DropdownMenuItem(
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value11=value;
                            horarios['sábado']['inicio']=_value11;
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
                        value: _value12,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value12=value;
                            horarios['sábado']['final']=_value12;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black38),

              Row(
                children: [
                  Checkbox(
                    value: _domingo,
                    onChanged: (bool resp) {
                      setState(() {
                        _domingo = resp;
                        if (_domingo == true) {
                          horarios['domingo'] = {
                            'inicio': _value13,
                            'final': _value14
                          };
                        } else {
                          if (_domingo == false) {
                            horarios.remove('domingo');
                          }
                        }
                      });
                    },
                    activeColor: Color(0xFFFDD400),
                  ),
                  Text('Domingo', style: TextStyle(fontSize: 20)),
                  SizedBox(width: 78),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: DropdownButton(
                        iconSize: 40,
                        value: _value13,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value13 = value;
                            horarios['domingo']['inicio'] = _value13;
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
                        value: _value14,
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
                            child: Text('02:00'),
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
                        ],
                        onChanged: (value) {
                          setState(() {
                            _value14 = value;
                            horarios['domingo']['final'] = _value14;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Divider(color: Colors.black87),
              SizedBox(height: 30),
              RaisedButton(
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                color: Color(0xFFED278A),
                onPressed: () {
                  guardarservicio(nombreService);
                },
                child: Text('Siguiente',
                    style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
            ],
          ),
        ),
          )
        ],
      )),
    );
  }

  guardarservicio(nombreService) {
  

    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance
        .collection('veterinarias')
        .doc(id)
        .collection('servicios')
        .doc(nombreService)
        .update({'horarios': horarios}).then((value){
              print('Servicio cargado correctamente');
              _showMaterialDialog();


            });
  }

  //show alert dialog para las notificaciones
   _showMaterialDialog() {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              title: new Text("Actualizado"),
              content: new Text("los datos han sido actualizados correctamente"),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.pushNamed(context, 'reservasveterinario');
                  },
                )
              ],
            ));
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
                  "Actualizar horario",
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