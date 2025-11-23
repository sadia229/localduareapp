import 'package:get/get.dart';

import '../../../../presentation/track_order/controllers/track_order.controller.dart';

class TrackOrderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TrackOrderController>(
      () => TrackOrderController(),
    );
  }
}
