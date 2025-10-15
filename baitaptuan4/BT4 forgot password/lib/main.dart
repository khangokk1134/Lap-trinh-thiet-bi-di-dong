import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'forget_password_page.dart';
import 'reset_password_page.dart';
import 'confirm_page.dart';
import 'verify_code_page.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forget Password Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) =>  ForgetPasswordPage(),
        '/reset': (context) =>  ResetPasswordPage(),
        '/confirm': (context) =>  ConfirmPage(),
      },
    );
  }
}
