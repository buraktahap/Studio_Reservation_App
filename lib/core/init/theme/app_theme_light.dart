import 'package:flutter/material.dart';
import '../../constants/app/app_contansts.dart';
import 'app_theme.dart';
import 'light/light_theme_interface.dart';

class AppThemeLight extends AppTheme with ILightTheme {
  static AppThemeLight instance = AppThemeLight._init();

  AppThemeLight._init();

  ThemeData get theme => ThemeData(
        colorScheme: _appColorScheme,
        textTheme: buildTextTheme(),
        inputDecorationTheme: InputDecorationTheme(
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: colorSchemeLight.onError, width: 1.0),
            gapPadding: 0,
          ),
          focusedErrorBorder: OutlineInputBorder(
              gapPadding: 0,
              borderSide: BorderSide(
                color: colorSchemeLight.onError,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(20.0)),
          enabledBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: colorSchemeLight.gray, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          border: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: colorSchemeLight.gray, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
          focusedBorder: OutlineInputBorder(
            gapPadding: 0,
            borderSide: BorderSide(color: colorSchemeLight.gray, width: 1),
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        scaffoldBackgroundColor: colorSchemeLight.lightTileColor,
        fontFamily: ApplicationConstants.FONT_FAMILY,
        floatingActionButtonTheme: ThemeData.light()
            .floatingActionButtonTheme
            .copyWith(
                backgroundColor: colorSchemeLight.scaffoldBackgroundColor,
                foregroundColor: colorSchemeLight.darkGray),
        tabBarTheme: TabBarTheme(
          labelPadding: insets.lowPaddingAll,
          unselectedLabelStyle:
              textThemeLight.headline4.copyWith(color: colorSchemeLight.gray),
        ),
        appBarTheme: AppBarTheme(
          // shadowColor: Colors.blueGrey.shade700,
          iconTheme: IconThemeData(color: _appColorScheme.onSurface),
          color: colorSchemeLight.scaffoldBackgroundColor,
          elevation: 1.0,
          toolbarTextStyle: TextTheme(
            headline6: TextStyle(
              color: colorSchemeLight.appBarTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ).bodyText2,
          titleTextStyle: TextTheme(
            headline6: TextStyle(
              color: colorSchemeLight.appBarTitleColor,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ).headline6,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: colorSchemeLight.scaffoldBackgroundColor),
      );

  TextTheme buildTextTheme() {
    return TextTheme(
      headline1: textThemeLight.headline1,
      headline2: textThemeLight.headline1,
      headline6: textThemeLight.headline6,
      overline: textThemeLight.overline,
    );
  }

  ColorScheme get _appColorScheme {
    return ColorScheme(
      primary: colorSchemeLight.black,
      // ignore: deprecated_member_use
      primaryVariant: colorSchemeLight.blueGreyShade, //xx
      secondary: colorSchemeLight.darkAppColor,
      // ignore: deprecated_member_use
      secondaryVariant: colorSchemeLight.scaffoldBackgroundColor, //xx
      surface: colorSchemeLight.lightTileColor,
      background:
          colorSchemeLight.scaffoldBackgroundColor, //xx // green accent idi
      error: colorSchemeLight.mitaRed,
      onPrimary: colorSchemeLight.darkTileColor,
      onSecondary: colorSchemeLight.lightTileColor, //xx
      onSurface: colorSchemeLight.mitaBlue, // xx
      onBackground: Colors.black12,
      onError: colorSchemeLight.onError, //xx
      brightness: Brightness.light,
    );
  }
}
