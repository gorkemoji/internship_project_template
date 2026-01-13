import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_wrapper.dart';

class ProfileViewModel extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Stream<DocumentSnapshot>? get userStream {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return null;
    return _firestore.collection('users').doc(uid).snapshots();
  }

  Future<void> updateUsername(String newUsername) async {
    final user = _auth.currentUser;
    if (user == null || newUsername.isEmpty) return;

    _setLoading(true);
    try {
      await user.updateDisplayName(newUsername);
      await _firestore.collection('users').doc(user.uid).update({'username': newUsername});
      notifyListeners();
    } catch (e) {
      debugPrint("İsim güncelleme hatası: $e");
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updatePassword(BuildContext context, String newPassword) async {
    final user = _auth.currentUser;
    if (user == null || newPassword.isEmpty) return;

    _setLoading(true);
    try {
      await user.updatePassword(newPassword);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Şifreniz başarıyla güncellendi")),
        );
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      // Firebase güvenlik gereği, şifre değişimi için kullanıcının yakın zamanda giriş yapmış olmasını isteyebilir (requires-recent-login).
      if (e.code == 'requires-recent-login') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Güvenlik gereği yeniden giriş yapmalısınız.")),
          );
          signOut(context);
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Hata: ${e.message}")),
          );
        }
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const AuthWrapper()),
            (route) => false,
      );
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}