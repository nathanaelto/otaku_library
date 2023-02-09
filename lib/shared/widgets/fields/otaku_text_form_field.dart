import 'package:flutter/material.dart';

class OtakuTextFormField extends StatelessWidget {
  const OtakuTextFormField(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.fillColor,
      required this.inputType,
      required this.inputAction,
      required this.focusNode,
      required this.validator,
      this.controller})
      : super(key: key);

  final String hint;
  final IconData icon;
  final Color fillColor;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          color: Theme.of(context).colorScheme.primary,
        ),
        cursorColor: Theme.of(context).colorScheme.tertiary,
        keyboardType: inputType,
        textInputAction: inputAction,
        focusNode: focusNode,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          filled: true,
          fillColor: fillColor,
          border: Theme.of(context).inputDecorationTheme.border,
          enabledBorder: Theme.of(context).inputDecorationTheme.border,
          hintText: hint,
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
                  icon,
                  color: focusNode.hasFocus
                      ? Theme.of(context).colorScheme.tertiary
                      : Theme.of(context).colorScheme.primary.withOpacity(0.8),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
