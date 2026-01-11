import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/home_viewmodel.dart';
import '../../screen/paywall/paywall_screen.dart';
import 'home_stat_chip.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade200, width: 2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("🇬🇧", style: TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(
              "English",
              style: TextStyle(
                color: Colors.grey.shade700,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      actions: [
        Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return StreamBuilder<DocumentSnapshot>(
              stream: viewModel.userStream,
              builder: (context, snapshot) {
                int streak = 0;
                bool isPremium = false;
                int dailySecondsLeft = 120;

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  streak = data['streak'] ?? 0;
                  isPremium = data['isPremium'] ?? false;
                  dailySecondsLeft = data['dailySecondsLeft'] ?? 120;
                }

                return Row(
                  children: [
                    if (!isPremium) ...[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const PaywallScreen()),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.purple.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                )
                              ]
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.auto_awesome, color: Colors.white, size: 20),
                              SizedBox(width: 4),
                              Text(
                                "PRO",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],

                    StatChip(
                      icon: Icons.local_fire_department,
                      value: streak.toString(),
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),

                    StatChip(
                      icon: Icons.timer,
                      value: isPremium ? "∞" : _formatTime(dailySecondsLeft),
                      color: isPremium ? Colors.purple : Colors.green,
                    ),
                    const SizedBox(width: 16),
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }

  String _formatTime(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}