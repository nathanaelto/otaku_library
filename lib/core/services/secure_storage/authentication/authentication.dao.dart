import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/secure_storage.service.dart';

class AuthenticationDao extends SecureStorageService {
  static final String seed = EnvironmentService.get(EnvironmentVariable.SEED);

  static final String tokenKey = '${seed}_TOKEN_KEY';
  static final String loginKey = '${seed}_LOGIN_KEY';
  static final String passwordKey = '${seed}_PASSWORD_KEY';

  static Future<void> storeToken(String token) async {
    SecureStorageService.set(tokenKey, token);
  }

  static Future<void> storeCredentials(String login, String password) async {
    SecureStorageService.set(loginKey, login);
    SecureStorageService.set(passwordKey, password);
  }

  static Future<String?> getToken() async {
    return SecureStorageService.get(tokenKey);
  }

  static Future<String?> getLogin() async {
    return SecureStorageService.get(loginKey);
  }

  static Future<String?> getPassword() async {
    return SecureStorageService.get(passwordKey);
  }

  static Future<void> deleteAll() async {
    await SecureStorageService.delete(tokenKey);
    await SecureStorageService.delete(loginKey);
    await SecureStorageService.delete(passwordKey);
  }
}