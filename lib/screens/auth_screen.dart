import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Text(
        'authscreen',
        style: TextStyle(
          fontSize: 50,
        ),
      ),
    );
  }
}
