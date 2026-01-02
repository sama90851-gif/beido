// Updated quick-reply chip radius to softer rounded corners (22)
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_theme.dart';

class SmartRepliesScreen extends StatefulWidget {
  const SmartRepliesScreen({Key? key}) : super(key: key);

  @override
  State<SmartRepliesScreen> createState() => _SmartRepliesScreenState();
}

class _SmartRepliesScreenState extends State<SmartRepliesScreen> {
  final List<_ChatMessage> _messages = [];
  final List<String> _suggestions = [
    'دقايق وأوصل',
    'تم، من عيوني',
    'مشغولة الحين',
  ];
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _composerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _messages.add(
      _ChatMessage(
        text: 'هلا! وصلتك الرسالة، تبي أجهز لك الشي الحين؟',
        incoming: true,
        author: 'Mona',
        time: 'Now',
      ),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;
    final msg = _ChatMessage(
      text: text.trim(),
      incoming: false,
      author: 'You',
      time: _timeNow(),
    );
    setState(() {
      _messages.add(msg);
    });
    _composerController.clear();
    _scrollToBottom();
  }

  String _timeNow() {
    final dt = DateTime.now();
    return '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  static bool _detectRTL(String text) {
    final arabicReg = RegExp(r'[\u0600-\u06FF]');
    return arabicReg.hasMatch(text);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _composerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.gold,
              child: Text(
                'M',
                style: GoogleFonts.cairo(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mona', style: AppTheme.buttonLabel.copyWith(fontSize: 16)),
                Text('متاحة الآن', style: AppTheme.bodyWhite.copyWith(fontSize: 12)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white70),
            onPressed: () {},
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/star_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.transparent, AppTheme.gold.withOpacity(0.05), Colors.black87],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12 + 56, 14, 14),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: const EdgeInsets.only(bottom: 12, top: 6),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final m = _messages[index];
                        return _ChatRow(
                          message: m,
                          isRtl: _detectRTL(m.text),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Suggestions row — softened radius 22
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      alignment: WrapAlignment.end,
                      children: _suggestions.map((s) {
                        return GestureDetector(
                          onTap: () {
                            _sendMessage(s);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.45),
                              borderRadius: BorderRadius.circular(22),
                              border: Border.all(color: AppTheme.gold.withOpacity(0.14)),
                            ),
                            child: Directionality(
                              textDirection: _detectRTL(s) ? TextDirection.rtl : TextDirection.ltr,
                              child: Text(
                                s,
                                style: GoogleFonts.cairo(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.45),
                            borderRadius: BorderRadius.circular(28),
                            border: Border.all(color: AppTheme.gold.withOpacity(0.08)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _composerController,
                                  style: GoogleFonts.cairo(color: Colors.white),
                                  textDirection: TextDirection.rtl,
                                  decoration: InputDecoration(
                                    hintText: 'اكتب رسالة...',
                                    hintStyle: GoogleFonts.cairo(color: Colors.white70, fontSize: 14),
                                    border: InputBorder.none,
                                  ),
                                  onSubmitted: (t) {
                                    _sendMessage(t);
                                  },
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send, color: AppTheme.gold),
                                onPressed: () => _sendMessage(_composerController.text),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [AppTheme.gold, AppTheme.darkGold],
                            center: const Alignment(-0.2, -0.2),
                            radius: 0.9,
                          ),
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.mic, color: Colors.white),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatRow extends StatelessWidget {
  final _ChatMessage message;
  final bool isRtl;

  const _ChatRow({Key? key, required this.message, required this.isRtl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final incoming = message.incoming;
    if (incoming) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.gold,
              child: Text(
                message.author.isNotEmpty ? message.author[0] : '?',
                style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppTheme.gold.withOpacity(0.12)),
                ),
                child: Directionality(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(message.author, style: GoogleFonts.cairo(color: AppTheme.gold, fontWeight: FontWeight.w700)),
                          const Spacer(),
                          Text(message.time, style: GoogleFonts.cairo(color: Colors.white70, fontSize: 11)),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(message.text, style: GoogleFonts.cairo(color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            const Spacer(),
            Flexible(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.gold, AppTheme.darkGold],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: AppTheme.gold.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 6)),
                  ],
                ),
                child: Directionality(
                  textDirection: isRtl ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(message.text, style: GoogleFonts.cairo(color: Colors.white, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      Text(message.time, style: GoogleFonts.cairo(color: Colors.white70, fontSize: 11)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            CircleAvatar(
              radius: 16,
              backgroundColor: Colors.white12,
              child: Icon(Icons.person, color: Colors.white70, size: 18),
            ),
          ],
        ),
      );
    }
  }
}

class _ChatMessage {
  final String text;
  final bool incoming;
  final String author;
  final String time;

  _ChatMessage({
    required this.text,
    required this.incoming,
    required this.author,
    required this.time,
  });
}