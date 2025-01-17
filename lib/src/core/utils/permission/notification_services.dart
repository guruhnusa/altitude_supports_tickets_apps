import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class NotificationServices {
  Future<void> requestPermission() async {
    NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      log('User granted provisional permission');
    } else {
      // AppSettings.openAppSettings(type: AppSettingsType.notification);
    }
  }

  Future<void> setupNotifications(BuildContext context) async {
    if (Platform.isAndroid || Platform.isIOS) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Channel',
        description: 'This channel is used for important notifications',
        importance: Importance.max,
        playSound: true,
        enableVibration: true,
      );

      const InitializationSettings initSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/launcher_icon"),
        iOS: DarwinInitializationSettings(),
      );

      await flutterLocalNotificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (details) {},
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      if (Platform.isAndroid) {
        await FirebaseMessaging.instance.setAutoInitEnabled(true);
      }

      await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        log('Got a message whilst in the foreground!${message.data}');
        RemoteNotification? notification = message.notification;
        AndroidNotification? android = message.notification?.android;

        if (notification != null && android != null) {
          final payload = json.encode({
            'type': message.data['type'],
            'id': message.data['id'],
          });

          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker',
              ),
              iOS: const DarwinNotificationDetails(),
            ),
            payload: payload,
          );
        }
      });
    }
  }

  Future<void> setupNotificationInBacknTerminated(BuildContext context) async {
    void handleMessage(BuildContext context, RemoteMessage message) {}

    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      if (context.mounted) handleMessage(context, initialMessage);
    }
    FirebaseMessaging.onMessageOpenedApp.listen((event) {});
  }
}
