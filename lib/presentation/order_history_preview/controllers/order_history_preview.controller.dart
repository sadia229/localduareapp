import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrderHistoryPreviewController extends GetxController {
  //TODO: Implement OrderHistoryPreviewController

  final count = 0.obs;
  final orderId = "".obs;
  @override
  void onInit() {
    orderId.value = Get.arguments["orderId"];
    debugPrint(orderId.value.toString());
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
