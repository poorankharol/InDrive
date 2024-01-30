import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_image_downloader.dart';

/// Class for managing notification types.
///
/// ```
/// Usage:
///   NotificationHelper.showTextNotification(title: "Hello", body: "Body");
///   NotificationHelper.showLongTextNotification(title: "Android", body:"Apply NotificationCompat.InboxStyle",subTitle: 'Android 13')
///   NotificationHelper.showLongTextNotification(title: "Android", body:"Apply NotificationCompat.InboxStyle",subTitle: 'Android 13', url: "https://encrypted-tbn0.gstatic.com")
/// ```
sealed class NotificationHelper {
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const NotificationDetails _notificationDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      "Testing",
      "Testing",
      priority: Priority.defaultPriority,
      importance: Importance.defaultImportance,
    ),
    iOS: DarwinNotificationDetails(),
  );

  /// Requests notification permissions for the current platform
  Future<void> requestPermissions() async {
    if (Platform.isIOS) {
      await _localNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          _localNotificationsPlugin.resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      await androidImplementation?.requestNotificationsPermission();
    }
  }

  /// Initializes the notification plugin
  static Future<void> setup() async {
    const androidInitializationSetting =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSetting = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
        android: androidInitializationSetting, iOS: iosInitializationSetting);
    await _localNotificationsPlugin.initialize(initSettings);
  }

  /// Shows a simple text notification
  static void showTextNotification({
    required String title,
    required String body,
  }) async {
    await _localNotificationsPlugin.show(
      0,
      title,
      body,
      _notificationDetails,
    );
  }

  /// Shows a notification with a long text body
  static void showLongTextNotification({
    required String title,
    required String subTitle,
    required String body,
  }) async {
    BigTextStyleInformation bigTextStyleInformation = BigTextStyleInformation(
      body,
      htmlFormatBigText: true,
      contentTitle: title,
      htmlFormatContentTitle: true,
      summaryText: subTitle,
      htmlFormatSummaryText: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails("Testing", "Testing",
          priority: Priority.defaultPriority,
          importance: Importance.defaultImportance,
          styleInformation: bigTextStyleInformation),
      iOS: DarwinNotificationDetails(subtitle: subTitle),
    );

    await _localNotificationsPlugin.show(
      0,
      title,
      subTitle,
      notificationDetails,
    );
  }

  /// Shows a notification with an image
  static void showNotificationImage({
    required String title,
    required String subTitle,
    required String body,
    required String url,
  }) async {
    //Image
    final String bigPicturePath =
        await NotificationImageDownloader.base64encodedImage(url, 'bigPicture');
    final BigPictureStyleInformation bigTextStyleInformation =
        BigPictureStyleInformation(
            ByteArrayAndroidBitmap.fromBase64String(
                bigPicturePath), //Base64AndroidBitmap(bigPicture),
            contentTitle: title,
            htmlFormatContentTitle: true,
            summaryText: body,
            htmlFormatSummaryText: true);
    NotificationDetails notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails("Testing", "Testing",
          priority: Priority.defaultPriority,
          importance: Importance.defaultImportance,
          styleInformation: bigTextStyleInformation),
      iOS: DarwinNotificationDetails(subtitle: subTitle),
    );
    await _localNotificationsPlugin.show(
      0,
      title,
      subTitle,
      notificationDetails,
    );
  }
}
