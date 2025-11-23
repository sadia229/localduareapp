import 'package:get/get.dart';

import '../../../../presentation/order_history_details/controllers/order_history_details.controller.dart';

class OrderHistoryDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryDetailsController>(
      () => OrderHistoryDetailsController(),
    );
  }
}
