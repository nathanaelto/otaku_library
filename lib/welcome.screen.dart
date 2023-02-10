import 'package:OtakuLibrary/authentication/login.screen.dart';
import 'package:OtakuLibrary/authentication/register.screen.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome';
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Bienvenue',
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OtakuTextButton(
                    color:
                    Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                    text: "Se connecter",
                    onPressed: () => _goToLogin(context)
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                  ),
                  OtakuTextButton(
                    text: "S'inscrire",
                    onPressed: () => _goToRegister(context),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _goToLogin(BuildContext context) {
    Navigator.of(context).pushNamed(LoginScreen.routeName);
  }

  void _goToRegister(BuildContext context) {
    Navigator.of(context).pushNamed(RegisterScreen.routeName);
  }
}
