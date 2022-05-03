import 'package:flutter/material.dart';

// ignore_for_file: non_constant_identifier_names

abstract class AppTheme {
  static MaterialColor PRIMARY_COLOR = MaterialColor(
    4287446506,
    <int, Color>{
      50: Color.fromRGBO(
        141,
        61,
        234,
        .1,
      ),
      100: Color.fromRGBO(
        141,
        61,
        234,
        .2,
      ),
      200: Color.fromRGBO(
        141,
        61,
        234,
        .3,
      ),
      300: Color.fromRGBO(
        141,
        61,
        234,
        .4,
      ),
      400: Color.fromRGBO(
        141,
        61,
        234,
        .5,
      ),
      500: Color.fromRGBO(
        141,
        61,
        234,
        .6,
      ),
      600: Color.fromRGBO(
        141,
        61,
        234,
        .7,
      ),
      700: Color.fromRGBO(
        141,
        61,
        234,
        .8,
      ),
      800: Color.fromRGBO(
        141,
        61,
        234,
        .9,
      ),
      900: Color.fromRGBO(
        141,
        61,
        234,
        1,
      ),
    },
  );

  static MaterialColor SECONDARY_COLOR = MaterialColor(
    0xff3442F6,
    <int, Color>{
      50: Color.fromRGBO(
        52,
        66,
        246,
        .1,
      ),
      100: Color.fromRGBO(
        52,
        66,
        246,
        .2,
      ),
      200: Color.fromRGBO(
        52,
        66,
        246,
        .3,
      ),
      300: Color.fromRGBO(
        52,
        66,
        246,
        .4,
      ),
      400: Color.fromRGBO(
        52,
        66,
        246,
        .5,
      ),
      500: Color.fromRGBO(
        52,
        66,
        246,
        .6,
      ),
      600: Color.fromRGBO(
        52,
        66,
        246,
        .7,
      ),
      700: Color.fromRGBO(
        52,
        66,
        246,
        .8,
      ),
      800: Color.fromRGBO(
        52,
        66,
        246,
        .9,
      ),
      900: Color.fromRGBO(
        52,
        66,
        246,
        1,
      ),
    },
  );

  static ThemeData THEME = ThemeData(
    primaryColor: const Color(0xff8d3dea),
    primarySwatch: PRIMARY_COLOR,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xff8d3dea),
        ),
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: PRIMARY_COLOR,
      primaryVariant: PRIMARY_COLOR,
      secondary: SECONDARY_COLOR,
      secondaryVariant: SECONDARY_COLOR.shade700,
    ),
  );

  static ThemeData DARK_THEME = ThemeData(
    primaryColor: const Color(0xff8d3dea),
    primarySwatch: PRIMARY_COLOR,
    backgroundColor: Color(0xff101010),
    dialogBackgroundColor: Color(0xff101010),
    scaffoldBackgroundColor: Color(0xff101010),
    canvasColor: Color(0xff121212),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xff121212),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          Color(0xff8d3dea),
        ),
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: PRIMARY_COLOR,
      primaryVariant: PRIMARY_COLOR,
      secondary: SECONDARY_COLOR,
      secondaryVariant: SECONDARY_COLOR.shade700,
    ),
  );
}
