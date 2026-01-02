import 'package:flutter/material.dart';
import 'screens/register_screen.dart'; // استدعاء شاشة التسجيل
import 'themes/app_theme.dart';       // استدعاء الثيم الوردي

void main() {
  runApp(const BeidoApp());
}

class BeidoApp extends StatelessWidget {
  const BeidoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beido | بيدو',
      debugShowCheckedModeBanner: false, // عشان نشيل العلامة المزعجة اللي فوق
      
      // نستخدم الثيم الهادئ اللي صممناه في مجلد themes
      theme: BeidoTheme.lightTheme, 
      
      // نخلي التطبيق يبدأ من شاشة التسجيل اللي فيها مفاجأة الميلاد
      home: const RegisterScreen(), 
      
      // لدعم اللغة العربية والخطوط بشكل أفضل
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl, // عشان يكون التطبيق عربي ومرتب
          child: child!,
        );
      },
    );
  }
}
