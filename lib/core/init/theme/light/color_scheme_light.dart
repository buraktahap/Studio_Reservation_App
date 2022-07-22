import 'package:flutter/material.dart';

class ColorSchemeLight {
  static ColorSchemeLight? _instance;
  static ColorSchemeLight? get instance {
    if (_instance == null) _instance = ColorSchemeLight._init();
    return _instance;
  }

  ColorSchemeLight._init();

  final Color brown = Color(0xffa87e6f);
  final Color darkTileColor = Color(0xffe8e8e8);
  final Color lightTileColor = Color(0xfff5f5f5);
  final Color white = Color(0xffF9EEDF);
  final Color gray = Color(0xffa5a6ae); // xx
  final Color lightGray = Color(0xfff7f7f7);
  final Color darkGray = Color(0xff676870);
  final Color scaffoldBackgroundColor = Color(0xfff0f1f6);
  final Color black = Color(0xff020306);
  final Color mitaBlue = Color(0xff2972ff);
  // final Color darkAppColor = Colors.blueGrey.shade700;
  final Color darkAppColor = Colors.lightBlue.shade800;
  final Color mitaRed = Color(0xffEE2538);
  final Color mitaGreen = Color(0xff62AD46);
  final Color onError = Color(0xffffc93c);
  final Color outlineInputBorderColor = Colors.black87;
  final Color fabButtonColorLight = Color(0xffffc93c).withOpacity(0.9);
  final Color appBarTitleColor = Color(0xFF31201B);
  final Color blueGreyShade = Colors.blueGrey.shade500;

  final Color boldGreen = Color(0xff27928d);
}
