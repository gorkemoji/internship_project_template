import 'package:flutter/material.dart';
import 'package:internship_project_template/model/onboarding_model.dart';

import '../view/screen/auth/login_screen.dart';

class OnboardingViewModel extends ChangeNotifier {
  final PageController pageController = PageController();
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  final List<OnboardingModel> _pages = [
    OnboardingModel(
      image: 'assets/images/onboarding_1.png',
      title: "hilingo'ya Hoş Geldiniz!",
      description: "hilinho ile dil becerilerini istediğin zaman, istediğin yerde kolayca geliştir.",
    ),
    OnboardingModel(
      image: 'assets/images/onboarding_2.png',
      title: "Harika ilerliyorsunuz!",
      description: "Dil öğrenme yolculuğunuzda ilk adımı attınız. Hadi üye olup yeni keşiflere başlayalım!",
    ),
  ];

  List<OnboardingModel> get pages => _pages;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void skipOrComplete(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }
}