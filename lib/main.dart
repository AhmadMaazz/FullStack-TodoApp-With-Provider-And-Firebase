import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/contexts/user.context.dart';
import 'package:fullstack_todo_app/provider/todo_provider.dart';
import 'package:fullstack_todo_app/screens/addtask_screen.dart';
import 'package:fullstack_todo_app/screens/auth_screen.dart';
import 'package:fullstack_todo_app/screens/home_screen.dart';
import 'package:fullstack_todo_app/screens/login_screen.dart';
import 'package:fullstack_todo_app/screens/logout_screen.dart';
import 'package:fullstack_todo_app/screens/splash_screen.dart';
import 'package:fullstack_todo_app/screens/start_screen.dart';
import 'package:fullstack_todo_app/screens/taskdetails_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoProvider(),
      child: const MyApp(),
    ),
  );
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
        '/': (context) => const SplashScreen(),
        '/startscreen': (context) => const StartScreen(),
        '/authstatechecker': (context) => const AuthStateChecker(),
        '/authscreen': (context) => const AuthScreen(),
        '/loginscreen': (context) => const LogInScreen(),
        '/homescreen': (context) => const HomeScreen(),
        '/addtaskscreen': (context) => const AddTaskScreen(),
        // '/tastdetailscreen': (context) => const TaskDetailScreen(),
        '/logoutscreen': (context) => const LogoutScreen(),
      },
      initialRoute: '/',
    );
  }
}
