import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../infrastructure/theme/app.colors.dart';
import '../coming_soon/coming_soon.screen.dart';
import '../home/home.screen.dart';
import '../leadboard/leadboard.screen.dart';
import '../order_history/order_history.screen.dart';
import '../profile/profile.screen.dart';
import 'controllers/bottom_navbar.controller.dart';

class BottomNavbarScreen extends GetView<BottomNavbarController> {
  const BottomNavbarScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Exit the app?'),
                content:
                    const Text('Confirm whether you want to exit the app।'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text('No'),
                  ),
                  TextButton(
                    onPressed: () => SystemNavigator.pop(),
                    child: const Text('Yes'),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Main Content
            Obx(() {
              controller.currentIndex.value;
              return PageView(
                controller: controller.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const HomeScreen(),
                  const OrderHistoryScreen(),
                  // const LeadboardScreen(),
                  const ComingSoonScreen(),
                  const ProfileScreen(),
                ],
              );
            }),

            // Bottom Navigation Bar
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: _buildBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Obx(() => SafeArea(
      child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: controller.bottomBarHeight.value,
            margin: EdgeInsets.only(
              left: 12.0,
              right: 12.0,
              bottom: 20,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, 'assets/images/home-icon.png',
                    'assets/images/home-icon.png', 'Home'),
                _buildNavItem(1, 'assets/images/order-history-icon.png',
                    'assets/images/order-history-icon.png', 'Order'),
                _buildNavItem(2, 'assets/images/leaderboard-icon.png',
                    'assets/images/leaderboard-icon.png', 'Leadboard'),
                _buildNavItem(3, 'assets/images/profile-icon.png',
                    'assets/images/profile-icon.png', 'Account'),
              ],
            ),
          ),
    ));
  }

  Widget _buildNavItem(
      int index, String iconPath, String selectedIconPath, String label) {
    final isSelected = controller.currentIndex.value == index;
    final color = isSelected ? Colors.white.withOpacity(0.8) : Colors.grey;
    final iconSize = isSelected
        ? controller.selectedIconSize.value
        : controller.iconSize.value;

    return GestureDetector(
      onTap: () => controller.changePage(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color:
              isSelected ? AppColors.light.buttonGradient1 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: iconSize,
              height: iconSize,
              child: Image.asset(
                isSelected ? selectedIconPath : iconPath,
                color: color,
                fit: BoxFit.contain,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.manrope(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
