import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Updated gold color (change the hex if you prefer another exact gold)
  static const Color gold = Color(0xFFD4AF37); // classic rich gold
  static const Color darkGold = Color(0xFFB8862B);

  static final TextStyle headlineGold = GoogleFonts.playfairDisplay(
    color: Colors.white,
    fontWeight: FontWeight.w700,
    letterSpacing: 1.2,
  );

  static final TextStyle bodyWhite = GoogleFonts.cairo(
    color: Colors.white70,
    fontWeight: FontWeight.w500,
  );

  static final TextStyle buttonLabel = GoogleFonts.cairo(
    color: Colors.white,
    fontWeight: FontWeight.w700,
  );

  static final TextStyle buttonSublabel = GoogleFonts.cairo(
    color: Colors.white.withOpacity(0.85),
    fontSize: 12,
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: gold,
    scaffoldBackgroundColor: Colors.black,
    textTheme: TextTheme(
      headline1: headlineGold,
      bodyText1: bodyWhite,
      bodyText2: bodyWhite,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: headlineGold.copyWith(fontSize: 20),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}