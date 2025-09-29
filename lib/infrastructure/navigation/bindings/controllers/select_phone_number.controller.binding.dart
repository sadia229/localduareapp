import 'package:get/get.dart';

import '../../../../presentation/select_phone_number/controllers/select_phone_number.controller.dart';

class SelectPhoneNumberControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectPhoneNumberController>(
      () => SelectPhoneNumberController(),
    );
  }
}
