import 'package:flutter/material.dart';
import 'package:internship_project_template/constant/application_colors.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../viewmodel/onboarding_viewmodel.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => OnboardingViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<OnboardingViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () => viewModel.skipOrComplete(context),
                        child: const Text(
                          "Atla",
                          style: TextStyle(
                            fontSize: 20,
                            color: ApplicationColors.accent,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: PageView.builder(
                        controller: viewModel.pageController,
                        itemCount: viewModel.pages.length,
                        onPageChanged: viewModel.setIndex,
                        itemBuilder: (context, index) {
                          final page = viewModel.pages[index];
                          return Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                      page.image,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  page.title,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                Text(
                                  page.description,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SmoothPageIndicator(
                            controller: viewModel.pageController,
                            count: viewModel.pages.length,
                            effect: const ExpandingDotsEffect(
                              activeDotColor: ApplicationColors.accent,
                              dotColor: Colors.grey,
                              dotHeight: 8,
                              dotWidth: 8,
                              spacing: 8,
                            ),
                          ),

                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: ApplicationColors.accent.withValues(alpha: 0.35),
                                  blurRadius: 7,
                                  spreadRadius: 1,
                                )
                              ],
                            ),
                            child: FloatingActionButton(
                              onPressed: () {
                                if (viewModel.currentIndex == viewModel.pages.length - 1) {
                                  viewModel.skipOrComplete(context);
                                } else {
                                  viewModel.nextPage();
                                }
                              },
                              backgroundColor: ApplicationColors.accent,
                              shape: const CircleBorder(),
                              elevation: 0,
                              highlightElevation: 0,
                              child: Icon(
                                viewModel.currentIndex == viewModel.pages.length - 1
                                    ? Icons.check
                                    : Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}