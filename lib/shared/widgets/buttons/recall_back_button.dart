import 'package:flutter/material.dart';

class RecallBackButton extends StatelessWidget {
  final VoidCallback onBack;
  const RecallBackButton({Key? key, required this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Row(
          children: [
            const Image(
              image: AssetImage('assets/icon/recall_back.png'),
              width: 35,
              height: 35,
            ),
            const Padding(padding: EdgeInsets.all(2),),
            Text(
              'Back',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        )
      )
    );
  }
}
