import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Trang cá nhân'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await AuthService().signOut();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/');
              }
            },
          ),
        ],
      ),
      body: Center(
        child: user == null
            ? const Text('Không có người dùng nào đăng nhập')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Xin chào, \${user.email}!'),
            const SizedBox(height: 20),
            const Text('Đăng nhập thành công 🎉'),
          ],
        ),
      ),
    );
  }
}