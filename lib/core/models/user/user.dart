import 'package:OtakuLibrary/core/models/utils/codable.dart';

class User implements Decodable<User, Map<String, dynamic>> {
  late String email;
  late String pseudo;

  @override
  User decode(Map<String, dynamic> jsonObject) {
    User user = User();
    user.pseudo = DecodableTools.decodeString(jsonObject, 'pseudo');
    user.email = DecodableTools.decodeString(jsonObject, 'email');
    return user;
  }
}
