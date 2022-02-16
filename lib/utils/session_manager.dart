import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:health_plus/app_constants.dart';

import 'jwt.dart';

class SessionManager {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> get token async {
    return _storage.read(key: AppConstants.accessTokenKey);
  }

  static Future<bool> get isAuthenticated async {
    final jwtToken = await token;
    return jwtToken != null && !Jwt.isExpired(jwtToken);
  }

  static Future<void> initialize(String token) async {
    await _storage.write(
      key: AppConstants.accessTokenKey,
      value: token,
    );
  }

  static Future<void> invalidate() async {
    await _storage.delete(key: AppConstants.accessTokenKey);
  }
}
