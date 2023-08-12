import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/firebase/firebase.utils.dart';
import 'package:fullstack_todo_app/screens/auth_screen.dart';
import 'package:fullstack_todo_app/screens/home_screen.dart';

class AuthStateChecker extends StatefulWidget {
  const AuthStateChecker({super.key});

  @override
  State<AuthStateChecker> createState() => _AuthStateCheckerState();
}

class _AuthStateCheckerState extends State<AuthStateChecker> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
