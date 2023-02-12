import 'package:OtakuLibrary/core/models/utils/codable.dart';

class Book implements Decodable<Book, Map<String, dynamic>> {
  late String id;
  late String title;
  late String author;
  late String synopsis;
  late String image;

  @override
  Book decode(Map<String, dynamic> jsonObject) {
    Book book = Book();
    book.id = DecodableTools.decodeString(jsonObject, 'id');
    book.title = DecodableTools.decodeString(jsonObject, 'title');
    book.author = DecodableTools.decodeString(jsonObject, 'author');
    book.synopsis = DecodableTools.decodeString(jsonObject, 'synopsis');
    book.image = DecodableTools.decodeString(jsonObject, 'image');
    return book;
  }

  @override
  String toString() {
    return 'Book{id: $id, title: $title, author: $author, synopsis: $synopsis, image: $image}';
  }

}