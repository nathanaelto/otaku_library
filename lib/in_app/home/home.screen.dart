import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/welcome.screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Home Screen'),
            OtakuTextButton(
              text: "Se déconnecter",
              onPressed: () => _logout(context),
            )
          ],
        ),
      )),
    );
  }

  void _logout(BuildContext context) async {
    await AuthenticationDao.deleteAll();
    _goToWelcome();
  }
  void _goToWelcome() {
    Navigator.of(context).pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false);
  }
}
