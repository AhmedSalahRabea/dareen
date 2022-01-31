// ignore_for_file: prefer_const_constructors

import 'package:dareen_app/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

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
      titleTextStyle: GoogleFonts.tajawal(
        color: Colors.black,
        fontSize: 22.sp,
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
      selectedLabelStyle: GoogleFonts.tajawal(
        color: Color(0xff0097A7),
      ),
      unselectedLabelStyle: GoogleFonts.tajawal(
        color: Colors.grey,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.tajawal(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      //for head lines in product details screen
      bodyText2: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Color(0xff0097A7),
      ),
      //for text form fields
      subtitle1: GoogleFonts.tajawal(
        fontSize: 16.sp,
        color: Colors.black,
      ),

      //for subtitles in settings screen
      subtitle2: GoogleFonts.tajawal(
        fontSize: 12.sp,
        color: Colors.grey,
      ),

      headline1: GoogleFonts.tajawal(
        fontSize: 25.sp,
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
        fontSize: 22.sp,
        fontWeight: FontWeight.bold,
      ),
      // backwardsCompatibility: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Color(0xff333739),
        statusBarIconBrightness: Brightness.light,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //    type: BottomNavigationBarType.shifting,
      selectedItemColor: Color(0xff0097A7),
      elevation: 20.0,
      backgroundColor: Color(0xff333739),
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: GoogleFonts.tajawal(
        color: Color(0xff0097A7),
      ),
      unselectedLabelStyle: GoogleFonts.tajawal(
        color: Colors.grey,
      ),
    ),
    textTheme: TextTheme(
      bodyText1: GoogleFonts.tajawal(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),

      //for head lines in product details screen
      bodyText2: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.bold,
        color: Color(0xff0097A7),
      ),

      //for text form fields
      subtitle1: GoogleFonts.tajawal(
        fontSize: 16.sp,
        color: Colors.white,
      ),

      //for subtitles in settings screen
      subtitle2: GoogleFonts.tajawal(
        fontSize: 12.sp,
        color: Colors.grey,
      ),

      headline1: GoogleFonts.tajawal(
        fontSize: 25.sp,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
