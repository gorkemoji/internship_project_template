import 'package:flutter/material.dart';
import '../../../auth_wrapper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // Opaklık kontrolü için gerekli değişken
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    _startSplash();
  }

  Future<void> _startSplash() async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (mounted) {
      setState(() {
        _opacity = 1.0;
      });
    }

    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (_, _, _) => const AuthWrapper(),
          transitionsBuilder: (_, animation, _, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
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
            AnimatedOpacity(
              duration: const Duration(milliseconds: 1000),
              opacity: _opacity,
              curve: Curves.easeIn,
              child: Image.asset(
                'assets/images/lingo.png',
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}