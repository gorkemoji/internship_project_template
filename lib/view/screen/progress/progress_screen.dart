import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/progress_viewmodel.dart';
import '../../widget/progress/leaderboard_list.dart';
import '../../widget/progress/progress_header.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProgressViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProgressViewModel>(
          builder: (context, viewModel, child) {
            return Column(
              children: [
                ProgressHeader(viewModel: viewModel),

                Expanded(
                  child: LeaderboardList(viewModel: viewModel),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}