import 'package:flutter/material.dart';

class BeidoTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: const Color(0xFFF48FB1), // وردي لطيف
      scaffoldBackgroundColor: const Color(0xFFFFF5F7),
      fontFamily: 'Cairo', // إذا كنتِ بتستخدمين خط كايرو المريح
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFFF48FB1),
        primary: const Color(0xFFD81B60),
      ),
    );
  }
}
