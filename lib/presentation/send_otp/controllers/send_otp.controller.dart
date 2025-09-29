import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SendOtpController extends GetxController {
  final otpCode = "".obs;
  final otpController = TextEditingController();
  final phoneNumber = "".obs;
  @override
  void onInit() {
    super.onInit();
    phoneNumber.value = Get.arguments["phoneNumber"];
    debugPrint("print phone number:${phoneNumber.value}");
  }

  @override
  void onReady() {
    super.onReady();
  }
}
