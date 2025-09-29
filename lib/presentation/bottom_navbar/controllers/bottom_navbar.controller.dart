
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:localduareapp/presentation/home/home.screen.dart';
import 'package:localduareapp/presentation/order_history/order_history.screen.dart';
import 'package:localduareapp/presentation/leadboard/leadboard.screen.dart';
import 'package:localduareapp/presentation/profile/profile.screen.dart';

class BottomNavbarController extends GetxController {
  final RxInt currentIndex = 0.obs;
  final PageController pageController = PageController();
  final List<Widget> screens = [];

  // For animation
  final RxDouble bottomBarHeight = 70.0.obs;
  final RxDouble iconSize = 24.0.obs;
  final RxDouble selectedIconSize = 28.0.obs;

  @override
  void onInit() {
    super.onInit();
    final screens = [
      const HomeScreen(),
      const OrderHistoryScreen(),
      const LeadboardScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void changePage(int index) {
    currentIndex.value = index;
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    // Animate the bottom bar
    _animateBottomBar();
  }

  void _animateBottomBar() {
    // Reset sizes
    bottomBarHeight.value = 65.0;
    iconSize.value = 22.0;
    selectedIconSize.value = 26.0;
    
    // Animate
    Future.delayed(const Duration(milliseconds: 100), () {
      bottomBarHeight.value = 75.0;
      iconSize.value = 24.0;
      selectedIconSize.value = 28.0;
    });
  }

}
