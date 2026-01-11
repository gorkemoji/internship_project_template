import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';

class FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const FeatureItem({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(icon, color: ApplicationColors.accent, size: 24),

          const SizedBox(width: 16),

          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ApplicationColors.accent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}