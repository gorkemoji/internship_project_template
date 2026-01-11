import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../service/database_service.dart';

class HomeViewModel extends ChangeNotifier {
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Stream<DocumentSnapshot>? userStream;

  HomeViewModel() {
    _init();
  }

  void _init() {
    final user = _auth.currentUser;
    if (user != null) {
      userStream = _databaseService.getUserStream(user.uid);
    }
  }
}