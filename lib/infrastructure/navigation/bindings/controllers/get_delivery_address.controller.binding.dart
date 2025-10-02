import 'package:get/get.dart';

import '../../../../presentation/get_delivery_address/controllers/get_delivery_address.controller.dart';

class GetDeliveryAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetDeliveryAddressController>(
      () => GetDeliveryAddressController(),
    );
  }
}
