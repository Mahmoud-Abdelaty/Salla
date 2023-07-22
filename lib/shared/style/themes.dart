// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/style/colors.dart';


ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.indigoAccent,
      selectionHandleColor: Colors.indigo,
      cursorColor: Colors.indigo
  ),
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    backgroundColor: Colors.black,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: HexColor('#0a0a0a'),
    elevation: 50,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor[900],
    unselectedItemColor : defaultColor[300],
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
  ),
  fontFamily: 'Jannah',
);

ThemeData lightTheme = ThemeData(
  primarySwatch: defaultColor,
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: Colors.indigoAccent,
    selectionHandleColor: Colors.indigo,
    cursorColor: Colors.indigo
  ),
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(
        color: Colors.black
    ),
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    elevation: 20,
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor[900],
    unselectedItemColor : defaultColor[300],
  ),
  textTheme: TextTheme(
    bodyText1: TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
  ),
  fontFamily: 'Jannah',
);