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
      }
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();
  TextEditingController confirmPasswordValidator = TextEditingController();

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode()
  ];
  ValueNotifier<bool> checkBox = ValueNotifier(false);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: RecallBackButton(
                  onBack: () {
                    print("Back");
                  },
                ),
              ),
              Text(
                'Home',
                style: Theme.of(context).textTheme.headline1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtakuTextButton(
                    color:
                        Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                    text: "Login",
                    onPressed: () => print("Login"),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  OtakuTextButton(
                    text: "Register",
                    onPressed: () => print("Register"),
                  ),
                ],
              ),
              ValueListenableBuilder<bool>(
                valueListenable: checkBox,
                builder: (context, checkBoxValue, _) {
                  return OtakuCheckBox(
                    text: "Check me",
                    isChecked: checkBoxValue,
                    onChanged: (bool? value) {
                      if (value != null) {
                        checkBox.value = value;
                        checkBox.notifyListeners();
                      }
                    },
                  );
                },
              ),
              OtakuTextFormField(
                hint: "Email",
                icon: Icons.email,
                fillColor: Colors.white,
                inputType: TextInputType.emailAddress,
                inputAction: TextInputAction.next,
                focusNode: _focusNodes[0],
                validator: emailValidator,
                controller: emailController,
              ),
              OtakuTextFormField(
                hint: "Pseudo",
                icon: Icons.person,
                fillColor: Colors.white,
                inputType: TextInputType.text,
                inputAction: TextInputAction.next,
                focusNode: _focusNodes[1],
                validator: pseudoValidator,
                controller: pseudoController,
              ),
              OtakuPasswordField(
                fillColor: Colors.white,
                focusNode: _focusNodes[2],
                validator: passwordValidator,
                inputAction: TextInputAction.next,
                controller: passwordController,
              ),
              OtakuPasswordField(
                fillColor: Colors.white,
                focusNode: _focusNodes[3],
                validator: passwordValidator,
                inputAction: TextInputAction.done,
                controller: confirmPasswordValidator,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
