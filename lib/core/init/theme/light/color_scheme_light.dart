import 'package:flutter/material.dart';

class ColorSchemeLight {
  static ColorSchemeLight? _instance;
  static ColorSchemeLight? get instance {
    _instance ??= ColorSchemeLight._init();
    return _instance;
  }

  ColorSchemeLight._init();

  final Color brown = const Color(0xffa87e6f);
  final Color darkTileColor = const Color(0xffe8e8e8);
  final Color lightTileColor = const Color(0xfff5f5f5);
  final Color white = const Color(0xffF9EEDF);
  final Color gray = const Color(0xffa5a6ae); // xx
  final Color lightGray = const Color(0xfff7f7f7);
  final Color darkGray = const Color(0xff676870);
  final Color scaffoldBackgroundColor = const Color(0xfff0f1f6);
  final Color black = const Color(0xff020306);
  final Color mitaBlue = const Color(0xff2972ff);
  // final Color darkAppColor = Colors.blueGrey.shade700;
  final Color darkAppColor = Colors.lightBlue.shade800;
  final Color mitaRed = const Color(0xffEE2538);
  final Color mitaGreen = const Color(0xff62AD46);
  final Color onError = const Color(0xffffc93c);
  final Color outlineInputBorderColor = Colors.black87;
  final Color fabButtonColorLight = const Color(0xffffc93c).withOpacity(0.9);
  final Color appBarTitleColor = const Color(0xFF31201B);
  final Color blueGreyShade = Colors.blueGrey.shade500;

  final Color boldGreen = const Color(0xff27928d);
}
