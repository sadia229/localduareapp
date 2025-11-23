import 'package:get/get.dart';

import '../../../../presentation/shop_menu/controllers/shop_menu.controller.dart';

class ShopMenuControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopMenuController>(
      () => ShopMenuController(),
    );
  }
}
