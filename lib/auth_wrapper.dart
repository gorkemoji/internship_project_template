import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship_project_template/view/screen/onboarding/onboarding_screen.dart';
import 'package:internship_project_template/view/screen/paywall/paywall_screen.dart';

import 'constant/application_colors.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(body: Center(child: CircularProgressIndicator(color: ApplicationColors.accent,)));
        }

        if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text("Bir hata oluştu")));
        }

        if (snapshot.hasData) {
          return const PaywallScreen(); // HomeScreen olarak değişebilir. Şuanlık giriş yapmış kullanıcı Paywall'a yönlendirilecektir.
        } else {
          return const OnboardingScreen(); // Giriş yapmamış kullanıcı ise OnboardingScreen'a yönlendirilip uygulama tanıtımını izleyecektir.
        }
      },
    );
  }
}