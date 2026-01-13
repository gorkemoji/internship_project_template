import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';
import '../../../viewmodel/progress_viewmodel.dart';
import 'leaderboard_tile.dart';

class LeaderboardList extends StatelessWidget {
  final ProgressViewModel viewModel;

  const LeaderboardList({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const Icon(Icons.shield, color: ApplicationColors.accent),
              const SizedBox(width: 8),
              const Text(
                "Lig",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                "Bu Hafta",
                style: TextStyle(color: Colors.grey.shade500, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: viewModel.leaderboardStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) return const Center(child: Text("Yüklenemedi"));
              if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

              final docs = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.only(bottom: 100),
                itemCount: docs.length,
                itemBuilder: (context, index) {
                  final data = docs[index].data() as Map<String, dynamic>;
                  final userId = docs[index].id;

                  final name = data['name'] ?? data['username'] ?? 'Kullanıcı';
                  final points = data['points'] ?? 0;
                  final isMe = viewModel.isMe(userId);

                  return LeaderboardTile(
                    rank: index + 1,
                    name: name,
                    points: points,
                    isMe: isMe,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}