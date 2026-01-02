import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../themes/app_theme.dart';

class LanguageSelectionScreen extends StatelessWidget {
  final void Function(Locale locale) onLanguageSelected;

  const LanguageSelectionScreen({Key? key, required this.onLanguageSelected})
      : super(key: key);

  void _selectLanguage(BuildContext context, Locale locale) {
    // Set the locale via callback
    onLanguageSelected(locale);
    // Navigate to Main Voice Hub using named route
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _startWithoutSelecting(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/main');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Starry background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/star_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Gold shimmer overlay (subtle)
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppTheme.gold.withOpacity(0.08),
                    AppTheme.gold.withOpacity(0.12),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      'Beido',
                      style: AppTheme.headlineGold.copyWith(fontSize: 44),
                    ),
                    const SizedBox(height: 12),

                    // Subtitle in English and Arabic (Arabic uses RTL)
                    Text(
                      'Choose your language',
                      style: AppTheme.bodyWhite.copyWith(fontSize: 18),
                    ),
                    const SizedBox(height: 6),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'اختر لغتك',
                        style: AppTheme.bodyWhite.copyWith(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // Card with language choices
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.35),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppTheme.gold.withOpacity(0.5)),
                        boxShadow: [
                          BoxShadow(
                            color: AppTheme.gold.withOpacity(0.14),
                            blurRadius: 30,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // English Button
                          _LanguageButton(
                            label: 'English',
                            sublabel: 'Start in English',
                            onTap: () => _selectLanguage(context, const Locale('en')),
                            showHeartAsset: true,
                          ),

                          const SizedBox(height: 16),

                          // Arabic Button (ensured RTL)
                          _LanguageButton(
                            label: 'العربية',
                            sublabel: 'ابدأ بالعربية',
                            rtl: true,
                            onTap: () => _selectLanguage(context, const Locale('ar')),
                            showHeartAsset: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Small gold hearts decoration row
                    SizedBox(
                      width: size.width * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          5,
                          (i) => _HeartIconSmall(),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Let's Start button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () => _startWithoutSelecting(context),
                        child: Text(
                          "Let's Start",
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageButton extends StatelessWidget {
  final String label;
  final String sublabel;
  final VoidCallback onTap;
  final bool rtl;
  final bool showHeartAsset;

  const _LanguageButton({
    Key? key,
    required this.label,
    required this.sublabel,
    required this.onTap,
    this.rtl = false,
    this.showHeartAsset = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final content = Row(
      children: [
        // Heart icon (SVG if available, otherwise fallback)
        Container(
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [AppTheme.gold, AppTheme.gold.withOpacity(0.8)],
              center: Alignment(-0.3, -0.3),
              radius: 0.9,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.gold.withOpacity(0.22),
                blurRadius: 8,
                offset: const Offset(0, 2),
              )
            ],
          ),
          child: Center(
            child: Builder(builder: (context) {
              // Try to render SVG asset; if not found, use Icon fallback
              try {
                return SvgPicture.asset(
                  'assets/icons/heart.svg',
                  width: 24,
                  height: 24,
                  color: Colors.white,
                );
              } catch (_) {
                return const Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 22,
                );
              }
            }),
          ),
        ),
        const SizedBox(width: 14),

        // Texts
        Expanded(
          child: Column(
            crossAxisAlignment:
                rtl ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Directionality(
                textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  label,
                  style: AppTheme.buttonLabel.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 4),
              Directionality(
                textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
                child: Text(
                  sublabel,
                  style: AppTheme.buttonSublabel,
                ),
              ),
            ],
          ),
        ),

        // Arrow
        Icon(
          Icons.arrow_forward_ios,
          color: AppTheme.gold,
          size: 18,
        ),
      ],
    );

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(12),
        ),
        child: content,
      ),
    );
  }
}

class _HeartIconSmall extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppTheme.gold,
        boxShadow: [
          BoxShadow(
            color: AppTheme.gold.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.favorite,
          size: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}