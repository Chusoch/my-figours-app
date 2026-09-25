import 'dart:async';
import 'package:flutter/material.dart';
import 'intro_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate loading process
    Timer(const Duration(seconds: 7), () {
      if (mounted) {
        // Navigate to Intro Screen after 3 seconds
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const IntroScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF15181A), // Primary Dark
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo
            Image.asset(
              'assets/images/logo1.png',
              width: 120, // Adjust size as needed
              height: 120,
            ),
            // Loading Indicator overlay
            const SizedBox(
              width: 160, // Slightly larger than logo
              height: 160,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.amber,
                ), // Gold color
                strokeWidth: 4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
