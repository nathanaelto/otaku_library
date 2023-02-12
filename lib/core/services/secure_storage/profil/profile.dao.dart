import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/secure_storage.service.dart';

class ProfileDao {
  static final String seed = EnvironmentService.get(EnvironmentVariable.SEED);
  static final String profileKey = '${seed}_ICON_PROFILE_KEY';

  static Future<void> storeProfile(String iconProfile) async {
    SecureStorageService.set(profileKey, iconProfile);
  }

  static Future<String?> getProfile() async {
    return SecureStorageService.get(profileKey);
  }

  static Future<void> deleteProfile() async {
    await SecureStorageService.delete(profileKey);
  }
}