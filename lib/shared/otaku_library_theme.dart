import 'package:flutter/material.dart';

ThemeData otakuLibraryTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    fontFamily: 'Roboto',
    colorScheme: const ColorScheme.dark(
      primary: Colors.black,
      secondary: Colors.white,
      tertiary: Colors.redAccent,
    ),
    textTheme: const TextTheme(
      headline1: TextStyle(
          fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.white),
      headline2: TextStyle(
          fontSize: 36.0, fontStyle: FontStyle.italic, color: Colors.white),
      bodyText1: TextStyle(fontSize: 18.0, color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      hintStyle: const TextStyle(
        color: Colors.black54,
        fontSize: 18.0,
      ),
    ),
  );
}
