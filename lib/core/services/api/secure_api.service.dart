import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';

class SecureApiService {

  static Future<Map<String, String>> getHeaders() async {
    String? token = await AuthenticationDao.getToken();
    if (token != null) {
      return {
        'Authorization': token
      };
    }
    return {
      'Authorization': ''
    };
  }

}