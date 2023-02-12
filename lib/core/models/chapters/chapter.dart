import 'package:OtakuLibrary/core/models/utils/codable.dart';

class Chapter implements Decodable<Chapter, Map<String, dynamic>> {
  late String id;
  late String title;
  late String path;
  late int chapterNumber;
  late String bookId;

  @override
  Chapter decode(Map<String, dynamic> jsonObject) {
    Chapter chapter = Chapter();
    chapter.id = DecodableTools.decodeString(jsonObject, '_id');
    chapter.title = DecodableTools.decodeString(jsonObject, 'title');
    chapter.path = DecodableTools.decodeString(jsonObject, 'path');
    chapter.chapterNumber = DecodableTools.decodeInt(jsonObject, 'chapterNumber');
    chapter.bookId = DecodableTools.decodeString(jsonObject, 'bookId');
    return chapter;
  }
}