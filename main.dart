import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/language_selection.dart';
import 'screens/main_voice_hub.dart';
import 'screens/smart_replies.dart';
import 'screens/smart_reminders.dart';
import 'screens/quran_screen.dart';
import 'themes/app_theme.dart';

void main() {
  runApp(BeidoApp());
}

class BeidoApp extends StatefulWidget {
  @override
  State<BeidoApp> createState() => _BeidoAppState();
}

class _BeidoAppState extends State<BeidoApp> {
  Locale? _locale;

  void _setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Beido',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      locale: _locale,
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      initialRoute: '/',
      routes: {
        '/': (ctx) => LanguageSelectionScreen(onLanguageSelected: _setLocale),
        '/main': (_) => MainVoiceHubScreen(),
        '/smart': (_) => const SmartRepliesScreen(),
        '/reminders': (_) => const SmartRemindersScreen(),
        '/quran': (_) => const QuranScreen(),
      },
    );
  }
}