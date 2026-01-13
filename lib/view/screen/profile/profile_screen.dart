import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../viewmodel/profile_viewmodel.dart';
import '../../widget/home/home_soon_bottom_sheet.dart';
import '../../widget/profile/edit_profile_bottom_sheet.dart';
import '../../widget/profile/menu_tile.dart';
import '../../widget/profile/premium_promo_card.dart';
import '../../widget/profile/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return StreamBuilder<DocumentSnapshot>(
              stream: viewModel.userStream,
              builder: (context, snapshot) {
                String username = "Kullanıcı";
                String email = "";
                bool isPremium = false;

                if (snapshot.hasData && snapshot.data!.exists) {
                  final data = snapshot.data!.data() as Map<String, dynamic>;
                  username =  data['username'] ?? "Kullanıcı";
                  email = data['email'] ?? "";
                  isPremium = data['isPremium'] ?? false;
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      ProfileHeader(
                        username: username,
                        email: email,
                        isPremium: isPremium,
                      ),

                      const SizedBox(height: 20),

                      if (!isPremium) const PremiumPromoCard(),

                      const SizedBox(height: 20),

                      ProfileMenuTile(
                        title: "Profili Düzenle",
                        icon: Icons.edit,
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            builder: (_) => ChangeNotifierProvider.value(
                              value: viewModel,
                              child: EditProfileSheet(currentUsername: username),
                            ),
                          );
                        },
                      ),
                      ProfileMenuTile(
                        title: "Bildirim Ayarları",
                        icon: Icons.notifications,
                        onTap: () => _showComingSoon(context),
                      ),
                      ProfileMenuTile(
                        title: "Dil Seçenekleri",
                        icon: Icons.language,
                        onTap: () => _showComingSoon(context),
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Divider(color: Colors.grey.shade100),
                      ),

                      ProfileMenuTile(
                        title: "Çıkış Yap",
                        icon: Icons.logout,
                        iconColor: Colors.red,
                        textColor: Colors.red,
                        showArrow: false,
                        onTap: () => _showLogoutDialog(context, viewModel),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, ProfileViewModel viewModel) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          "Çıkış Yap",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24
          ),
        ),
        content: const Text(
          "Hesabından çıkış yapmak istediğine emin misin?",
          style: TextStyle(fontSize: 16),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("İptal", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              viewModel.signOut(context);
            },
            child: const Text("Çıkış Yap", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}