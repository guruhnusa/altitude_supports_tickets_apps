import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/models/login_model.dart';

class UserManager {
  final FlutterSecureStorage _storage;

  UserManager._(this._storage);

  static Future<UserManager> init() async {
    const storage = FlutterSecureStorage();
    return UserManager._(storage);
  }

  Future<void> save({required User user}) async {
    final userData = user.toJson();
    await _storage.write(key: 'user', value: jsonEncode(userData));
  }

  Future<User?> read() async {
    final userData = await _storage.read(key: 'user');
    if (userData != null) {
      final user = User.fromJson(jsonDecode(userData));
      log('User : ${user.toJson()}');
      return user;
    } else {
      return null;
    }
  }

  Future<void> delete() async {
    await _storage.delete(key: 'user');
  }
}
