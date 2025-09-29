import 'package:get/get.dart';

import '../../../../presentation/select_address/controllers/select_address.controller.dart';

class SelectAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectAddressController>(
      () => SelectAddressController(),
    );
  }
}
