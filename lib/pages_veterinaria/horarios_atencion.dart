import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class HorarioAtencion extends StatefulWidget {
  HorarioAtencion({Key key}) : super(key: key);

  @override
  _HorarioAtencionState createState() => _HorarioAtencionState();
}

class _HorarioAtencionState extends State<HorarioAtencion> {
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
  Widget build(BuildContext context) {
    final nombreService = ModalRoute.of(context).settings.arguments;
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
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//----------------------------------------lunes--------------------------------------------------------
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
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Lunes', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 88),
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
                                dropdownColor: Colors.white,
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

                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//-------------------------------------------------------martes----------------------------------------
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
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Martes', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 77),
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
                                dropdownColor: Colors.white,
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

                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//---------------------------------------miercoles-----------------------------------------------------------
                      Row(
                        children: [
                          Checkbox(
                            value: _miercoles,
                            onChanged: (bool resp) {
                              setState(() {
                                _miercoles = resp;
                                if (_miercoles == true) {
                                  horarios['miércoles'] = {
                                    'inicio': _value5,
                                    'final': _value6
                                  };
                                } else {
                                  if (_miercoles == false) {
                                    horarios.remove('miércoles');
                                  }
                                }
                              });
                            },
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Miercoles', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 57),
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
                                value: _value5,
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
                                    _value5 = value;
                                    horarios['miércoles']['inicio'] = _value5;
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
                                dropdownColor: Colors.white,
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
                                    _value6 = value;
                                    horarios['miércoles']['final'] = _value6;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//---------------------------------jueves--------------------------------------------------------------
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
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Jueves', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 80),
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
                                dropdownColor: Colors.white,
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
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//-----------------------------------viernes-------------------------------------------------------
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
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Viernes', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 75),
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
                                dropdownColor: Colors.white,
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
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//-----------------------------------------sabado----------------------------------------------------
                      Row(
                        children: [
                          Checkbox(
                            value: _sabado,
                            onChanged: (bool resp) {
                              setState(() {
                                _sabado = resp;
                                if (_sabado == true) {
                                  horarios['sábado'] = {
                                    'inicio': _value11,
                                    'final': _value12
                                  };
                                } else {
                                  if (_sabado == false) {
                                    horarios.remove('sábado');
                                  }
                                }
                              });
                            },
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Sabado', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 78),
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
                                value: _value11,
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
                                    _value11 = value;
                                    horarios['sábado']['inicio'] = _value11;
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
                                dropdownColor: Colors.white,
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
                                    _value12 = value;
                                    horarios['sábado']['final'] = _value12;
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
//------------------------------------Domingo-----------------------------------------
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
                            activeColor: Color(0xffFE5F55),
                          ),
                          Text('Domingo', style: TextStyle(fontSize: 17)),
                          SizedBox(width: 70),
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
                                dropdownColor: Colors.white,
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
                      Divider(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.3)),
                      SizedBox(height: 30),
                      RaisedButton(
                        splashColor: Theme.of(context).primaryColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        color: Colors.greenAccent[200],
                        onPressed: () {
                          guardarservicio(nombreService);
                        },
                        child: Text('Crear',
                            style:
                                TextStyle(color: Colors.black, fontSize: 18)),
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
        .update({'horarios': horarios}).then((value) {
      print('Servicio cargado correctamente');
      _showMaterialDialog();
    });
  }

  //show alert dialog para las notificaciones
  _showMaterialDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => new AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: new Text("Excelente !!",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
              content:
                  new Text("El nuevo servicio a sido creado correctamente"),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3.0),
                  child: RaisedButton(
                    splashColor: Theme.of(context).primaryColor,
                    padding:
                        EdgeInsets.symmetric(horizontal: 152.0, vertical: 8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    color: Colors.greenAccent[200],
                    onPressed: () {
                      Navigator.pushNamed(context, 'reservasveterinario');
                    },
                    child: Text('OK',
                        style: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                            fontSize: 17)),
                  ),
                ),
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
              backgroundColor: Theme.of(context).primaryColor),
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
                  "Horarios de Atención",
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
