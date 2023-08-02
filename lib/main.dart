import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FullStack Todo App',
      theme: ThemeData(
        primaryColor: const Color(0xffA36F87),
        colorScheme: const ColorScheme.light()
            .copyWith(secondary: const Color(0xffbbf0bc)),
        disabledColor: const Color(0xffCEC3C8),
        fontFamily: 'Urbanist',
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => const StartScreen(),
      },
      initialRoute: '/',
    );
  }
}
