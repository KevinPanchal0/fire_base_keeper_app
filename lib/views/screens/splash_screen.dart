// ignore_for_file: library_private_types_in_public_api

import 'package:fire_base_keeper_app/utils/prefs/auth_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // For animations (optional)

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late bool isLoggedIn;
  @override
  void initState() {
    super.initState();
    loadPrefs();
    navigateToHome();
  }

  loadPrefs() async {
    isLoggedIn = await AuthPreferences.getLoginState();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Show splash for 3 seconds
    Navigator.pushReplacementNamed(
        context, isLoggedIn ? '/' : 'sign_in_page'); // Navigate to Home
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo/splash_logo.png', // Your logo path
              height: 150,
            ),
            SizedBox(height: 20),
            SpinKitThreeBounce(
                color: Colors.blue, size: 20.0), // Optional animation
          ],
        ),
      ),
    );
  }
}
