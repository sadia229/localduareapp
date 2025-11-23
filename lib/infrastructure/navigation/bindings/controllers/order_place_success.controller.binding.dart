import 'package:get/get.dart';

import '../../../../presentation/order_place_success/controllers/order_place_success.controller.dart';

class OrderPlaceSuccessControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderPlaceSuccessController>(
      () => OrderPlaceSuccessController(),
    );
  }
}
