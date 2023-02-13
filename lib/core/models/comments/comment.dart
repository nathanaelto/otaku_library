import 'package:OtakuLibrary/core/models/utils/codable.dart';

class Comment implements Decodable<Comment, Map<String, dynamic>> {
  late String id;
  late String comment;
  late String bookId;
  late String author;
  late DateTime createdAt;

  @override
  Comment decode(Map<String, dynamic> jsonObject) {
    Comment comment = Comment();
    comment.id = DecodableTools.decodeString(jsonObject, 'id');
    comment.comment = DecodableTools.decodeString(jsonObject, 'comment');
    comment.bookId = DecodableTools.decodeString(jsonObject, 'bookId');
    comment.author = DecodableTools.decodeString(jsonObject, 'author');
    comment.createdAt = DecodableTools.decodeDate(jsonObject, 'createdAt');
    return comment;
  }
}