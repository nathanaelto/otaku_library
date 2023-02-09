import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/secure_storage.service.dart';

class Authentication extends SecureStorageService {
  static final String seed = EnvironmentService.get(EnvironmentVariable.SEED);

  static final String tokenKey = '${seed}_TOKEN_KEY';
  static final String loginKey = '${seed}_LOGIN_KEY';
  static final String passwordKey = '${seed}_PASSWORD_KEY';

  Future<void> storeToken(String token) async {
    set(tokenKey, token);
  }

  Future<void> storeCredentials(String login, String password) async {
    set(loginKey, login);
    set(passwordKey, password);
  }

  Future<String?> getToken() async {
    return get(tokenKey);
  }

  Future<String?> getLogin() async {
    return get(loginKey);
  }

  Future<String?> getPassword() async {
    return get(passwordKey);
  }

  Future<void> deleteAll() async {
    await delete(tokenKey);
    await delete(loginKey);
    await delete(passwordKey);
  }
}