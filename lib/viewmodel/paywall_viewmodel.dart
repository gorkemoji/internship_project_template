import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internship_project_template/view/screen/home/home_screen.dart';

import '../service/database_service.dart';
import '../view/widget/paywall/premium_success_sheet.dart';

class PaywallViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();

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

    try {
      // Gerçek bir ödeme işlemi gibi 2 saniye bekletilecek
      await Future.delayed(const Duration(milliseconds: 2000));

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await _databaseService.upgradeToPremium(
          user.uid,
          _selectedIndex == 0 ? 'yearly' : 'monthly',
        );
      }

      _isLoading = false;
      notifyListeners();

      if (context.mounted) {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => const PremiumSuccessSheet(),
        );
      }
    } catch (e) {
      _isLoading = false;
      notifyListeners();
    }
  }

  void closePaywall(BuildContext context) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false,
    );
  }
}