import 'package:get/get.dart';

import '../../../../presentation/order_history_preview/controllers/order_history_preview.controller.dart';

class OrderHistoryPreviewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderHistoryPreviewController>(
      () => OrderHistoryPreviewController(),
    );
  }
}
