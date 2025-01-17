import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage _storage;

  TokenManager._(this._storage);

  static Future<TokenManager> init() async {
    const storage = FlutterSecureStorage();
    return TokenManager._(storage);
  }

  //save token
  Future<void> save({required String token}) async {
    await _storage.write(key: 'token', value: token);
  }

  //read token
  Future<String?> read() async {
    return await _storage.read(key: 'token');
  }

  //delete token
  Future<void> delete() async {
    await _storage.delete(key: 'token');
  }
}
