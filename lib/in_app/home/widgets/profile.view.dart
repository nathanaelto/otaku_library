import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/user/user.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/welcome.screen.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user/user.dart';
import '../../../shared/widgets/otaku_error.dart';
import '../../profile/change_password.screen.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: _fetchUser(),
        builder: (BuildContext context, AsyncSnapshot<ServiceResponse<User>> userResponse) {
          if (userResponse.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }

          return _buildUser(userResponse.data!, context);
        },
      ),
    );
  }

  Future<ServiceResponse<User>> _fetchUser() async {
    return UserService.getMe();
  }

  Widget _buildUser(ServiceResponse<User> userResponse, BuildContext context) {

    if (userResponse.hasError || userResponse.data == null) {
      return const OtakuError();
    }

    final User user = userResponse.data!;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Pseudo :${user.pseudo}"),
        const SizedBox(height: 10),
        Text("Email :${user.email}"),
        const SizedBox(height: 10),
        OtakuTextButton(
          text: "Changer de mot de passe",
          onPressed: () => _changePassword(context),
        ),
        const SizedBox(height: 10),
        OtakuTextButton(
          text: "Se déconnecter",
          onPressed: () => _logout(context),
        )
      ],
    );
  }

  void _logout(BuildContext context) {
    AuthenticationDao.deleteAll().then((value) => _goToWelcome(context));
  }

  void _changePassword(BuildContext context) {
    Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
  }

  void _goToWelcome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        WelcomeScreen.routeName, (route) => false);
  }

}
