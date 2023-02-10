import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/welcome.screen.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("ProfileView"),
        OtakuTextButton(
          text: "Se déconnecter",
          onPressed: () => _logout(context),
        )
      ],
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
