import 'package:get/get.dart';

import '../../../../presentation/coming_soon/controllers/coming_soon.controller.dart';

class ComingSoonControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ComingSoonController>(
      () => ComingSoonController(),
    );
  }
}
