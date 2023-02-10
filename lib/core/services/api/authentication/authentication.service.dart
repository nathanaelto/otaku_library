import 'dart:math';

import 'package:OtakuLibrary/core/models/authentication/create_user.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/login.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/login_response.dto.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/http/http_request.dart';
import 'package:http/http.dart';

class AuthenticationService {
  static String get _apiUrl =>
      EnvironmentService.get(EnvironmentVariable.API_URL);

  static String get _baseEndPoint => '$_apiUrl/auth';

  static Future<ServiceResponse<LoginResponseDto>> createUser(
      CreateUserDto createUser) async {
    final String endPoint = '$_baseEndPoint/register';
    final Response response =
        await HttpRequest.post(endPoint, body: createUser.encode());

    switch (response.statusCode) {
      case 201:
        return DecodableTools.decodeFromBodyString<LoginResponseDto>(
            response.body, LoginResponseDto().decode);
      case 409:
        return ServiceResponse.error('Email already exists');
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<LoginResponseDto>> login(LoginDto login) async {
    final String endPoint = '$_baseEndPoint/login';
    final Response response =
        await HttpRequest.post(endPoint, body: login.encode());

    switch (response.statusCode) {
      case 201:
        return DecodableTools.decodeFromBodyString<LoginResponseDto>(
            response.body, LoginResponseDto().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }
}
