import 'dart:typed_data';

import 'package:OtakuLibrary/core/models/books/book.dart';
import 'package:OtakuLibrary/core/models/books/book_chapters.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';
import 'package:OtakuLibrary/core/services/api/secure_api.service.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/http/http_request.dart';
import 'package:http/http.dart';

class BookService {
  static String get _apiUrl =>
      EnvironmentService.get(EnvironmentVariable.API_URL);

  static String get _baseEndPoint => '$_apiUrl/books';

  static Future<ServiceResponse<List<Book>>> getBooks() async {
    final String endPoint = _baseEndPoint;
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeListFromBodyString(
            response.body, Book().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<Book>> getById(String id) async {
    final String endPoint = '$_baseEndPoint/$id';
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeFromBodyString<Book>(
            response.body, Book().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<BookChapters>> getBookChapters(String id) async {
    final String endPoint = '$_baseEndPoint/$id/chapters';
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get(endPoint, headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeFromBodyString<BookChapters>(
            response.body, BookChapters().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<Uint8List>> getBookImage(String id) async {
    final String endPoint = '$_baseEndPoint/$id/image';
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
