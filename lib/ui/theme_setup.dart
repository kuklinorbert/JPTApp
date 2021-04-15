import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

int selectedTheme = 0;

List<ThemeData> getThemes() {
  return [
    //piros
    ThemeData(
        accentColor: Color.fromRGBO(251, 222, 68, 1),
        backgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(246, 80, 88, 1),
        scaffoldBackgroundColor: Color.fromRGBO(40, 51, 74, 1),
        dividerColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Color.fromRGBO(251, 222, 68, 1)),
        )),
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          labelStyle: GoogleFonts.oxygen(color: Colors.white),
          hintStyle: GoogleFonts.oxygen(color: Colors.white),
        ),
        textTheme: TextTheme(
            headline1: GoogleFonts.oxygen(
                color: Color.fromRGBO(251, 222, 68, 1), fontSize: 30),
            subtitle2: GoogleFonts.oxygen(
                color: Color.fromRGBO(251, 222, 68, 1), fontSize: 16),
            button: GoogleFonts.oxygen(color: Colors.black),
            headline6: GoogleFonts.oxygen(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            bodyText1:
                GoogleFonts.oxygen(color: Color.fromRGBO(251, 222, 68, 1)),
            bodyText2: GoogleFonts.oxygen(fontSize: 17))),
    //zold
    ThemeData(
        accentColor: Color.fromRGBO(125, 180, 108, 1),
        backgroundColor: Colors.white,
        primaryColor: Color.fromRGBO(125, 180, 108, 1),
        scaffoldBackgroundColor: Color.fromRGBO(231, 235, 224, 1),
        dividerColor: Color.fromRGBO(125, 180, 108, 1),
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.sourceSansPro(),
          hintStyle: GoogleFonts.sourceSansPro(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(125, 180, 108, 1)),
        )),
        textTheme: TextTheme(
            headline1:
                GoogleFonts.sourceSansPro(color: Colors.black, fontSize: 25),
            subtitle2: GoogleFonts.sourceSansPro(fontSize: 17),
            button: GoogleFonts.sourceSansPro(color: Colors.black),
            headline6: GoogleFonts.sourceSansPro(
                color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
            bodyText2: GoogleFonts.sourceSansPro(fontSize: 19))),
    //fekete
    ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.white,
        backgroundColor: Color.fromRGBO(48, 48, 48, 1),
        primaryColor: Colors.black,
        dividerColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          labelStyle: GoogleFonts.robotoSlab(),
          hintStyle: GoogleFonts.robotoSlab(),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        )),
        textTheme: TextTheme(
            headline1:
                GoogleFonts.robotoSlab(color: Colors.white, fontSize: 25),
            subtitle2: GoogleFonts.robotoSlab(fontSize: 16),
            button: GoogleFonts.robotoSlab(color: Colors.black),
            headline6: GoogleFonts.robotoSlab(
                color: Colors.white, fontWeight: FontWeight.bold),
            bodyText2: GoogleFonts.robotoSlab(fontSize: 17)))
  ];
}
