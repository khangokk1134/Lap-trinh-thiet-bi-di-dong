import 'package:flutter/material.dart';

void main() {
  runApp(const LibraryApp());
}

class LibraryApp extends StatelessWidget {
  const LibraryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Library Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LibraryHomePage(),
    );
  }
}

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final TextEditingController _studentController = TextEditingController();

  // Dữ liệu mẫu
  final Map<String, List<String>> borrowedBooks = {
    'Nguyen Van A': ['Sách 01', 'Sách 02'],
    'Nguyen Thi B': ['Sách 01'],
    'Nguyen Van C': [],
  };

  String currentStudent = 'Nguyen Van A';

  @override
  void initState() {
    super.initState();
    _studentController.text = currentStudent;
  }

  @override
  Widget build(BuildContext context) {
    List<String> books = borrowedBooks[currentStudent] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hệ thống Quản lý Thư viện',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Sinh viên',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),

            // Ô nhập và nút Thay đổi
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _studentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      currentStudent = _studentController.text.trim();
                      borrowedBooks.putIfAbsent(currentStudent, () => []);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Thay đổi'),
                ),
              ],
            ),
            const SizedBox(height: 20),

            const Text('Danh sách sách',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),

            // Danh sách sách
            Expanded(
              child: books.isEmpty
                  ? Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Bạn chưa mượn quyển sách nào\nNhấn “Thêm” để bắt đầu hành trình đọc sách!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              )
                  : ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.check_box,
                          color: Colors.pink),
                      title: Text(books[index]),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            // Nút Thêm
            Center(
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    borrowedBooks[currentStudent] = [
                      ...books,
                      'Sách 0${books.length + 1}'
                    ];
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                ),
                child: const Text(
                  'Thêm',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

      // Thanh navigation bên dưới
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Quản lý',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'DS Sách',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Sinh viên',
          ),
        ],
      ),
    );
  }
}
