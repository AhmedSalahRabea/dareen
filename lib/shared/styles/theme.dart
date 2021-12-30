// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTheme {
  static ThemeData myLightThemeMode = ThemeData(
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
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
      selectedItemColor: Colors.deepOrange,
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
        color: Colors.deepOrange,
      ),
      //for subtitles in settings screen
      subtitle1: TextStyle(
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
    primarySwatch: Colors.deepOrange,
    scaffoldBackgroundColor: Colors.black,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.deepOrange,
    ),
    appBarTheme: AppBarTheme(
      titleSpacing: 20,
      backgroundColor: Colors.black,
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
        statusBarColor: Colors.black,
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //    type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.deepOrange,
      elevation: 20.0,
      backgroundColor: Colors.black,
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
        color: Colors.deepOrange,
      ),
      //for subtitles in settings screen
      subtitle1: TextStyle(
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
