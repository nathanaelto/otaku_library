import 'package:OtakuLibrary/authentication/login.screen.dart';
import 'package:OtakuLibrary/authentication/validators/validators.dart';
import 'package:OtakuLibrary/core/models/authentication/create_user.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/create_user_response.dto.dart';
import 'package:OtakuLibrary/core/models/authentication/login_response.dto.dart';
import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/authentication/authentication.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/in_app/home.screen.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_check_box.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_password_field.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_text_form_field.dart';
import 'package:OtakuLibrary/shared/widgets/toast.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
  ValueNotifier<bool> keepMeSignedCheckBox = ValueNotifier(false);
  final _registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'S\'inscrire',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            Form(
              key: _registerKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtakuTextFormField(
                    hint: "Pseudo",
                    icon: Icons.person,
                    fillColor: Colors.white,
                    inputType: TextInputType.text,
                    inputAction: TextInputAction.next,
                    focusNode: _focusNodes[0],
                    validator: pseudoValidator,
                    controller: pseudoController,
                  ),
                  OtakuTextFormField(
                    hint: "Email",
                    icon: Icons.email,
                    fillColor: Colors.white,
                    inputType: TextInputType.emailAddress,
                    inputAction: TextInputAction.next,
                    focusNode: _focusNodes[1],
                    validator: emailValidator,
                    controller: emailController,
                  ),
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    inputAction: TextInputAction.next,
                    focusNode: _focusNodes[2],
                    validator: passwordValidator,
                    controller: passwordController,
                  ),
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    inputAction: TextInputAction.done,
                    focusNode: _focusNodes[3],
                    validator: passwordValidator,
                    controller: confirmPasswordValidator,
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
                  const SizedBox(height: 20),
                  OtakuTextButton(
                    text: 'S\'inscrire',
                    onPressed: _onRegisterPressed,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Déjà un compte ?",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const Padding(
                  padding: EdgeInsets.all(10),
                ),
                OtakuTextButton(
                  color:
                      Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  text: "Se connecter",
                  onPressed: _onLoginPressed,
                ),
              ],
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

  void _onRegisterPressed() {
    _registerKey.currentState!.validate();
    register(emailController.text, passwordController.text,
        pseudoController.text, context);
  }

  void register(String email, String password, String pseudo,
      BuildContext context) async {
    CreateUserDto user =
        CreateUserDto(email: email, password: password, pseudo: pseudo);
    ServiceResponse<LoginResponseDto> serviceResponse =
        await AuthenticationService.createUser(user);

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
      print("Error while storing token : $e");
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

  void _onLoginPressed() {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }
}
