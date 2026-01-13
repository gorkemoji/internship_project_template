import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';
import '../../../viewmodel/progress_viewmodel.dart';
import 'stats_card.dart';

class ProgressHeader extends StatelessWidget {
  final ProgressViewModel viewModel;

  const ProgressHeader({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: viewModel.myUserStream,
      builder: (context, snapshot) {
        int myPoints = 0;
        int myStreak = 0;

        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          myPoints = data['points'] ?? 0;
          myStreak = data['streak'] ?? 0;
        }

        return Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            boxShadow: [
              BoxShadow(
                color: ApplicationColors.grey.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "İlerleme Raporu",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: StatsCard(
                      icon: Icons.leaderboard_rounded,
                      value: "$myPoints XP",
                      label: "Toplam Puan",
                      color: ApplicationColors.accent,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatsCard(
                      icon: Icons.local_fire_department_rounded,
                      value: "$myStreak Gün",
                      label: "Seri",
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}