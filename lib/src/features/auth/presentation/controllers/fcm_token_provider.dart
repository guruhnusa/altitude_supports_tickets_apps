import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fcm_token_provider.g.dart';

@riverpod
Future<String> fcmToken(Ref ref) async {
  try {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token;

    if (Platform.isIOS) {
      // Coba dapatkan APNS token dulu
      token = await messaging.getAPNSToken();

      // Jika APNS token null, coba FCM token
      token ??= await messaging.getToken();
    } else {
      // Untuk Android langsung pakai getToken
      token = await messaging.getToken();
    }

    return token ?? '';
  } catch (e) {
    // Jika terjadi error, coba sekali lagi dengan getToken
    try {
      final token = await FirebaseMessaging.instance.getToken();
      return token ?? '';
    } catch (_) {
      return '';
    }
  }
}
