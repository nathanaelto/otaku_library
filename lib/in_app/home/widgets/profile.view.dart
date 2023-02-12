import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/services/api/user/user.service.dart';
import 'package:OtakuLibrary/core/services/secure_storage/authentication/authentication.dao.dart';
import 'package:OtakuLibrary/core/services/secure_storage/profil/profile.dao.dart';
import 'package:OtakuLibrary/in_app/profile/change_icon_profile.screen.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/welcome.screen.dart';
import 'package:flutter/material.dart';

import '../../../core/models/user/user.dart';
import '../../../shared/widgets/otaku_error.dart';
import '../../profile/change_password.screen.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String iconPath = "assets/icon/default-profile-image.jpg";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchUser(),
      builder: (BuildContext context,
          AsyncSnapshot<ServiceResponse<User>> userResponse) {
        if (userResponse.connectionState != ConnectionState.done) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          );
        }

        return _buildUser(userResponse.data!, context);
      },
    );
  }

  Future<ServiceResponse<User>> _fetchUser() async {
    String? userIconProfile = await ProfileDao.getProfile();
    if (userIconProfile != null) {
      iconPath = userIconProfile;
    }
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const Spacer(),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(iconPath),
              ),
            ),
            Expanded(
              child: IconButton(
                onPressed: () => _navigateToEditIconProfile(context),
                icon: const Icon(
                  Icons.edit,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ],
        ),
        Center(
          child: Text(
            "Pseudo :${user.pseudo}",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  fontSize: 20,
                ),
          ),
        ),
        const Divider(
          color: Colors.black,
          thickness: 1,
        ),
        Text(
          "Email : ${user.email}",
          style: Theme.of(context).textTheme.headline1!.copyWith(
                fontSize: 20,
              ),
        ),
        const Spacer(),
        OtakuTextButton(
          text: "Changer de mot de passe",
          onPressed: () => _changePassword(context),
        ),
        const SizedBox(height: 10),
        OtakuTextButton(
          text: "Se déconnecter",
          onPressed: () => _logout(context),
        ),
        const SizedBox(height: 40),
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil(WelcomeScreen.routeName, (route) => false);
  }

  void _navigateToEditIconProfile(BuildContext context) async {
    await Navigator.of(context).pushNamed(ChangeIconProfileScreen.routeName);
    setState(() {});
  }
}
