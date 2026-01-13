import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProgressViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  // 1. Kullanıcının Kendi Verisi (Header İçin)
  Stream<DocumentSnapshot>? get myUserStream {
    if (currentUserId == null) return null;
    return _firestore.collection('users').doc(currentUserId).snapshots();
  }

  // 2. Liderlik Tablosu Verisi (Liste İçin)
  // Puanına göre en yüksekten en düşüğe ilk 50 kişiyi getirir
  Stream<QuerySnapshot> get leaderboardStream {
    return _firestore
        .collection('users')
        .orderBy('points', descending: true)
        .limit(50)
        .snapshots();
  }

  // Yardımcı Metot: Kullanıcının kendi satırı mı kontrolü
  bool isMe(String userId) {
    return userId == currentUserId;
  }
}