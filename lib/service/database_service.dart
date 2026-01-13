import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveUser(String uid, String username, String email) async {
    await _firestore.collection('users').doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'level': 'Başlangıç',
      'points': 0,
      'streak': 1,
      'isPremium': false,
      'planType': 'free',
      'dailySecondsLeft': 120,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Kullanıcıyı Premium yapar
  Future<void> upgradeToPremium(String uid, String planType) async {
    await _firestore.collection('users').doc(uid).update({
      'isPremium': true,
      'planType': planType,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Kullanıcının Premium olup olmadığını kontrol eder
  Future<bool> isUserPremium(String uid) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();

      if (doc.exists) {
        final data = doc.data() as Map<String, dynamic>?;
        return data?['isPremium'] == true;
      }
      return false;
    } catch (e) {
      print("Premium kontrol hatası: $e");
      return false;
    }
  }

  Stream<DocumentSnapshot> getUserStream(String uid) {
    return _firestore.collection('users').doc(uid).snapshots();
  }
}