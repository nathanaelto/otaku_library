import 'package:flutter/material.dart';

class MangasView extends StatefulWidget {
  const MangasView({Key? key}) : super(key: key);

  @override
  State<MangasView> createState() => _MangasViewState();
}

class _MangasViewState extends State<MangasView> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: const [
          Text("MangasView"),
        ],
      ),
    );
  }
}
