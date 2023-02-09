import 'package:OtakuLibrary/core/models/utils/codable.dart';

class CreateUserResponseDto implements Decodable<CreateUserResponseDto, Map<String, dynamic>> {
  late String id;
  late String email;
  late String pseudo;

  @override
  CreateUserResponseDto decode(Map<String, dynamic> jsonObject) {
    CreateUserResponseDto createUserResponseDto = CreateUserResponseDto();
    createUserResponseDto.id = DecodableTools.decodeString(jsonObject, 'id');
    createUserResponseDto.email = DecodableTools.decodeString(jsonObject, 'email');
    createUserResponseDto.pseudo = DecodableTools.decodeString(jsonObject, 'pseudo');
    return createUserResponseDto;
  }
}
