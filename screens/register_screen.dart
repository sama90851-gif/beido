import 'package:flutter/material.dart';
import 'home_screen.dart'; // هذا السطر المهم اللي يربطنا بالشاشة الرئيسية

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 20)),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'متى حابه نحتفل فيكِ؟ 🎂',
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });

      // نختبر إذا كان اليوم هو يوم ميلادها (بما إن اليوم 2 يناير)
      DateTime today = DateTime.now();
      if (picked.month == today.month && picked.day == today.day) {
        _showBirthdayDialog(context);
      }
    }
  }

  void _showBirthdayDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text("يا بعد قلبي! ✨", textAlign: TextAlign.center),
          content: const Text(
            "كل عام وأنتِ شخص مميز بالحياة.. 🤍\nبيدو تتمنى لكِ سنة مليانة حب وجمال مثل قلبكِ.",
            textAlign: TextAlign.center,
          ),
          actions: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); 
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD81B60),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text("دخول لعالم بيدو 🌸", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "يا هلا بجميلتنا! ✨",
              style: TextStyle(fontSize: 26, color: Color(0xFFD81B60), fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFFD81B60),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: Text(_selectedDate == null 
                  ? 'شاركينا يوم ميلادكِ المميز 🌸' 
                  : 'موعدنا يوم: ${_selectedDate!.day}/${_selectedDate!.month} 🎉'),
            ),
          ],
        ),
      ),
    );
  }
}
