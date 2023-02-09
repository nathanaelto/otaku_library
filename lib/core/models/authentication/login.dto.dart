import 'dart:convert';

import 'package:OtakuLibrary/core/models/utils/codable.dart';

class LoginDto implements Encodable {
  String email;
  String password;

  LoginDto({required this.email, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
    };
  }

  @override
  String encode() {
    return jsonEncode(toMap());
  }
}