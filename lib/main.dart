import 'package:OtakuLibrary/CBZReader.dart';
import 'package:OtakuLibrary/authentication/login.screen.dart';
import 'package:OtakuLibrary/authentication/register.screen.dart';
import 'package:OtakuLibrary/authentication/validators/validators.dart';
import 'package:OtakuLibrary/core/models/authentication/login.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/login_response.dto.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/authentication/authentication.service.dart';
import 'package:OtakuLibrary/core/services/env/environment.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/in_app/book/book.screen.dart';
import 'package:OtakuLibrary/in_app/chapter/chapter_reader.screen.dart';
import 'package:OtakuLibrary/in_app/home/home.screen.dart';
import 'package:OtakuLibrary/shared/otaku_library_theme.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/recall_back_button.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_check_box.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_password_field.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_text_form_field.dart';
import 'package:OtakuLibrary/welcome.screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await EnvironmentService.load();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  bool isLogged = await autoLogin();

  runApp(OtakuLibraryApp(isLogged: isLogged));
}

Future<bool> autoLogin() async {
  String? loginStore = await AuthenticationDao.getLogin();
  String? passwordStore = await AuthenticationDao.getPassword();
  if (loginStore == null && passwordStore == null) {
    return false;
  }
  String login = loginStore ?? "";
  String password = passwordStore ?? "";
  LoginDto loginDto = LoginDto(email: login, password: password);
  ServiceResponse<LoginResponseDto> serviceResponse = await AuthenticationService.login(loginDto);
  if (serviceResponse.hasError) {
    return false;
  }
  if (serviceResponse.data != null) {
    try {
      await AuthenticationDao.storeToken(serviceResponse.data!.token);
    } catch (e) {
      return false;
    }
  }
  return true;
}

class OtakuLibraryApp extends StatelessWidget {
  final bool isLogged;
  const OtakuLibraryApp({super.key, required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku Library',
      debugShowCheckedModeBanner: false,
      theme: otakuLibraryTheme(),
      initialRoute: isLogged ?
        HomeScreen.routeName :
        WelcomeScreen.routeName,
      routes: {
        WelcomeScreen.routeName: (context) => const WelcomeScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        BookScreen.routeName: (context) => const BookScreen(),
        ChapterReaderScreen.routeName: (context) => const ChapterReaderScreen(),
      }
    );
  }
}
