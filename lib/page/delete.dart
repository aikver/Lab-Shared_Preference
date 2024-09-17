import 'package:flutter/material.dart';

class DeletePage extends StatelessWidget {
  const DeletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ลบสินค้า'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'หน้านี้คือหน้าลบสินค้า',
              style: TextStyle(fontSize: 20),
            ),
            // เพิ่มฟังก์ชันลบข้อมูลที่นี่
          ],
        ),
      ),
    );
  }
}
