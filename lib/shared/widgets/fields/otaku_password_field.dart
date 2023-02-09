import 'package:flutter/material.dart';

class OtakuPasswordField extends StatefulWidget {
  const OtakuPasswordField(
      {Key? key,
      required this.fillColor,
      required this.focusNode,
      required this.validator,
      required this.inputAction,
      this.controller})
      : super(key: key);

  final Color fillColor;
  final FocusNode focusNode;
  final String? Function(String?) validator;
  final TextEditingController? controller;
  final TextInputAction inputAction;

  @override
  State<OtakuPasswordField> createState() => _OtakuPasswordFieldState();
}

class _OtakuPasswordFieldState extends State<OtakuPasswordField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        cursorColor: Theme.of(context).colorScheme.tertiary,
        textInputAction: widget.inputAction,
        focusNode: widget.focusNode,
        obscureText: hidePassword,
        validator: widget.validator,
        controller: widget.controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: widget.fillColor,
          border: Theme.of(context).inputDecorationTheme.border,
          enabledBorder: Theme.of(context).inputDecorationTheme.border,
          hintText: 'Password',
          hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                right: BorderSide(
                  width: 1.5,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(
                  Icons.lock_outline,
                  color: widget.focusNode.hasFocus
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ),
              ),
            ),
          ),
          suffix: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  hidePassword = hidePassword == true ? false : true;
                });
              },
              child: Text(
                'Show',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      decoration: TextDecoration.underline,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
