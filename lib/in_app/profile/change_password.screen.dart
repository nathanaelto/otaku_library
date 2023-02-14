import 'package:OtakuLibrary/core/models/common/service_response.dart';
import 'package:OtakuLibrary/core/models/user/change_password.dto.dart';
import 'package:OtakuLibrary/core/services/api/authentication/authentication.service.dart';
import 'package:flutter/material.dart';

import '../../authentication/validators/validators.dart';
import '../../core/services/api/user/user.service.dart';
import '../../core/services/secure_storage/authentication/authentication.dao.dart';
import '../../shared/widgets/buttons/otaku_text_button.dart';
import '../../shared/widgets/fields/otaku_password_field.dart';
import '../../shared/widgets/toast.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const String routeName = '/changePassword';

  ChangePasswordScreen({Key? key}) : super(key: key);

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordController2 = TextEditingController();
  final TextEditingController passwordController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Changer de mot de passe',
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Form(
                  child: Column(
                children: [
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    focusNode: _focusNodes[0],
                    validator: passwordValidator,
                    inputAction: TextInputAction.done,
                    controller: passwordController,
                  ),
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    focusNode: _focusNodes[1],
                    validator: passwordValidator,
                    inputAction: TextInputAction.done,
                    controller: passwordController2,
                  ),
                  OtakuPasswordField(
                    fillColor: Colors.white,
                    focusNode: _focusNodes[2],
                    validator: passwordValidator,
                    inputAction: TextInputAction.done,
                    controller: passwordController3,
                  ),
                ],
              )),
              const SizedBox(height: 20),
              OtakuTextButton(
                text: "Changer de mot de passe",
                onPressed: () => _changePassword(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _changePassword(BuildContext context) async {
    ChangePasswordDto changePasswordDto = ChangePasswordDto();
    changePasswordDto.oldPassword = passwordController.text;
    changePasswordDto.newPassword = passwordController2.text;

    ServiceResponse<bool> response = await UserService.changePassword(changePasswordDto);

    if (response.hasError || response.data == null)
    {
      Toast.show("Error", context,
          duration: 5, backgroundColor: Colors.red);
    }
    else
    {
      await AuthenticationDao.deletePassword();
      Toast.show("Success", context,
          duration: 5, backgroundColor: Colors.green);

      Navigator.of(context).pop();
    }

  }
}
