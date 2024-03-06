// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryColor = Color(0xff5D9CEC);
  static Color backgroundlight = Color(0xffDFECDB);
  static Color whiteColor = Color(0xffFFFFFF);
  static Color greenColor = Color(0xff61E757);
  static Color grayColor = Color(0xffC8C9CB);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff383838);
  static Color backgrounddark = Color(0xff060E1E);
  static Color bottomColordark = Color(0xff141922);
  static ThemeData lightThem = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundlight,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: whiteColor,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: grayColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),
        titleSmall: TextStyle(
            color: blackColor, fontSize: 25, fontWeight: FontWeight.w400)),
  );

  static ThemeData darkThem = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgrounddark,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 22,
        color: backgrounddark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: primaryColor,
      unselectedItemColor: whiteColor,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      color: bottomColordark,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: backgrounddark,
    ),
    textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: whiteColor,
        ),
        titleMedium: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.w600,
          color: whiteColor,
        ),
        titleSmall: TextStyle(
            color: blackColor, fontSize: 25, fontWeight: FontWeight.w400)),
  );
}
