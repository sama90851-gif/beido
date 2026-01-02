import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../themes/app_theme.dart';

class SmartRemindersScreen extends StatefulWidget {
  const SmartRemindersScreen({Key? key}) : super(key: key);

  @override
  State<SmartRemindersScreen> createState() => _SmartRemindersScreenState();
}

class _SmartRemindersScreenState extends State<SmartRemindersScreen> {
  final List<_Reminder> _items = [
    _Reminder(title: 'اتصال لموكّر', completed: false),
    _Reminder(title: 'موعد العشاء الساعة 8', completed: false),
  ];

  void _addReminder(String title) {
    if (title.trim().isEmpty) return;
    setState(() {
      _items.add(_Reminder(title: title.trim()));
    });
  }

  void _showAddSheet() {
    final controller = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black87,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Add Reminder', style: AppTheme.buttonLabel.copyWith(fontSize: 18)),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  style: GoogleFonts.cairo(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: 'اكتب تذكير...',
                    hintStyle: GoogleFonts.cairo(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white12,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.gold,
                        ),
                        onPressed: () {
                          _addReminder(controller.text);
                          Navigator.of(ctx).pop();
                        },
                        child: Text('Add', style: GoogleFonts.cairo(color: Colors.black)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('Reminders', style: AppTheme.buttonLabel.copyWith(fontSize: 18)),
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 12 + 10, 14, 14),
              child: Column(
                children: [
                  Expanded(
                    child: _items.isEmpty
                        ? Center(
                            child: Text('No reminders yet', style: AppTheme.bodyWhite),
                          )
                        : ListView.builder(
                            itemCount: _items.length,
                            itemBuilder: (context, idx) {
                              final it = _items[idx];
                              return Dismissible(
                                key: ValueKey(it.title + idx.toString()),
                                direction: DismissDirection.endToStart,
                                background: Container(
                                  color: Colors.redAccent,
                                  alignment: Alignment.centerRight,
                                  padding: const EdgeInsets.only(right: 20),
                                  child: const Icon(Icons.delete, color: Colors.white),
                                ),
                                onDismissed: (_) {
                                  setState(() => _items.removeAt(idx));
                                },
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                  leading: Checkbox(
                                    value: it.completed,
                                    activeColor: AppTheme.gold,
                                    onChanged: (v) {
                                      setState(() => it.completed = v ?? false);
                                    },
                                  ),
                                  title: Directionality(
                                    textDirection: _detectRTL(it.title) ? TextDirection.rtl : TextDirection.ltr,
                                    child: Text(
                                      it.title,
                                      style: GoogleFonts.cairo(
                                        color: it.completed ? Colors.white54 : Colors.white,
                                        decoration: it.completed ? TextDecoration.lineThrough : TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  tileColor: Colors.black.withOpacity(0.35),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddSheet,
        backgroundColor: AppTheme.gold,
        child: const Icon(Icons.add, color: Colors.black),
      ),
    );
  }

  static bool _detectRTL(String text) {
    final arabicReg = RegExp(r'[\u0600-\u06FF]');
    return arabicReg.hasMatch(text);
  }
}

class _Reminder {
  String title;
  bool completed;
  _Reminder({required this.title, this.completed = false});
}