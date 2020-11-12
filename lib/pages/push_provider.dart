import 'dart:async';
import 'dart:io';
import 'package:assets_audio_player/assets_audio_player.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  final _mensajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mensajesStreamController.stream;
  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    final assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer.open(
      Audio("assets/iphone.mp3"),
      autoStart: true,
      showNotification: true,
    );
    print("sound played");
    return null;
  }

  initNotificaions() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((value) {
      print('firebase cloud mesagin $value');
    });
    _firebaseMessaging.configure(
        onMessage: (info) {
          print('=======on mesage======');
          print(info);
          String argumento = 'no-data';
          if (Platform.isAndroid) {
            argumento = info['data']['message'] ?? 'no-data';
            _mensajesStreamController.sink.add(argumento);
          }

          return;
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (info) {
          print('=======on laucnh======');
          print(info);
          return;
        },
        onResume: (info) {
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
