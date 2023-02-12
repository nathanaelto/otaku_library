import 'dart:ffi';

import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/user/change_password.dto.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';
import 'package:OtakuLibrary/core/services/api/secure_api.service.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/http/http_request.dart';
import 'package:http/http.dart';

import '../../../models/user/user.dart';

class UserService {
  static String get _apiUrl =>
      EnvironmentService.get(EnvironmentVariable.API_URL);

  static String get _baseEndPoint => '$_apiUrl/users';

  static Future<ServiceResponse<User>> getMe() async {
    final String endPoint = '$_baseEndPoint/me';
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeFromBodyString<User>(
            response.body, User().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<bool>> changePassword(
      ChangePasswordDto dto) async {
    final String endPoint = '$_baseEndPoint/change-password';
    final Map<String, String> headers = await SecureApiService.getHeaders();

    final Response response =
        await HttpRequest.put(endPoint, headers: headers, body: dto.encode());

    switch (response.statusCode) {
      case 200:
        return ServiceResponse.success(true);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }
}
