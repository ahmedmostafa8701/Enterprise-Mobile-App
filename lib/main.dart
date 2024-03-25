import 'package:assign_1/screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const Assign());
}

class Assign extends StatelessWidget {
  const Assign({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const LoginScreen(),
    );
  }
}
