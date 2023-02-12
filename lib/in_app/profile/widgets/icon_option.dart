import 'package:flutter/material.dart';

class IconOption extends StatelessWidget {
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  const IconOption(
      {Key? key,
      required this.iconPath,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: isSelected ?
              Theme.of(context).colorScheme.tertiary :
              Theme.of(context).colorScheme.secondary
            ,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ?
                Theme.of(context).colorScheme.primary :
                Theme.of(context).colorScheme.secondary
              ,
              width: 2,
            ),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 180,
              height: 180,
            ),
          ),
        ),
      ),
    );
  }
}
