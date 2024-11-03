import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xffdeebda);
  static const Color lightSecondary = Color(0xff5D9CEC);
  static const Color lightGreen = Color(0xff61E757);
  static const Color unSelectedIconColor = Color(0xffC8C9CB);
  static const Color darkPrimary = Color(0xff060e1e);
  static const Color darkSecondary = Color(0xff5d9beb);
  static const Color darkBottomNav = Color(0xff141922);
  static ThemeData lightTheme = ThemeData(
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: lightSecondary),
          bodySmall: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: Color(0xff363636)),
          titleSmall: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
          bodyMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w300, color: darkPrimary),
          bodyLarge: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
              color: Color(0xff004182))),
      cardTheme: CardTheme(
        margin: EdgeInsets.only(
          right: 27,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      scaffoldBackgroundColor: lightPrimary,
      appBarTheme: AppBarTheme(
          toolbarHeight: 157,
          backgroundColor: lightSecondary,
          titleTextStyle: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700)),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedIconTheme: IconThemeData(
            color: lightSecondary,
            size: 33,
          ),
          unselectedIconTheme:
              IconThemeData(color: unSelectedIconColor, size: 33),
          backgroundColor: Colors.transparent,
          elevation: 0),
      useMaterial3: false,
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: 40,
          backgroundColor: lightSecondary,
          shape:
              CircleBorder(side: BorderSide(color: Colors.white, width: 3))));
  static ThemeData darkTheme = ThemeData(
      textTheme: TextTheme(
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w700, color: lightSecondary),
          bodySmall: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white)),
      cardTheme: CardTheme(
        margin: EdgeInsets.only(left: 33, right: 27, top: 45),
        color: darkBottomNav,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
      appBarTheme: AppBarTheme(
          toolbarHeight: 157,
          backgroundColor: darkSecondary,
          titleTextStyle: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.w700)),
      scaffoldBackgroundColor: darkPrimary,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          iconSize: 40,
          backgroundColor: darkSecondary,
          shape:
              CircleBorder(side: BorderSide(color: Colors.white, width: 3))));
}
