import 'dart:convert';

import 'package:OtakuLibrary/core/models/utils/codable.dart';

class ChangePasswordDto implements Decodable<ChangePasswordDto, Map<String, dynamic>>, Encodable {
  late String oldPassword;
  late String newPassword;

  @override
  ChangePasswordDto decode(Map<String, dynamic> jsonObject) {
    ChangePasswordDto user = ChangePasswordDto();
    user.oldPassword = DecodableTools.decodeString(jsonObject, 'oldPassword');
    user.newPassword = DecodableTools.decodeString(jsonObject, 'newPassword');
    return user;
  }
  
  Map<String, dynamic> toMap(){
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword
    };
  }

  @override
  String encode() {
    return jsonEncode(toMap());
  }
}
