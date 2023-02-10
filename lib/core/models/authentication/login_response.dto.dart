import 'package:OtakuLibrary/core/models/utils/codable.dart';

class LoginResponseDto implements Decodable<LoginResponseDto, Map<String, dynamic>> {
  late String token;

  @override
  LoginResponseDto decode(Map<String, dynamic> jsonObject) {
    LoginResponseDto loginResponseDto = LoginResponseDto();
    loginResponseDto.token = DecodableTools.decodeString(jsonObject, 'access_token');
    return loginResponseDto;
  }
}