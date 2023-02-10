import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';

class SecureApiService {

  final AuthenticationDao _authenticationDao = AuthenticationDao();

  Future<Map<String, String>> getHeaders() async {
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