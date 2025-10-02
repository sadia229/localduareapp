import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../infrastructure/navigation/routes.dart';

class GetStartedController extends GetxController {
  //TODO: Implement GetStartedController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    debugPrint("Access Token $token");
    if (token != null) {
      Get.toNamed(Routes.BOTTOM_NAVBAR);
    } else {
      Get.toNamed(Routes.SELECT_PHONE_NUMBER);
    }
  }
}
