import 'package:get/get.dart';

import '../../../../presentation/add_address/controllers/add_address.controller.dart';

class AddAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAddressController>(
      () => AddAddressController(),
    );
  }
}
