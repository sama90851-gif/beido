import 'package:flutter/material.dart';
import 'screens/register_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(const BeidoApp());
}

class BeidoApp extends StatelessWidget {
  const BeidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beido',
      debugShowCheckedModeBanner: false,
      theme: BeidoTheme.lightTheme, // نستخدم الثيم اللي سويناه
      home: const RegisterScreen(), // نخلي أول شاشة هي التسجيل
    );
  }
}
