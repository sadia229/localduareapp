import 'package:get/get.dart';

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
    Get.offAllNamed(Routes.GET_STARTED);
  }
}
