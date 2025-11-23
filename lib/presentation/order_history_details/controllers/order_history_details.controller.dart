import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../infrastructure/data/model/order_history_model.dart';

class OrderHistoryDetailsController extends GetxController {
  final orderId = "".obs;
  final orderDate = "".obs;
  final shopName = "".obs;
  final subtotal = 0.obs;
  final deliveryCharge = 0.obs;
  final total = 0.obs;
  final orderItems = <Item>[].obs;
  final paymentMethod = "".obs;
  final paymentStatus = "".obs;
  final status = "".obs;

  @override
  void onInit() {
    orderId.value = Get.arguments['orderId'] ?? "";
    orderDate.value = Get.arguments['orderDate'] ?? "";
    shopName.value = Get.arguments['shopName'] ?? "";
    subtotal.value = Get.arguments['subtotal'] ?? 0;
    deliveryCharge.value = Get.arguments['deliveryCharge'] ?? 0;
    total.value = Get.arguments['total'] ?? 0;
    orderItems.value = Get.arguments['orderItems'] ?? [];
    paymentMethod.value = Get.arguments['payment_method'] ?? "";
    paymentStatus.value = Get.arguments['payment_status'] ?? "";
    status.value = Get.arguments['status'] ?? "";
    super.onInit();
  }
  String formatOrderDate(String isoDate) {
    final date = DateTime.parse(isoDate).toLocal();
    final formatter = DateFormat('dd MMM, hh:mm a');
    return formatter.format(date);
  }
}
