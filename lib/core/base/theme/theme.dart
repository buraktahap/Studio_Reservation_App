import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final darkTheme = ThemeData(
  primaryColorDark: const Color(0xff373856),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      color: Colors.white,
    ),
  ),
);

final lightTheme = ThemeData(
  fontFamily: GoogleFonts.raleway().fontFamily,
  cardTheme: CardTheme(elevation: 5, shadowColor: Colors.black),
  shadowColor: const Color(0xffFF34C6),
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.black,
  ),
  primaryColorLight: Colors.white,
  textTheme: TextTheme(
    bodyText1: TextStyle(
      color: Colors.black,
      fontFamily: GoogleFonts.raleway().fontFamily,
      fontWeight: FontWeight.w700,
    ),
  ),
  iconTheme: IconThemeData(
    color: Color(0xff212338),
  ),
  primarySwatch: Colors.grey,
  primaryColor: Colors.white,
  brightness: Brightness.light,
  backgroundColor: Colors.white,
  accentColor: Color(0xff212338),
  accentIconTheme: IconThemeData(color: Colors.white),
  dividerColor: Colors.white54,
);
