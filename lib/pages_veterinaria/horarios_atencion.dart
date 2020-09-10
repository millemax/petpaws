import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HorarioAtencion extends StatefulWidget {
  HorarioAtencion({Key key}) : super(key: key);

  @override
  _HorarioAtencionState createState() => _HorarioAtencionState();
}

class _HorarioAtencionState extends State<HorarioAtencion> {

 // bool _sel=false;
  bool _lunes=false;
  bool _martes=false;
  bool _miercoles=false;
  bool _jueves=false;
  bool _viernes=false;
  bool _sabado=false;
  bool _domingo=false;

  int _value = 1;

  var horarios = new List();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horarios de atencion'),
      ),
      body: Container(
            padding: EdgeInsets.symmetric(vertical:20),
              child: Column(
          
          children: [
          // SizedBox(height:40),
          Divider(color:Colors.black87),
            Row(
               children: [
                 Checkbox(
                   value: _lunes, 
                   onChanged: (bool resp){
                     setState(() {
                       _lunes = resp;
                       if (_lunes==true) {
                         horarios.add('lunes');                         
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Lunes', style: TextStyle(fontSize:20)),
                 SizedBox(width:100),

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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                 SizedBox(width:10),
                 
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
               ],
            ),

            Divider(color:Colors.black38),

            



            Row(
               children: [
                 Checkbox(
                   value: _martes, 
                   onChanged: (bool resp){
                     setState(() {
                       _martes = resp;
                       if (_martes==true) {
                         horarios.add('martes');                         
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Martes',style: TextStyle(fontSize:20)),
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                SizedBox(width:10),
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                         horarios.add('miercoles');                         
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
               ],
            ),
            Divider(color:Colors.black87),

            Row(
               children: [
                 Checkbox(
                   value: _jueves, 
                   onChanged: (bool resp){
                     setState(() {
                       _jueves = resp;
                       if (_jueves==true) {
                         horarios.add('jueves');                         
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Jueves',style: TextStyle(fontSize:20)),
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                 SizedBox(width:10),
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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

                 
               ],
            ),
            Divider(color:Colors.black54),

            Row(
               children: [
                 Checkbox(
                   value: _viernes, 
                   onChanged: (bool resp){
                     setState(() {
                       _viernes = resp;

                       if (_viernes==true) {
                         horarios.add('viernes');                         
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Viernes',style: TextStyle(fontSize:20)),
                 SizedBox(width:90),
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                         horarios.add('sabado');                         
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                 SizedBox(width:10),
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
               ],
            ),
            Divider(color:Colors.black38),


            Row(
               children: [
                 Checkbox(
                   value: _domingo, 
                   onChanged: (bool resp){
                     setState(() {
                       _domingo = resp;
                       if (_domingo==true) {
                         horarios.add('domingo');                         
                       }
                     });

                   },
                  activeColor: Color(0xFFFDD400),
                 ),
                 Text('Domingo',style: TextStyle(fontSize:20)),
                 SizedBox(width:78),
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
                            child: Text('00:00'), 
                            value:0,                    
                          ),
                          DropdownMenuItem(
                            child: Text('01:00'),  
                            value:1,                   
                          ),
                          DropdownMenuItem(
                            child: Text('02:00'),
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
                       value: _value,
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
                            value:2,                     
                          ),
                          DropdownMenuItem(
                            child: Text('03:00'),  
                            value:3,                   
                          ),
                          DropdownMenuItem(
                            child: Text('04:00'), 
                            value:4,                    
                          ),
                          DropdownMenuItem(
                            child: Text('05:00'), 
                            value:5,                   
                          ),
                          DropdownMenuItem(
                            child: Text('06:00'), 
                            value:6,                   
                          ),
                          DropdownMenuItem(
                            child: Text('07:00'), 
                            value:7,                   
                          ),
                          DropdownMenuItem(
                            child: Text('08:00'), 
                            value:8,                   
                          ),
                          DropdownMenuItem(
                            child: Text('09:00'), 
                            value:9,                   
                          ),
                          DropdownMenuItem(
                            child: Text('10:00'), 
                            value:10,                   
                          ),
                          DropdownMenuItem(
                            child: Text('11:00'), 
                            value:11,                   
                          ),
                          DropdownMenuItem(
                            child: Text('12:00'), 
                            value:12,                   
                          ),
                          DropdownMenuItem(
                            child: Text('13:00'), 
                            value:13,                   
                          ),
                          DropdownMenuItem(
                            child: Text('14:00'), 
                            value:14,                   
                          ),
                          DropdownMenuItem(
                            child: Text('15:00'), 
                            value:15,                   
                          ),
                          DropdownMenuItem(
                            child: Text('16:00'), 
                            value:16,                   
                          ),
                          DropdownMenuItem(
                            child: Text('17:00'), 
                            value:17,                   
                          ),
                          DropdownMenuItem(
                            child: Text('18:00'), 
                            value:18,                   
                          ),
                          DropdownMenuItem(
                            child: Text('19:00'), 
                            value:19,                   
                          ),
                          DropdownMenuItem(
                            child: Text('20:00'), 
                            value:20,                   
                          ),
                          DropdownMenuItem(
                            child: Text('21:00'), 
                            value:21,                   
                          ),
                          DropdownMenuItem(
                            child: Text('22:00'), 
                            value:22,                   
                          ),
                          DropdownMenuItem(
                            child: Text('23:00'), 
                            value:23,                   
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
               ],
            ),
            Divider(color:Colors.black87),
            SizedBox(height: 30),
            RaisedButton(
             padding: EdgeInsets.symmetric(horizontal:30, vertical:15),
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
             color: Color(0xFFED278A),
             onPressed: (){
               guardarservicio();
             },
             child:Text('Siguiente', style: TextStyle(color: Colors.white, fontSize:18)),
            ),
          ],

          
        ),
      ),
       
    );
  }

  guardarservicio(){

    print(horarios);
   
    
    
    final String id = FirebaseAuth.instance.currentUser.uid;
    FirebaseFirestore.instance.collection('veterinarias').doc(id).collection('servicios').doc('masajesitos').set({
      'dias': horarios,
      'nombre': 'duchitacaliente',

    }).then((value) => {
       Navigator.pushNamed(context,'crearservico')

    });
    



   

  }
}