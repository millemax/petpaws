import 'package:flutter/material.dart';

class Ubicacioninfo with ChangeNotifier{
  double _latitud=0.0;
  double _longitud= 0.0;
  String _direcccion='';

  get latitud{
    return _latitud;
  }

  get longitud{
    return _longitud;
  }

  get direccion{
    return _direcccion;

  }

  set latitud(double lat){
    this._latitud = lat;    
    notifyListeners();

  }

  set longitud(double lng){
    this._longitud = lng;
    notifyListeners();

  }

  set direccion(String direc){

    
    this._direcccion = direc;
    notifyListeners();

  }

}