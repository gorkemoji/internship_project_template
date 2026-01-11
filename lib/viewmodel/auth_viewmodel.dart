import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:internship_project_template/view/screen/home/home_screen.dart';
import '../service/auth_service.dart';
import '../service/database_service.dart';
import '../view/screen/paywall/paywall_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> login(BuildContext context, String email, String password) async {
    _setLoading(true);
    try {
      UserCredential userCredential = await _authService.signIn(email, password);

      if (context.mounted) {
        if (userCredential.user != null) {
          await _navigateToNext(context, userCredential.user!.uid);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        _showError(context, e.message ?? "Bir hata oluştu");
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<UserCredential?> logInWithGoogle() async {
    _isLoading = true;
    notifyListeners();

    final userCredential = await _authService.signInWithGoogle();

    _isLoading = false;
    notifyListeners();

    return userCredential;
  }

  Future<void> register(BuildContext context, String name, String email, String password) async {
    _setLoading(true);
    try {
      UserCredential userCredential = await _authService.signUp(email, password);

      if (userCredential.user != null) {
        await _databaseService.saveUser(
          userCredential.user!.uid,
          name,
          email
        );
      }

      if (userCredential.user != null) {
        await _navigateToNext(context, userCredential.user!.uid);
      }
    } on FirebaseAuthException catch (e) {
      _showError(context, e.message ?? "Kayıt hatası");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _navigateToNext(BuildContext context, String uid) async {
    bool isPremium = await _databaseService.isUserPremium(uid);

    if (context.mounted) {
      if (isPremium) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
              (route) => false,
        );
      } else {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const PaywallScreen()), (route) => false
        );
      }
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }
}