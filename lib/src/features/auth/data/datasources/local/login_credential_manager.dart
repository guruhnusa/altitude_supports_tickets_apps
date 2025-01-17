import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../domain/models/login_credential_model.dart';

class LoginCredentialManager {
  final FlutterSecureStorage _storage;

  LoginCredentialManager._(this._storage);

  static Future<LoginCredentialManager> init() async {
    const storage = FlutterSecureStorage();
    return LoginCredentialManager._(storage);
  }

  Future<void> save({required String username, required String password}) async {
    await _storage.write(key: 'username', value: username);
    await _storage.write(key: 'password', value: password);
  }

  Future<LoginCredentialModel?> read() async {
    final username = await _storage.read(key: 'username');
    final password = await _storage.read(key: 'password');
    final model = LoginCredentialModel(username: username!, password: password!);
    return model;
  }

  Future<void> delete() async {
    await _storage.delete(key: 'username');
    await _storage.delete(key: 'password');
  }
}
