// Main Voice Hub with tappable incoming message bubble and bottom nav (Quran / Reminders)
import 'dart:math';
import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class MainVoiceHubScreen extends StatefulWidget {
  @override
  State<MainVoiceHubScreen> createState() => _MainVoiceHubScreenState();
}

class _MainVoiceHubScreenState extends State<MainVoiceHubScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  bool _listening = false;
  bool _showIncoming = true;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  void _toggleListening() {
    setState(() {
      _listening = !_listening;
      if (_listening) {
        _waveController.repeat();
        _showIncoming = false;
      } else {
        _waveController.stop();
      }
    });
  }

  void _onNavTap(int index) {
    // index 0 -> Quran, index 1 -> Reminders
    if (index == 0) {
      Navigator.of(context).pushNamed('/quran');
    } else if (index == 1) {
      Navigator.of(context).pushNamed('/reminders');
    }
  }

  void _openSmartReplies() {
    Navigator.of(context).pushNamed('/smart');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // Starry background
          Positioned.fill(
            child: Image.asset(
              'assets/images/star_bg.png',
              fit: BoxFit.cover,
            ),
          ),

          // Soft gold overlay for depth
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppTheme.gold.withOpacity(0.06),
                    Colors.black.withOpacity(0.28),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 14),
              child: Column(
                children: [
                  // Incoming message bubble at top (from Mona) — tappable to open Smart Replies
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: _showIncoming
                        ? GestureDetector(
                            key: const ValueKey('incoming_mona'),
                            onTap: _openSmartReplies,
                            child: IncomingMessageBubble(
                              name: 'Mona',
                              message: 'مرحبًا! كيف أستطيع مساعدتك اليوم؟',
                              time: 'Now',
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),

                  const SizedBox(height: 12),

                  // Header - include chat icon to go to Smart Replies
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Beido', style: AppTheme.headlineGold.copyWith(fontSize: 28)),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.chat_bubble_outline, color: Colors.white70),
                            onPressed: _openSmartReplies,
                          ),
                          IconButton(
                            icon: const Icon(Icons.star, color: Colors.white70),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    'Voice Hub',
                    style: AppTheme.headlineGold.copyWith(fontSize: 22),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the mic and speak — Beido will listen',
                    style: AppTheme.bodyWhite,
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 28),

                  // Expanded center area with waveform and mic
                  Expanded(
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Waveform appears only while listening
                          AnimatedOpacity(
                            opacity: _listening ? 1.0 : 0.0,
                            duration: const Duration(milliseconds: 300),
                            child: SizedBox(
                              height: 96,
                              child: WaveformVisualizer(
                                controller: _waveController,
                                active: _listening,
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // Central glowing mic button
                          AnimatedMicButton(
                            listening: _listening,
                            onPressed: _toggleListening,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom navigation bar (Quran and Reminders) with central mic FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 86,
        height: 86,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: _toggleListening,
            backgroundColor: AppTheme.gold,
            elevation: 6,
            child: Icon(
              _listening ? Icons.mic : Icons.mic_none,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: Colors.black.withOpacity(0.6),
        elevation: 12,
        notchMargin: 8,
        child: SizedBox(
          height: 72,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Quran (left)
              _NavItem(
                icon: Icons.menu_book,
                label: 'Quran',
                onTap: () => _onNavTap(0),
              ),

              // spacer for FAB
              SizedBox(width: 86),

              // Reminders (right)
              _NavItem(
                icon: Icons.notification_add,
                label: 'Reminders',
                onTap: () => _onNavTap(1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// IncomingMessageBubble, AnimatedMicButton, WaveformVisualizer and _NavItem
/// Reused implementations follow (same visuals as before).

class IncomingMessageBubble extends StatelessWidget {
  final String name;
  final String message;
  final String time;

  const IncomingMessageBubble({
    Key? key,
    required this.name,
    required this.message,
    required this.time,
  }) : super(key: key);

  static bool _detectRTL(String text) {
    final arabicReg = RegExp(r'[\u0600-\u06FF]');
    return arabicReg.hasMatch(text);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: AppTheme.gold,
          child: Text(
            name.isNotEmpty ? name[0] : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppTheme.gold.withOpacity(0.18)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gold.withOpacity(0.06),
                  blurRadius: 20,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // name + time
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(name, style: AppTheme.buttonLabel.copyWith(fontSize: 14)),
                    Text(time, style: AppTheme.bodyWhite.copyWith(fontSize: 11)),
                  ],
                ),
                const SizedBox(height: 6),
                Directionality(
                  textDirection: _detectRTL(message) ? TextDirection.rtl : TextDirection.ltr,
                  child: Text(
                    message,
                    style: AppTheme.bodyWhite.copyWith(fontSize: 14),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class AnimatedMicButton extends StatefulWidget {
  final bool listening;
  final VoidCallback onPressed;

  const AnimatedMicButton({Key? key, required this.listening, required this.onPressed})
      : super(key: key);

  @override
  State<AnimatedMicButton> createState() => _AnimatedMicButtonState();
}

class _AnimatedMicButtonState extends State<AnimatedMicButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _glowController;

  @override
  void initState() {
    super.initState();
    _glowController = AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    if (!widget.listening) _glowController.stop();
  }

  @override
  void didUpdateWidget(covariant AnimatedMicButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.listening) {
      _glowController.repeat(reverse: true);
    } else {
      _glowController.stop();
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = 140.0;
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _glowController,
        builder: (context, child) {
          final glow = widget.listening ? (8 + 8 * _glowController.value) : 6.0;
          return Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [AppTheme.gold, AppTheme.darkGold],
                center: const Alignment(-0.2, -0.2),
                radius: 0.9,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.gold.withOpacity(0.5),
                  blurRadius: glow + 16,
                  spreadRadius: glow,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.45),
                  blurRadius: 10,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Center(
              child: Icon(
                widget.listening ? Icons.mic : Icons.mic_none,
                color: Colors.white,
                size: 52,
              ),
            ),
          );
        },
      ),
    );
  }
}

class WaveformVisualizer extends StatefulWidget {
  final AnimationController controller;
  final bool active;

  const WaveformVisualizer({
    Key? key,
    required this.controller,
    this.active = false,
  }) : super(key: key);

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer> {
  final int _bars = 18;
  final double _barWidth = 6.0;
  final double _maxHeight = 84.0;
  final Random _rand = Random();
  late List<double> _phases;

  @override
  void initState() {
    super.initState();
    _phases = List.generate(_bars, (_) => _rand.nextDouble() * pi * 2);
  }

  double _barHeight(int index, double t) {
    final phase = _phases[index];
    final base = 0.5 + 0.5 * sin((t * 2 * pi) + phase);
    final noise = 0.25 * (0.5 + 0.5 * sin((t * 5 * pi) + phase * 1.2));
    final factor = widget.active ? (base + noise) : (0.12 + 0.12 * base);
    return (_maxHeight * factor).clamp(4.0, _maxHeight);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final t = widget.controller.value;
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_bars, (i) {
            final h = _barHeight(i, t);
            return AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _barWidth,
              height: h,
              decoration: BoxDecoration(
                color: AppTheme.gold,
                borderRadius: BorderRadius.circular(6),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.gold.withOpacity(0.28),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
            );
          }),
        );
      },
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavItem({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Colors.white70;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 96,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}