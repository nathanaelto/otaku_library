import 'package:OtakuLibrary/core/models/comments/comment.dart';
import 'package:OtakuLibrary/core/models/comments/create_comment.dto.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';
import 'package:OtakuLibrary/core/services/api/secure_api.service.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/http/http_request.dart';
import 'package:http/http.dart';

class CommentsService {
  static String get _apiUrl =>
      EnvironmentService.get(EnvironmentVariable.API_URL);

  static String get _baseEndPoint => '$_apiUrl/comments';

  static Future<ServiceResponse<Comment>> createComment(
      String comment, String bookId) async {
    final Map<String, String> headers = await SecureApiService.getHeaders();
    CreateCommentDto createCommentDto =
        CreateCommentDto(comment: comment, bookId: bookId);
    final Response response = await HttpRequest.post(_baseEndPoint,
        headers: headers, body: createCommentDto.encode());

    switch (response.statusCode) {
      case 201:
        return DecodableTools.decodeFromBodyString<Comment>(
            response.body, Comment().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }

  static Future<ServiceResponse<List<Comment>>> getCommentsByBookId(String bookId) async {
    final Map<String, String> headers = await SecureApiService.getHeaders();
    final Response response = await HttpRequest.get('$_baseEndPoint/$bookId', headers: headers);

    switch (response.statusCode) {
      case 200:
        return DecodableTools.decodeListFromBodyString(response.body, Comment().decode);
      default:
        return ServiceResponse.error('Une erreur est survenue !');
    }
  }
}
