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
          return const HomeScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:fullstack_todo_app/screens/start_screen.dart';
// import 'package:lottie/lottie.dart';

// import '../firebase/firebase.utils.dart';
// import 'auth_screen.dart';
// import 'home_screen.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Auth().authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {

//           return _buildLoadingScreen(context);
//         } else if (snapshot.hasData) {
//           // User is authenticated, navigate to HomeScreen
//           return HomeScreen();
//         } else {
//           // User is not authenticated, navigate to AuthScreen
//           return const AuthScreen();
//         }
//       },
//     );
//   }

//   Widget _buildLoadingScreen(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: const Alignment(-1.0, -1.0),
//             end: const Alignment(1.0, 1.0),
//             colors: [
//               const Color(0xffEFBBD3),
//               Theme.of(context).colorScheme.secondary,
//             ], // Specify the colors you want for the gradient
//             // You can also add stops to control the color distribution
//             stops: const [
//               0.2,
//               1
//             ], // Stops for the colors, ranging from 0.0 to 1.0
//           ),
//         ),
//         child: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Lottie.asset(
//             'assets/animation/animation_lkvkmkg2.json',
//             width: 220,
//             height: 220,
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future:
//           Future.delayed(const Duration(seconds: 5)), // Add a 5-second delay
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Display the loading screen during the delay
//           return _buildLoadingScreen(context);
//         } else {
//           // After the delay, use StreamBuilder to check authentication state
//           return StreamBuilder(
//             stream: Auth().authStateChanges,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 // Display a loading indicator or splash screen animation
//                 return _buildLoadingScreen(context);
//               } else if (snapshot.hasData) {
//                 // User is authenticated, navigate to HomeScreen
//                 return HomeScreen();
//               } else {
//                 // User is not authenticated, navigate to AuthScreen
//                 return const StartScreen();
//               }
//             },
//           );
//         }
//       },
//     );
//   }

//   Widget _buildLoadingScreen(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: const Alignment(-1.0, -1.0),
//             end: const Alignment(1.0, 1.0),
//             colors: [
//               const Color(0xffEFBBD3),
//               Theme.of(context).colorScheme.secondary,
//             ],
//             stops: const [0.2, 1],
//           ),
//         ),
//         child: FittedBox(
//           fit: BoxFit.scaleDown,
//           child: Lottie.asset(
//             'assets/animation/animation_lkvkmkg2.json',
//             width: 220,
//             height: 220,
//           ),
//         ),
//       ),
//     );
//   }
// }

