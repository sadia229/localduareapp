import 'package:get/get.dart';

import '../../../../presentation/leadboard/controllers/leadboard.controller.dart';

class LeadboardControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LeadboardController>(
      () => LeadboardController(),
    );
  }
}
