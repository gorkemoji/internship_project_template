import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constant/application_colors.dart';

enum AiState { connecting, listening, thinking, speaking } // UI için enum durumları

class AiCallViewModel extends ChangeNotifier {
  AiState _aiState = AiState.connecting;
  bool _isMicMuted = false;
  bool _isSpeakerOn = false;

  bool _isCallEnded = false;
  bool get isCallEnded => _isCallEnded;

  Timer? _timer;
  int _secondsCounter = 0;

  bool _isPremium = false;
  int _dailySecondsLeft = 120;
  bool _isLoadingData = true;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  AiState get aiState => _aiState;
  bool get isMicMuted => _isMicMuted;
  bool get isSpeakerOn => _isSpeakerOn;
  bool get isLoadingData => _isLoadingData;
  bool get isPremium => _isPremium;

  String get durationString {
    final minutes = (_secondsCounter ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsCounter % 60).toString().padLeft(2, '0');
    return "$minutes:$seconds";
  }

  AiCallViewModel() {
    _initCall();
  }

  Future<void> _initCall() async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        final doc = await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          _isPremium = data['isPremium'] ?? false;
          _dailySecondsLeft = data['dailySecondsLeft'] ?? 120;

          if (!_isPremium && _dailySecondsLeft <= 0) {
            _secondsCounter = 0;
          } else {
            _secondsCounter = _isPremium ? 0 : _dailySecondsLeft;
          }
        }
      } catch (e) {
        debugPrint("Veri çekme hatası: $e");
      }
    }

    _isLoadingData = false;
    notifyListeners();

    _startSimulation();
  }

  void _startSimulation() async {
    if (_isLoadingData) return;

    if (!_isPremium && _dailySecondsLeft <= 0) {
      return;
    }

    await Future.delayed(const Duration(milliseconds: 1500)); // Varsayılan olarak 1.5 saniye verilmiştir
    _aiState = AiState.speaking;
    notifyListeners();

    _startTimer();

    Future.delayed(const Duration(seconds: 3), () {
      if (_aiState != AiState.connecting && _aiState != AiState.thinking) {
        _aiState = AiState.listening;
        notifyListeners();
      }
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_isPremium) {
        // Premium planda süre değişkeni sayaç gibi ileri akacaktır
        _secondsCounter++;
      } else {
        // Ücretsiz planda ise veritabanındaki kalan süreye göre sayaç geriye akacaktır
        _secondsCounter--;

        if (_secondsCounter <= 0) {
          _timer?.cancel();
          _secondsCounter = 0;
        }
      }
      notifyListeners();
    });
  }

  void toggleMute() {
    _isMicMuted = !_isMicMuted;
    notifyListeners();
  }

  void toggleSpeaker() {
    _isSpeakerOn = !_isSpeakerOn;
    notifyListeners();
  }

  void endCall(BuildContext context) {
    if (_isCallEnded) return;
    _isCallEnded = true;

    _finishCallAndSave(context, timeRanOut: false);
  }

  void endCallAutomatically(BuildContext context) {
    if (_isCallEnded) return;
    _isCallEnded = true;

    _finishCallAndSave(context, timeRanOut: true);
  }

  void _finishCallAndSave(BuildContext context, {required bool timeRanOut}) {
    _timer?.cancel();

    const int xpEarned = 50;
    _updateDatabaseOnExit(points: xpEarned);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => _buildSummaryDialog(context, xpEarned, timeRanOut),
    );
  }

  Future<void> _updateDatabaseOnExit({int points = 0}) async {
    final user = _auth.currentUser;
    if (user == null) return;

    Map<String, dynamic> updates = {};

    if (points > 0) {
      updates['points'] = FieldValue.increment(points);
    }

    if (!_isPremium) {
      int finalTime = _secondsCounter < 0 ? 0 : _secondsCounter;
      updates['dailySecondsLeft'] = finalTime;
    }

    try {
      await _firestore.collection('users').doc(user.uid).update(updates);
      debugPrint("Veritabanı güncellendi. Kalan Süre: $_secondsCounter");
    } catch (e) {
      debugPrint("DB Güncelleme Hatası: $e");
    }
  }

  Widget _buildSummaryDialog(BuildContext context, int xpEarned, bool timeRanOut) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: timeRanOut ? Colors.orange.withValues(alpha: 0.1) : Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                  timeRanOut ? Icons.timer_off : Icons.check_circle,
                  color: timeRanOut ? Colors.orange : Colors.green,
                  size: 48
              ),
            ),
            const SizedBox(height: 16),

            Text(
              timeRanOut ? "Süren Doldu!" : "Harika Konuşma!",
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(
              timeRanOut
                  ? "Günlük ücretsiz konuşma hakkını doldurdun. Yarın görüşürüz!"
                  : "Pratik yaparak kendini geliştirmeye devam ediyorsun.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 18),
            ),
            const SizedBox(height: 24),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.flash_on, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text(
                    "+$xpEarned XP Kazandın",
                    style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ApplicationColors.accent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text("Ana Ekrana Dön", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}