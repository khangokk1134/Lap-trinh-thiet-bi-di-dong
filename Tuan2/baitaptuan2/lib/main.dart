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
      home: AgeCheckScreen(),
    );
  }
}

class AgeCheckScreen extends StatefulWidget {
  @override
  _AgeCheckScreenState createState() => _AgeCheckScreenState();
}

class _AgeCheckScreenState extends State<AgeCheckScreen> {
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  String _result = "";

  void _checkAge() {
    String name = _nameController.text.trim();
    String ageText = _ageController.text.trim();

    if (name.isEmpty || ageText.isEmpty) {
      setState(() {
        _result = "Vui lòng nhập đầy đủ thông tin!";
      });
      return;
    }

    int? age = int.tryParse(ageText);
    if (age == null) {
      setState(() {
        _result = "Tuổi phải là số!";
      });
      return;
    }

    String category;
    if (age > 65) {
      category = "Người già";
    } else if (age >= 6 && age <= 65) {
      category = "Người lớn";
    } else if (age >= 2 && age < 6) {
      category = "Trẻ em";
    } else {
      category = "Em bé";
    }

    setState(() {
      _result = "$name - $category";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thực hành 01"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: "Họ và tên",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Tuổi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkAge,
              child: const Text("Kiểm tra"),
            ),
            const SizedBox(height: 20),
            Text(
              _result,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
