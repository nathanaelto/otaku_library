import 'package:OtakuLibrary/core/services/secure_storage/profil/profile.dao.dart';
import 'package:OtakuLibrary/in_app/profile/widgets/icon_option.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/otaku_text_button.dart';
import 'package:OtakuLibrary/shared/widgets/buttons/recall_back_button.dart';
import 'package:OtakuLibrary/shared/widgets/toast.dart';
import 'package:flutter/material.dart';

class ChangeIconProfileScreen extends StatefulWidget {
  static const String routeName = '/changeIconProfile';

  const ChangeIconProfileScreen({Key? key}) : super(key: key);

  @override
  State<ChangeIconProfileScreen> createState() =>
      _ChangeIconProfileScreenState();
}

class _ChangeIconProfileScreenState extends State<ChangeIconProfileScreen> {
  int _iconSelected = 0;

  final List<String> listIcons = [
    "assets/icon/angel.png",
    "assets/icon/demon.png",
    "assets/icon/elfe.png",
    "assets/icon/ninja.png",
    "assets/icon/sayan.png",
    "assets/icon/robot.png",
    "assets/icon/samurai.png",
    "assets/icon/dragon.png",
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context).pop();
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.06,
                child: Row(
                  children: [
                    RecallBackButton(
                      onBack: () => Navigator.of(context).pop(),
                    ),
                    Text(
                      "Choisir un icône",
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                            fontSize: 25,
                          ),
                    ),
                  ],
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.72,
                child: SingleChildScrollView(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listIcons.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return IconOption(
                        iconPath: listIcons[index],
                        isSelected: _iconSelected == index,
                        onTap: () => _onIconSelected(index),
                      );
                    },
                  ),
                ),
              ),
              const Divider(
                color: Colors.black,
                thickness: 1,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: OtakuTextButton(
                    text: "Valider",
                    onPressed: _onValidate,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onIconSelected(int index) {
    setState(() {
      _iconSelected = index;
    });
  }

  void _onValidate() async {
    try {
      await ProfileDao.storeProfile(listIcons[_iconSelected]);
    } catch (e) {
      _displayToast();
    }
    _back();
  }

  void _displayToast() {
    Toast.show("Erreur lors de la sauvegarde de l'icône", context, duration: 5, backgroundColor: Colors.red);
  }

  void _back() {
    Navigator.of(context).pop(listIcons[_iconSelected]);
  }
}
