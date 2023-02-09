import 'package:OtakuLibrary/CBZReader.dart';
import 'package:OtakuLibrary/authentication/validators/validators.dart';
import 'package:OtakuLibrary/shared/otaku_library_theme.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/recall_back_button.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_check_box.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_password_field.dart';
import 'package:OtakuLibrary/shared/widgets/fields/otaku_text_form_field.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const OtakuLibraryApp());
}

class OtakuLibraryApp extends StatelessWidget {
  const OtakuLibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Otaku Library',
      debugShowCheckedModeBanner: false,
      theme: otakuLibraryTheme(),
      home: HomeView(),
      // home: CBZReader(filePath: 'assets/cbz/Chapitre_4.cbz'),
    );
  }
}

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pseudoController = TextEditingController();

  final List<FocusNode> _focusNodes = [FocusNode(), FocusNode(), FocusNode()];
  ValueNotifier<bool> checkBox = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: const RecallBackButton(),
            ),
            Text(
              'Home',
              style: Theme.of(context).textTheme.headline1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtakuTextButton(
                  color: Theme.of(context).colorScheme.tertiary.withOpacity(0.7),
                  text: "Login",
                  onPressed: () => print("Login"),
                ),
                Padding(padding: const EdgeInsets.all(10),),
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
              controller: passwordController,
            ),
          ],
        ),
      ),
    );
  }
}
