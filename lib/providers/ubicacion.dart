import 'package:flutter/material.dart';

class Ubicacioninfo with ChangeNotifier{
  double _latitud=0.0;
  double _longitud= 0.0;

  get latitud{
    return _latitud;
  }

  get longitud {
    return _longitud;
  }

  set latitud(double lat){
    this._latitud = lat;    

  }

  set longitud(double lng){
    this._longitud = lng;

  }

}