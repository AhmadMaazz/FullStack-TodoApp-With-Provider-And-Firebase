import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToStartScreenAfterDelay();
  }

  void _navigateToStartScreenAfterDelay() {
    // Wait for 5 seconds using Future.delayed
    Future.delayed(const Duration(seconds: 5), () {
      // Navigate to the start screen and replace the splash screen route
      Navigator.pushReplacementNamed(context, '/startscreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-1.0, -1.0),
            end: const Alignment(1.0, 1.0),
            colors: [
              const Color(0xffEFBBD3),
              Theme.of(context).colorScheme.secondary,
            ], // Specify the colors you want for the gradient
            // You can also add stops to control the color distribution
            stops: const [
              0.2,
              1
            ], // Stops for the colors, ranging from 0.0 to 1.0
          ),
        ),
        child: Lottie.asset(
          'assets/animation/animation_lkvkmkg2.json',
          
        ),
      ),
    );
  }
}
