import 'package:flutter/material.dart';
import 'package:internship_project_template/view/screen/home/action_screen.dart';
import 'package:internship_project_template/view/screen/home/dashboard_screen.dart';
import 'package:internship_project_template/view/screen/home/profile_screen.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/home_viewmodel.dart';
import '../../widget/home/home_app_bar.dart';
import '../../widget/home/home_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,

        body: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return Scaffold(
              appBar: const HomeAppBar(),
              backgroundColor: Colors.transparent,
              body: IndexedStack(
                index: viewModel.currentIndex,
                children: [
                  DashboardScreen(viewModel: viewModel),
                  const ActionScreen(),
                  const ProfileScreen(),
                ],
              ),
            );
          },
        ),

        bottomNavigationBar: Consumer<HomeViewModel>(
          builder: (context, viewModel, child) {
            return HomeBottomNavBar(
              currentIndex: viewModel.currentIndex,
              onTap: (index) => viewModel.setIndex(index),
            );
          },
        ),
      ),
    );
  }
}