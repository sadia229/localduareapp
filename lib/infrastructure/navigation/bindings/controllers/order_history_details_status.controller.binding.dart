import 'package:get/get.dart';

import '../../../../presentation/order_history_details_status/controllers/order_history_details_status.controller.dart';

class OrderHistoryDetailsStatusControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryDetailsStatusController>(
      () => OrderHistoryDetailsStatusController(),
    );
  }
}
