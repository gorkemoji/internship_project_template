import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internship_project_template/view/widget/home/home_soon_bottom_sheet.dart';
import '../../../viewmodel/home_viewmodel.dart';
import '../../widget/home/home_ai_card.dart';
import '../../widget/home/home_lesson_card.dart';

class DashboardScreen extends StatelessWidget {
  final HomeViewModel viewModel;

  const DashboardScreen({super.key, required this.viewModel});

  void _showComingSoon(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const HomeSoonBottomSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: viewModel.userStream,
      builder: (context, snapshot) {
        String userName = "Kullanıcı";
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          userName = data['username'] ?? "Kullanıcı";
        }

        return ListView(
          padding: const EdgeInsets.only(
              top: 20, left: 20, right: 20, bottom: 120),
          children: [
            Text(
              "Merhaba, $userName!",
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Bugün ne öğrenmek istersin?",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 30),

            HomeAiCard(
              onTap: () => _showComingSoon(context),
            ),

            const SizedBox(height: 30),
            const Text("Courses",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),

            HomeLessonCard(
              icon: Icons.waving_hand,
              title: "Unit 1",
              subtitle: "Introducing Yourself",
              color: Colors.blue,
              progress: 0.8,
              onTap: () => _showComingSoon(context),
            ),

            HomeLessonCard(
              icon: Icons.chat,
              title: "Unit 2",
              subtitle: "Daily Life",
              color: Colors.orange,
              progress: 0.3,
              onTap: () => _showComingSoon(context),
            ),
            HomeLessonCard(
              icon: Icons.store,
              title: "Unit 3",
              subtitle: "At the Store",
              color: Colors.purple,
              progress: 0.2,
              onTap: () => _showComingSoon(context),
            ),
            HomeLessonCard(
              icon: Icons.dining,
              title: "Unit 4",
              subtitle: "Food and Dining",
              color: Colors.green,
              progress: 0.1,
              onTap: () => _showComingSoon(context),
            ),

            const SizedBox(height: 100)
          ],
        );
      },
    );
  }
}