import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider/provider.dart';

class PushNotification {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;

  initNotificaions() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) {
      print('firebase cloud mesagin $value');
    });
    _firebaseMessaging.configure(onMessage: (info) {
      print('=======on mesage======');
      print(info);
      String argumento = 'no-data';
      if (Platform.isAndroid) {
        argumento = info['data']['message'] ?? 'no-data';
        _mensajesStreamController.sink.add(argumento);
      }

      return;
    }, onLaunch: (info) {
      print('=======on laucnh======');
      print(info);
      return;
    }, onResume: (info) {
      print('=======on resume======');
      print(info);
      final noti = info['data']['message'];
      _mensajesStreamController.sink.add(noti);
      return;
    });
  }

  dispose() {
    _mensajesStreamController?.close();
  }
}
