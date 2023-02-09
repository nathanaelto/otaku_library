import 'package:flutter/material.dart';

class OtakuCheckBox extends StatefulWidget {
  const OtakuCheckBox({
    Key? key,
    required this.text,
    required this.isChecked,
    required this.onChanged
  }) : super(key: key);

  final String text;
  final bool isChecked;
  final Function(bool? value) onChanged;

  @override
  State<OtakuCheckBox> createState() => _OtakuCheckBoxState();
}

class _OtakuCheckBoxState extends State<OtakuCheckBox> {

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            activeColor: Theme.of(context).colorScheme.tertiary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            value: widget.isChecked,
            onChanged: (value) {
              widget.onChanged(value);
            }),
        Text(
          widget.text,
          style: Theme.of(context).textTheme.bodyText1,
        )
      ],
    );
  }
}
