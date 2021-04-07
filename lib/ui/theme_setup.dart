import 'package:flutter/material.dart';

int selectedTheme = 0;

List<ThemeData> getThemes() {
  return [
    ThemeData(
      backgroundColor: Colors.black,
      accentColor: Colors.black,
      primaryColor: Colors.red,
      textTheme: TextTheme(headline6: TextStyle(fontSize: 20)),
    ),
    ThemeData(
      backgroundColor: Colors.black,
      accentColor: Colors.red,
      primaryColor: Colors.blue,
      textTheme: TextTheme(headline6: TextStyle(fontSize: 30)),
    ),
    ThemeData(
        backgroundColor: Colors.black,
        accentColor: Colors.blue,
        primaryColor: Colors.white,
        textTheme: TextTheme(headline6: TextStyle(fontSize: 40))),
  ];
}
