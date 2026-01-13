import 'package:flutter/material.dart';
import '../../../../constant/application_colors.dart';

class HomeBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const HomeBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          border: Border.all(color: Colors.black.withValues(alpha: 0.15)),
          /*boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],*/
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: MediaQuery.removePadding(
            context: context,
            removeBottom: true,
            child: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: onTap,
              backgroundColor: Colors.white,
              selectedItemColor: ApplicationColors.accent,
              unselectedItemColor: Colors.grey.shade400,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              items: [
                _buildNavItem(Icons.home_rounded, Icons.home_outlined, "Anasayfa", 0),
                _buildNavItem(Icons.insert_drive_file_rounded, Icons.insert_drive_file_outlined, "Rapor", 1),
                _buildNavItem(Icons.person_rounded, Icons.person_outline, "Profil", 2),
              ],
            ),
          )
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(IconData activeIcon, IconData inactiveIcon, String label, int index) {
    bool isSelected = currentIndex == index;
    return BottomNavigationBarItem(
      icon: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: isSelected
            ? BoxDecoration(
          color: ApplicationColors.accent.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        )
            : const BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          isSelected ? activeIcon : inactiveIcon,
          size: 28,
        ),
      ),
      label: label,
    );
  }
}