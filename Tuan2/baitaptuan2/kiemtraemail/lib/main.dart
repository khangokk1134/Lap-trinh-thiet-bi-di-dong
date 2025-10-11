import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: EmailValidationPage(),
    );
  }
}

class EmailValidationPage extends StatefulWidget {
  const EmailValidationPage({super.key});
  @override
  State<EmailValidationPage> createState() => _EmailValidationPageState();
}

class _EmailValidationPageState extends State<EmailValidationPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController  = TextEditingController();
  final TextEditingController _emailController= TextEditingController();

  String? _emailMessage; // thông báo lỗi/ok cho email
  Color _emailMessageColor = Colors.red;

  void _checkEmail() {
    final email = _emailController.text.trim();

    setState(() {
      if (email.isEmpty) {
        _emailMessage = "Email không hợp lệ";
        _emailMessageColor = Colors.red;
      } else if (!email.contains('@')) {
        _emailMessage = "Email không đúng định dạng";
        _emailMessageColor = Colors.red;
      } else {
        _emailMessage = "Bạn đã nhập email hợp lệ";
        _emailMessageColor = Colors.green;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thực hành - Kiểm tra Email"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Nhập thông tin",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Tên
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Tên",
                hintText: "Nhập tên",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            // Tuổi
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Tuổi",
                hintText: "Nhập tuổi",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),

            // Email
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "vd: example@gmail.com",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),

            // Thông báo cho email
            const SizedBox(height: 10),
            if (_emailMessage != null)
              Text(
                _emailMessage!,
                style: TextStyle(color: _emailMessageColor, fontSize: 16),
              ),

            const SizedBox(height: 20),

            // Nút kiểm tra
            ElevatedButton(
              onPressed: _checkEmail,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text("Kiểm tra"),
            ),
          ],
        ),
      ),
    );
  }
}
