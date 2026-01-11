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
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}