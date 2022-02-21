import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:health_plus/model/notification.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'json_util.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin _flutterLocalNotifications =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _channel = AndroidNotificationChannel(
    'firebase_notifications',
    'Firebase Notifications',
    description: 'Firebase Notifications Channel',
    importance: Importance.max,
  );

  static const String _notificationsKey = 'notifications';

  static late SharedPreferences _prefs;

  static Future<void> ensureInitialized() async {
    _prefs = await SharedPreferences.getInstance();

    if (Platform.isIOS) {
      await _requestIOSPermission();
    }

    FirebaseMessaging.onBackgroundMessage(_firebaseOnBackgroundMessage);

    await FirebaseMessaging.instance.setAutoInitEnabled(true);
  }

  static List<Notification> loadNotifications() {
    if (_prefs.containsKey(_notificationsKey)) {
      final notificationsJson = _prefs.getString(_notificationsKey);

      if (notificationsJson != null && notificationsJson.isNotEmpty) {
        return jsonArrayToList<Notification>(
          jsonDecode(notificationsJson),
          Notification.fromJson,
        );
      }
    }
    return [];
  }

  static Future<void> saveNotification(Notification notification) {
    final notifications = loadNotifications()..add(notification);
    final notificationsJson = jsonEncode([
      for (final notification in notifications) notification.toJson(),
    ]);
    return _prefs.setString(_notificationsKey, notificationsJson);
  }

  static Future<void> removeNotification(Notification notification) {
    final notifications = loadNotifications()..remove(notification);
    final notificationsJson = jsonEncode([
      for (final notification in notifications) notification.toJson(),
    ]);
    return _prefs.setString(_notificationsKey, notificationsJson);
  }

  static Future<void> showNotification(
    int id, {
    String? title,
    String? body,
    String? imageUrl,
  }) async {
    const largeIcon = DrawableResourceAndroidBitmap('app_icon');

    StyleInformation? styleInformation;
    if (imageUrl != null) {
      styleInformation = BigPictureStyleInformation(
        FilePathAndroidBitmap(await _downloadImage(imageUrl, 'bigPicture')),
        largeIcon: largeIcon,
      );
    } else {
      styleInformation = const DefaultStyleInformation(true, true);
    }

    await _flutterLocalNotifications.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _channel.id,
          _channel.name,
          channelDescription: _channel.description,
          styleInformation: styleInformation,
          icon: '@mipmap/ic_notification',
          importance: Importance.max,
          priority: Priority.high,
          largeIcon: largeIcon,
        ),
        iOS: const IOSNotificationDetails(),
      ),
    );
  }

  static Future<void> _requestIOSPermission() async {
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    await _flutterLocalNotifications
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> _firebaseOnBackgroundMessage(
    RemoteMessage message,
  ) async {
    String? notificationUrl;
    if (Platform.isAndroid) {
      notificationUrl = message.notification?.android?.imageUrl;
    } else if (Platform.isIOS) {
      notificationUrl = message.notification?.apple?.imageUrl;
    }

    final notification = Notification(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      sentDate: message.sentTime,
    );

    LocalNotifications.saveNotification(notification);

    LocalNotifications.showNotification(
      notification.id,
      title: notification.title,
      body: notification.body,
      imageUrl: notificationUrl,
    );
  }

  static Future<String> _downloadImage(
    String url,
    String fileName,
  ) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final response = await http.get(Uri.parse(url));

    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return filePath;
  }
}
