import 'package:OtakuLibrary/authentication/register.screen.dart';
import 'package:OtakuLibrary/authentication/validators/validators.dart';
import 'package:OtakuLibrary/core/models/authentication/login.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/login_response.dto.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/authentication/authentication.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/in_app/home/home.screen.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_check_box.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_password_field.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_text_form_field.dart';
import 'package:OtakuLibrary/shared/widgets/toast.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  ValueNotifier<bool> keepMeSignedCheckBox = ValueNotifier(false);

  final _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: Text(
          'Se connecter',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Form(
              key: _loginKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    focusNode: _focusNodes[1],
                    validator: passwordValidator,
                    inputAction: TextInputAction.done,
                    controller: passwordController,
                  ),
                  ValueListenableBuilder<bool>(
                    valueListenable: keepMeSignedCheckBox,
                    builder: (context, value, _) {
                      return OtakuCheckBox(
                        text: "Rester connecté",
                        isChecked: value,
                        onChanged: onCheckBoxChange,
                      );
                    },
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  OtakuTextButton(
                    text: "Se connecter",
                    onPressed: onLoginPressed,
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vous n'avez pas de compte ?",
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  const Spacer(),
                  OtakuTextButton(
                      color:
                          Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                      text: "S'inscrire",
                      onPressed: onRegisterPressed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onCheckBoxChange(bool? value) {
    if (value != null) {
      keepMeSignedCheckBox.value = value;
      keepMeSignedCheckBox.notifyListeners();
    }
  }

  void onLoginPressed() {
    _loginKey.currentState!.validate();
    login(emailController.text, passwordController.text);
  }

  void onRegisterPressed() {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }

  void login(String email, String password) async {
    LoginDto loginDto = LoginDto(email: email, password: password);
    ServiceResponse<LoginResponseDto> serviceResponse = await AuthenticationService.login(loginDto);

    if (serviceResponse.hasError) {
      _displayError(serviceResponse.error ?? "Une erreur est survenue");
      return;
    }

    if (serviceResponse.data == null) {
      _displayError("Une erreur est survenue");
      return;
    }

    try {
      await AuthenticationDao.storeToken(serviceResponse.data!.token);
    } catch (e) {
      _displayError("Impossible de se connecter");
      return;
    }

    if (keepMeSignedCheckBox.value) {
      try {
        await AuthenticationDao.storeCredentials(email, password);
      } catch (e) {
        print("Error while storing credentials : $e");
      }
    }
    _navigateToHome();
  }

  void _navigateToHome() {
    Navigator.of(context).pushNamedAndRemoveUntil(HomeScreen.routeName, (route) => false);
  }

  void _displayError(String error) {
    Toast.show(error, context, duration: 5, backgroundColor: Colors.red);
  }
}
