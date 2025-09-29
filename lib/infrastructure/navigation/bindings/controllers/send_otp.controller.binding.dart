import 'package:get/get.dart';

import '../../../../presentation/send_otp/controllers/send_otp.controller.dart';

class SendOtpControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendOtpController>(
      () => SendOtpController(),
    );
  }
}
