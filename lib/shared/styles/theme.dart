// ignore_for_file: prefer_const_constructors

import 'package:dareen_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData myLightThemeMode = ThemeData(
    primaryColor: Color(0xff0097A7),
    primarySwatch: Palette.myColor,
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff0097A7),
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      // backwardsCompatibility: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // type: BottomNavigationBarType.shifting,
      selectedItemColor: Color(0xff0097A7),
      elevation: 20.0,
      backgroundColor: Colors.white,
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      //for head lines in product details screen
      bodyText2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff0097A7),
      ),
      //for text form fields
      subtitle1: TextStyle(
        fontSize: 16,
        color: Colors.black,
      ),
      //for subtitles in settings screen
      subtitle2: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
      headline1: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
  static ThemeData myDarkThemeMode = ThemeData(
    primaryColor: Color(0xff0097A7),
    primarySwatch: Palette.myColor,
    scaffoldBackgroundColor: Color(0xff333739),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xff0097A7),
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Color(0xff333739),
      elevation: 0.0,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
      // backwardsCompatibility: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff121212),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //    type: BottomNavigationBarType.shifting,
      selectedItemColor: Color(0xff0097A7),
      elevation: 20.0,
      backgroundColor: Color(0xff333739),
      unselectedItemColor: Colors.grey,
    ),
    textTheme: TextTheme(
      bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      //for head lines in product details screen
      bodyText2: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Color(0xff0097A7),
      ),
      //for text form fields
      subtitle1: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      //for subtitles in settings screen
      subtitle2: TextStyle(
        fontSize: 14,
        color: Colors.grey,
      ),
      headline1: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
