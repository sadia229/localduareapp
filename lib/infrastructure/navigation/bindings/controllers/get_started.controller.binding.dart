import 'package:get/get.dart';

import '../../../../presentation/get_started/controllers/get_started.controller.dart';

class GetStartedControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetStartedController>(
      () => GetStartedController(),
    );
  }
}
