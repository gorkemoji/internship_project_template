import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';

class HomeSoonBottomSheet extends StatelessWidget {
  const HomeSoonBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 30),

          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: ApplicationColors.accent.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.rocket_launch_rounded,
              color: ApplicationColors.accent,
              size: 40,
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            "Çok Yakında!",
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87
            ),
          ),
          const SizedBox(height: 12),

          const Text(
            "Bu özellik üzerinde çalışıyoruz. En kısa sürede harika bir deneyimle burada olacak!",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey, fontSize: 16, height: 1.5),
          ),

          const SizedBox(height: 32),

          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: ApplicationColors.accent,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Harika, Bekliyorum",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}