import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Simple placeholder screen — replace with real content later
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Quran', style: AppTheme.buttonLabel.copyWith(fontSize: 18)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Positioned.fill(child: Image.asset('assets/images/star_bg.png', fit: BoxFit.cover)),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppTheme.gold.withOpacity(0.04), Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Text(
                'Quran screen placeholder\n(implement list of Surahs here)',
                style: AppTheme.bodyWhite,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}