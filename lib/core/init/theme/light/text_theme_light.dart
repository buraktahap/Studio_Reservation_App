import 'package:flutter/material.dart';

class TextThemeLight {
  static TextThemeLight? _instance;
  static TextThemeLight? get instance {
    if (_instance == null) _instance = TextThemeLight._init();
    return _instance;
  }

  TextThemeLight._init();

  final headline1 =
      TextStyle(fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5);
  final headline2 =
      TextStyle(fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5);
  final headline3 = TextStyle(fontSize: 46, fontWeight: FontWeight.w400);
  final headline4 =
      TextStyle(fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25);
  final headline5 = TextStyle(fontSize: 23, fontWeight: FontWeight.w400);
  final headline6 = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.w500, letterSpacing: 0.15);

  final overline =
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5);
}
