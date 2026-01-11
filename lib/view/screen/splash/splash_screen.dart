import 'package:flutter/material.dart';

import '../../../auth_wrapper.dart';
import '../../../constant/application_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _navigateToNextScreen();
  }

  _navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 3));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const AuthWrapper()
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.asset(
              'assets/images/icon.jpeg',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 24),*/
            const CircularProgressIndicator(
              color: ApplicationColors.accent,
            )
          ],
        ),
      ),
    );
  }
}