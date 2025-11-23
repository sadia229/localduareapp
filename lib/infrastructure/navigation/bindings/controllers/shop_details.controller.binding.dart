import 'package:get/get.dart';

import '../../../../presentation/shop_details/controllers/shop_details.controller.dart';

class ShopDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShopDetailsController>(
      () => ShopDetailsController(),
    );
  }
}
