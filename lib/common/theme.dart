import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final appTheme = ThemeData(
  primarySwatch: Colors.yellow,
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: GoogleFonts.robotoTextTheme(TextTheme(
    headline1: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 34,
      color: Colors.black,
    ),
  )),
);
