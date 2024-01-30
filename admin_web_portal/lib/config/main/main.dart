import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:admin_web_portal/common/di/injector.dart';

import '../my_app/my_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyCUXxuHLvsUp1EqxtKbSR0OrtGpON76J6o",
        authDomain: "flutter-uberclone-a8864.firebaseapp.com",
        databaseURL:
            "https://flutter-uberclone-a8864-default-rtdb.firebaseio.com",
        projectId: "flutter-uberclone-a8864",
        storageBucket: "flutter-uberclone-a8864.appspot.com",
        messagingSenderId: "860070657749",
        appId: "1:860070657749:web:89e094b12ae1ac1f3c6c5c",
        measurementId: "G-W4CKJ0QTD2"),
  );
  await setupDI();
  runApp(
    const MyApp(),
  );
}
