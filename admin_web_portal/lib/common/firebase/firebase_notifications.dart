import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseNotifications {
  static void initializeFCM() {
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance.getToken().then((token) {
      if (kDebugMode) {
        print("FCM Token: $token");
      }
      // Store the token on your server for sending targeted messages
    });
  }

  static void configureFCMListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // Handle incoming data message when the app is in the foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // Handle incoming data message when the app is in the background or terminated
      // Extract data and perform custom actions
    });

    FirebaseMessaging.onBackgroundMessage(
        _backgroundHandler); // Set the background handler
  }

  static Future<void> _backgroundHandler(RemoteMessage message) async {
    // Process the incoming message and perform appropriate actions
  }

  /// when app is in the foreground
  static Future<void> onTapNotification(NotificationResponse? response) async {}
}
