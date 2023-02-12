import 'dart:typed_data';

import 'package:OtakuLibrary/core/models/chapters/chapter.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';
import 'package:OtakuLibrary/core/services/api/secure_api.service.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/http/http_request.dart';
import 'package:http/http.dart';

class ChaptersService {
  static String get _apiUrl =>
      EnvironmentService.get(EnvironmentVariable.API_URL);

  static String get _baseEndPoint => '$_apiUrl/chapters';

  static Future<ServiceResponse<Chapter>> getById(String id) async {
    final String endPoint = '$_baseEndPoint/$id';
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeFromBodyString<Chapter>(
            response.body, Chapter().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<Uint8List>> getChapterBuffer(String id) async {
    final String endPoint = '$_baseEndPoint/$id/buffer';
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return ServiceResponse.success(response.bodyBytes);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

}