import 'package:get/get.dart';

import '../../../../presentation/profile_add_address/controllers/profile_add_address.controller.dart';

class ProfileAddAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileAddAddressController>(
      () => ProfileAddAddressController(),
    );
  }
}
