import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/navigation/routes.dart';

class SplashController extends GetxController {
  final count = 0.obs;
  final int splashDuration = 2;

  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: splashDuration));
    checkToken();
  }

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    debugPrint("Access Token $token");
    if (token != null) {
      // Get.toNamed(Routes.BOTTOM_NAVBAR);
      Get.toNamed(Routes.SELECT_ADDRESS);
    } else {
      Get.toNamed(Routes.SELECT_PHONE_NUMBER);
    }
  }
}
