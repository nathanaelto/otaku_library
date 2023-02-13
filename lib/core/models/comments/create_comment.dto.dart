import 'dart:convert';
import 'package:OtakuLibrary/core/models/utils/codable.dart';

class CreateCommentDto implements Encodable {
  String comment;
  String bookId;

  CreateCommentDto({required this.comment, required this.bookId});

  Map<String, dynamic> toMap() {
    return {
      'comment': comment,
      'bookId': bookId,
    };
  }

  @override
  String encode() {
    return jsonEncode(toMap());
  }
}