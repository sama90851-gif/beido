import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('بيدو | رفيقتكِ اليومية'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFFD81B60),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // رسالة ترحيبية دافئة
            const Text(
              "نورتي مكانكِ يا جميلة.. ✨",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF880E4F)),
            ),
            const SizedBox(height: 10),
            const Text(
              "كيف حال قلبكِ اليوم؟ أتمنى لكِ يوماً هادئاً مثلكِ.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),
            
            // بطاقة بسيطة لمهام اليوم أو عبارة ملهمة
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.pink.withOpacity(0.05),
                    spreadRadius: 5,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.favorite, color: Color(0xFFF48FB1)),
                  SizedBox(width: 15),
                  Expanded(
                    child: Text(
                      "تذكري دائماً: أنتِ كافية، وأنتِ رائعة كما أنتِ.",
                      style: TextStyle(fontSize: 15, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
            
            // هنا تقدرين تضيفين باقي مميزات بيدو مستقبلاً
          ],
        ),
      ),
      // زر عائم بشكل لطيف
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFD81B60),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
