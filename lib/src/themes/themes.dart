import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff284879)
  ),

  brightness: Brightness.dark,

  fontFamily: 'ProximaNova',

  scaffoldBackgroundColor: const Color(0xff21232A),
  
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Color(0xff284879)
  ),
  
  inputDecorationTheme: const InputDecorationTheme(
    // focusedBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(
    //     color: Color(0xff284879)
    //   ) 
    // ),
    border: OutlineInputBorder(),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xff284879)
      ) 
    ),
    floatingLabelStyle: TextStyle(color: Color(0xff2e599b)),
  )
);