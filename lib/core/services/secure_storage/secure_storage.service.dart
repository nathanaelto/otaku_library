import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  static AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  static IOSOptions _getIOSOptions() => const IOSOptions(accessibility: IOSAccessibility.first_unlock);

  static Future<String?> get(String key) async {
    return _storage.read(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  static Future<void> set(String key, String value) async {
    _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  static Future<void> delete(String key) async {
    _storage.delete(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }
}