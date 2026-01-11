import 'package:flutter/material.dart';
import 'package:internship_project_template/view/screen/home/home_screen.dart';

class PaywallViewModel extends ChangeNotifier {
  int _selectedIndex = 0; // Yıllık, aylık seçimi
  bool _isLoading = false;

  int get selectedIndex => _selectedIndex;
  bool get isLoading => _isLoading;

  void selectPlan(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  Future<void> purchase(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    // Gerçek bir ödeme işlemi gibi 1.5 saniye bekletilecek
    await Future.delayed(const Duration(milliseconds: 1500));

    _isLoading = false;
    notifyListeners();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Hoşgeldin Premium Üye!"),
          backgroundColor: Colors.black,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false,
      );
    }
  }

  void closePaywall(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false,
    );
  }
}