import 'package:flutter/material.dart';
import 'package:internship_project_template/view/widget/paywall/feature_item.dart';
import 'package:provider/provider.dart';
import '../../../constant/application_colors.dart';
import '../../../viewmodel/paywall_viewmodel.dart';
import '../../widget/paywall/plan_card.dart';
import '../../widget/shadow_button.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PaywallViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<PaywallViewModel>(
          builder: (context, viewModel, child) {
            return SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                        icon: const Icon(Icons.close, size: 30, color: ApplicationColors.accent),
                        onPressed: () => viewModel.closePaywall(context),
                      ),
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/lingo.png',
                            width: 150,
                            height: 150,
                          ),
                          const SizedBox(height: 24),

                          const Text(
                            "hilingo: Premium Paket",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),

                          const Text(
                            "Sınırları kaldır, dilleri daha hızlı öğren!",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),

                          const SizedBox(height: 32),

                          const FeatureItem(icon: Icons.block, text: "Reklamsız deneyim"),
                          const FeatureItem(icon: Icons.auto_awesome, text: 'Yapay zeka ile sınırsız konuşma'),
                          const FeatureItem(icon: Icons.download, text: "Çevrimdışı öğrenim modu"),

                          const SizedBox(height: 40),

                          PlanCard(
                            title: "Yıllık Plan",
                            price: "₺399,99 / Yıl",
                            subtitle: "Aylık sadece ₺33,33",
                            badge: "%60 İndirim",
                            isSelected: viewModel.selectedIndex == 0,
                            onTap: () => viewModel.selectPlan(0),
                          ),

                          const SizedBox(height: 16),

                          PlanCard(
                            title: "Aylık Plan",
                            price: "₺89,99 / Ay",
                            subtitle: "İstediğin zaman iptal et",
                            isSelected: viewModel.selectedIndex == 1,
                            onTap: () => viewModel.selectPlan(1),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          "7 gün ücretsiz deneme, sonrasında otomatik yenilenir.",
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                        const SizedBox(height: 12),
                        ShadowButton(
                          text: viewModel.selectedIndex == 0
                              ? "Ücretsiz Dene ve Abone Ol"
                              : "Abone Ol",
                          isLoading: viewModel.isLoading,
                          onPressed: () => viewModel.purchase(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}