// تحديث لدالة اختيار التاريخ في ملف register_screen.dart

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

    // نختبر إذا كان اليوم هو يوم ميلادها
    DateTime today = DateTime.now();
    if (picked.month == today.month && picked.day == today.day) {
      // إظهار رسالة التهنئة اللطيفة
      _showBirthdayDialog(context);
    }
  }
}

// دالة تظهر الرسالة الجميلة
void _showBirthdayDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("يا بعد قلبي! ✨", textAlign: TextAlign.center),
        content: const Text(
          "كل عام وأنتِ شخص مميز بالحياة.. 🤍\nبيدو تتمنى لكِ سنة مليانة حب وجمال مثل قلبكِ.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("شكراً بيدو 🌸"),
          ),
        ],
      );
    },
  );
}
