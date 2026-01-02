import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF5F7), // نفس خلفية بيدو الهادية
      appBar: AppBar(
        title: const Text('عالم بيدو 🌸'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFD81B60),
      ),
      body: SingleChildScrollView( // عشان لو كثرت المهام نقدر ننزل تحت
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "نورتي مكانكِ يا جميلة.. ✨",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF880E4F)),
            ),
            const SizedBox(height: 20),
            
            // قسم مهام اليوم
            const Text(
              "مهام اليوم بكل هدوء:",
              style: TextStyle(fontSize: 18, color: Color(0xFFD81B60), fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 15),
            
            // قائمة المهام (بشكل بطاقات لطيفة)
            _buildTaskItem("شرب كوب ماء منعش 💧", true),
            _buildTaskItem("خمس دقائق تأمل وهدوء 🧘‍♀️", false),
            _buildTaskItem("كتابة إنجاز واحد سويتيه اليوم ✨", false),
            _buildTaskItem("ابتسامة جميلة للمرآة 😊", false),
          ],
        ),
      ),
    );
  }

  // دالة بسيطة لبناء شكل المهمة
  Widget _buildTaskItem(String task, bool isDone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.pink.withOpacity(0.05), blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        children: [
          Icon(
            isDone ? Icons.check_circle : Icons.radio_button_unchecked,
            color: const Color(0xFFF48FB1),
          ),
          const SizedBox(width: 15),
          Text(
            task,
            style: TextStyle(
              fontSize: 16,
              decoration: isDone ? TextDecoration.lineThrough : null,
              color: isDone ? Colors.grey : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
