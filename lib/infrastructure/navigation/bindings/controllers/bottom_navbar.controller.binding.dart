import 'package:get/get.dart';

import '../../../../presentation/bottom_navbar/controllers/bottom_navbar.controller.dart';

class BottomNavbarControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavbarController>(
      () => BottomNavbarController(),
    );
  }
}
