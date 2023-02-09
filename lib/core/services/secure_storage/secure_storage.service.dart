import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
    encryptedSharedPreferences: true,
  );
  IOSOptions _getIOSOptions() => const IOSOptions(accessibility: IOSAccessibility.first_unlock);

  Future<String?> get(String key) async {
    return _storage.read(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  Future<void> set(String key, String value) async {
    _storage.write(
        key: key,
        value: value,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }

  Future<void> delete(String key) async {
    _storage.delete(
        key: key,
        iOptions: _getIOSOptions(),
        aOptions: _getAndroidOptions()
    );
  }
}