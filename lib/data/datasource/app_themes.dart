import 'package:flutter/material.dart';

enum AppTheme {
  Light,
  Dark,
}

final appThemeData = {
  AppTheme.Light: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    textSelectionColor: Colors.grey[900],
    hintColor: Colors.grey,
    primaryColorDark: Color(0xffcccccc),
  ),
  AppTheme.Dark: ThemeData(
      textSelectionColor: Colors.grey[900],
      brightness: Brightness.dark,
      hintColor: Colors.black,
      textSelectionHandleColor: Colors.black,
      primaryColorDark: Colors.black,
      primaryColor: Color(0xff000000)),
};
