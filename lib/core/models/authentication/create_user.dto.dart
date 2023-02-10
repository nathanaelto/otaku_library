import 'dart:convert';
import 'package:OtakuLibrary/core/models/utils/codable.dart';

class CreateUserDto implements Encodable {
  String email;
  String password;
  String pseudo;

  CreateUserDto({required this.email, required this.password, required this.pseudo});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'pseudo': pseudo,
    };
  }

  @override
  String encode() {
    return jsonEncode(toMap());
  }
}