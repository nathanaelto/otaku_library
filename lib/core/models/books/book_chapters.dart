import 'package:OtakuLibrary/core/models/books/book.dart';
import 'package:OtakuLibrary/core/models/chapters/chapter.dart';
import 'package:OtakuLibrary/core/models/utils/codable.dart';

class BookChapters {
  late List<Chapter> chapters;
  late Book book;

  @override
  BookChapters decode(Map<String, dynamic> jsonObject) {
    BookChapters bookChapters = BookChapters();
    bookChapters.book = DecodableTools.decodeNestedObject(
        jsonObject, "book", Book().decode);
    bookChapters.chapters = DecodableTools.decodeNestedList(
        jsonObject, "chapters", Chapter().decode);
    return bookChapters;
  }
}
