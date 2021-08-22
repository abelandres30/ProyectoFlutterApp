import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationProvider {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final _mesajesStreamController = StreamController<String>.broadcast();
  Stream<String> get mensajes => _mesajesStreamController.stream;

  initNotificaciones() {
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.getToken().then((token) {
      print('=== FCM Token ====');
      print(token);
      //ftWMyMUJFX4:APA91bFtmJva5A3RDwZ7wsHKOO8XmMjj-pWtSlCALjqrZgGt6V4bqCFaZkFv4j0-Jdcovr_gCK_G4dMq8y1CY_moUgUjCgU1ZtBG_8A9u8kra_k4arccCx1Io_NqmjlFXcMUY689fU5T
    });

    _firebaseMessaging.configure(
      onMessage: (info) async {
        print('===== On Mesagge ======');
        print(info);

        var argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = info['data']['comida'] ?? 'no-data';
        }

        _mesajesStreamController.sink.add(argumento);
      },
      onLaunch: (info) async {
        print('===== On Lauch ======');
        print(info);

        var argumento = 'no-data';
        if (Platform.isAndroid) {
          argumento = info['data']['comida'] ?? 'no-data';
        }

        _mesajesStreamController.sink.add(argumento);
      },
      onResume: (info) async {
        print('===== On Resume ======');
        print(info);

        // final noti = info['data']['comida'];
        // print(noti);
        //_mesajesStreamController.sink.add(noti);
      },
    );
  }

  dispose() {
    _mesajesStreamController?.close();
  }
}
